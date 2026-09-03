#!/usr/bin/env python3

import base64
import datetime as dt
import http.cookiejar
import json
import re
import sys
import urllib.error
import urllib.parse
import urllib.request
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
APP_CONSTANTS = ROOT / "lib/constants/app_constants.dart"
REPORT_PATH = ROOT / "reports/odoo_api_probe.md"


def read_constants():
    text = APP_CONSTANTS.read_text(encoding="utf-8")
    base_url_match = re.search(r"baseUrl\s*=\s*'([^']+)'", text)
    base_data_match = re.search(r'baseData\s*=\s*"([^"]+)"', text)
    if not base_url_match or not base_data_match:
        raise RuntimeError("Could not parse baseUrl/baseData from app_constants.dart")
    return base_url_match.group(1).rstrip("/"), base_data_match.group(1)


def b64(value):
    return base64.b64encode(value.encode("utf-8")).decode("utf-8")


def compact_message(payload, text):
    if isinstance(payload, dict):
        for key in ("message", "error", "detail", "description"):
            value = payload.get(key)
            if value not in (None, ""):
                return str(value)
        if "errors" in payload and payload["errors"]:
            return str(payload["errors"])
        return "JSON response"
    if text:
        return " ".join(text.strip().split())[:120]
    return ""


def find_first_list_item(payload, key):
    if isinstance(payload, dict):
        value = payload.get(key)
        if isinstance(value, list) and value:
            return value[0]
        for child in payload.values():
            result = find_first_list_item(child, key)
            if result is not None:
                return result
    elif isinstance(payload, list):
        for child in payload:
            result = find_first_list_item(child, key)
            if result is not None:
                return result
    return None


class ApiProbe:
    def __init__(self, base_url, base_data):
        self.base_url = base_url
        self.auth_header = f"Basic {b64(base_data)}"
        self.api_key = b64(base_data)
        self.cookie_jar = http.cookiejar.CookieJar()
        self.opener = urllib.request.build_opener(
            urllib.request.HTTPCookieProcessor(self.cookie_jar),
        )
        self.results = []
        self.context = {
            "lang": None,
            "pricelist": None,
            "template_id": None,
            "product_id": None,
            "product_name": None,
            "second_template_id": None,
            "cart_line_id": None,
            "wishlist_id": None,
            "wishlist_product_id": None,
            "review_id": None,
            "address_url": None,
            "address_id": None,
            "order_url": None,
            "order_id": None,
            "notification_id": None,
        }

    def _headers(self, extra=None):
        headers = {
            "Accept": "application/json",
            "Authorization": self.auth_header,
            "User-Agent": "DarAlFatehApiProbe/1.0",
            "tz": "Asia/Kolkata",
        }
        if self.context["lang"]:
            headers["lang"] = self.context["lang"]
        if self.context["pricelist"]:
            headers["pricelist"] = self.context["pricelist"]
        if extra:
            headers.update({k: v for k, v in extra.items() if v is not None})
        return headers

    def _url(self, path, full_url=False):
        if full_url:
            return path
        return urllib.parse.urljoin(f"{self.base_url}/", path.lstrip("/"))

    def request(self, label, method, path, body=None, content_type=None, headers=None, full_url=False, note=""):
        url = self._url(path, full_url=full_url)
        if isinstance(body, dict):
            if content_type == "application/x-www-form-urlencoded":
                data = urllib.parse.urlencode(body).encode("utf-8")
            else:
                data = json.dumps(body).encode("utf-8")
        elif isinstance(body, str):
            data = body.encode("utf-8")
        else:
            data = None

        req_headers = self._headers(headers)
        if content_type:
            req_headers["Content-Type"] = content_type

        request = urllib.request.Request(url, data=data, headers=req_headers, method=method)

        try:
            with self.opener.open(request, timeout=30) as response:
                status = response.getcode()
                raw = response.read().decode("utf-8", "replace")
        except urllib.error.HTTPError as error:
            status = error.code
            raw = error.read().decode("utf-8", "replace")
        except urllib.error.URLError as error:
            entry = {
                "label": label,
                "method": method,
                "path": path,
                "http": "ERR",
                "success": "",
                "message": str(error.reason),
                "note": note or "network error",
            }
            self.results.append(entry)
            return None

        try:
            payload = json.loads(raw) if raw.strip() else None
        except json.JSONDecodeError:
            payload = None

        success = ""
        if isinstance(payload, dict) and "success" in payload:
            success = str(payload.get("success"))

        entry = {
            "label": label,
            "method": method,
            "path": path,
            "http": str(status),
            "success": success,
            "message": compact_message(payload, raw),
            "note": note,
        }
        self.results.append(entry)
        return payload

    def blocked(self, label, method, path, note):
        self.results.append(
            {
                "label": label,
                "method": method,
                "path": path,
                "http": "SKIP",
                "success": "",
                "message": "Not probed",
                "note": note,
            }
        )

    def bootstrap_context(self):
        splash = self.request(
            "splashPageData",
            "POST",
            "mobikul/splashPageData",
            body={"apiKey": self.api_key},
            content_type="application/x-www-form-urlencoded",
        )
        if isinstance(splash, dict):
            default_language = splash.get("defaultLanguage") or []
            if default_language:
                self.context["lang"] = default_language[0]
            default_pricelist = splash.get("defaultPricelist") or []
            if default_pricelist:
                self.context["pricelist"] = str(default_pricelist[0])

        homepage = self.request(
            "homepage",
            "POST",
            "mobikul/homepage?offset=0&limit=5",
            body={"fcmToken": "", "fcmDeviceId": ""},
            content_type="text/plain",
            headers={"IsGuest": "1", "fcmToken": "", "fcmDeviceId": ""},
        )
        if isinstance(homepage, dict):
            first_slider = find_first_list_item(homepage, "homepageData")
            if isinstance(first_slider, dict):
                first_data = (first_slider.get("data") or [None])[0]
                if isinstance(first_data, dict) and first_data.get("url"):
                    self.context["slider_url"] = first_data["url"]

        search = self.request(
            "catalogSearch",
            "POST",
            "mobikul/search",
            body={"limit": 10, "offset": 0, "order": "website_sequence asc"},
            content_type="text/plain",
            headers={"IsGuest": "1"},
        )
        if isinstance(search, dict):
            products = search.get("products") or []
            if products:
                first = products[0]
                self.context["template_id"] = first.get("templateId")
                self.context["product_id"] = first.get("productId")
                self.context["product_name"] = first.get("name")
            if len(products) > 1:
                self.context["second_template_id"] = products[1].get("templateId")

    def run(self):
        self.bootstrap_context()

        template_id = self.context["template_id"]
        product_id = self.context["product_id"]
        product_name = self.context["product_name"] or "Probe Product"
        second_template_id = self.context["second_template_id"] or template_id

        self.request(
            "searchSuggestions",
            "POST",
            "mobikul/search",
            body={"offset": 0, "limit": 10, "search": "bean"},
            content_type="text/plain",
            headers={"IsGuest": "1"},
        )
        self.request(
            "countryList",
            "POST",
            "mobikul/localizationData",
        )
        self.request("shippingMethods", "GET", "mobikul/ShippingMethods")
        self.request("paymentMethods", "POST", "mobikul/paymentAcquirers")
        self.request("signUpTerms", "GET", "mobikul/signup/terms")
        self.request("contactUs", "GET", "mobikul/contactUs")
        self.request("walkThrough", "GET", "mobikul/walkThrough")
        self.request(
            "filterProducts",
            "POST",
            "mobikul/search/filter",
            body={"offset": 0, "limit": 10},
            content_type="text/plain",
        )
        self.request(
            "googlePlaceViaConfiguredBaseUrl",
            "GET",
            "place/textsearch/json?query=Dubai",
            note="This endpoint is external to Odoo and currently uses the app baseUrl.",
        )

        if template_id:
            self.request(
                "productDetails",
                "POST",
                f"mobikul/template/{template_id}",
                body={"apiKey": self.api_key},
                content_type="application/x-www-form-urlencoded",
            )
            reviews = self.request(
                "productReviews",
                "POST",
                "product/reviews",
                body={"template_id": template_id},
                content_type="text/plain",
            )
            if isinstance(reviews, dict):
                product_reviews = reviews.get("product_reviews") or []
                if product_reviews:
                    self.context["review_id"] = product_reviews[0].get("id")
            compare_products = [value for value in (template_id, second_template_id) if value]
            self.request(
                "compareProducts",
                "GET",
                "mobikul/addToCompare?" + urllib.parse.urlencode({"products": str(compare_products)}),
            )
        else:
            self.blocked("productDetails", "POST", "mobikul/template/{templateId}", "No templateId available from search.")
            self.blocked("productReviews", "POST", "product/reviews", "No templateId available from search.")
            self.blocked("compareProducts", "GET", "mobikul/addToCompare", "No templateIds available from search.")

        if product_id:
            self.request(
                "addToCart",
                "POST",
                "mobikul/mycart/addToCart",
                body={"productId": str(product_id), "add_qty": 1},
                content_type="text/plain",
                headers={"IsGuest": "1"},
                note="Guest cart probe",
            )
            cart = self.request(
                "myCart",
                "POST",
                "mobikul/mycart/",
                headers={"IsGuest": "1"},
                note="Guest cart probe",
            )
            if isinstance(cart, dict):
                items = cart.get("items") or []
                if items:
                    self.context["cart_line_id"] = items[0].get("lineId")
            if self.context["cart_line_id"] is not None:
                line_id = self.context["cart_line_id"]
                self.request(
                    "setCartItemQuantity",
                    "PUT",
                    f"mobikul/mycart/{line_id}",
                    body={"set_qty": 2},
                    content_type="text/plain",
                    headers={"IsGuest": "1"},
                    note="Guest cart probe",
                )
                self.request(
                    "applyCouponCode",
                    "POST",
                    "mobikul/apply-coupons",
                    body={"coupon": "TEST"},
                    content_type="text/plain",
                    headers={"IsGuest": "1"},
                    note="Guest cart probe",
                )
                self.request(
                    "removeCartItem",
                    "DELETE",
                    f"mobikul/mycart/{line_id}",
                    headers={"IsGuest": "1"},
                    note="Guest cart probe",
                )
                self.request(
                    "addToCartSecondPass",
                    "POST",
                    "mobikul/mycart/addToCart",
                    body={"productId": str(product_id), "add_qty": 1},
                    content_type="text/plain",
                    headers={"IsGuest": "1"},
                    note="Guest cart probe to set up cartToWishlist",
                )
                cart_again = self.request(
                    "myCartSecondPass",
                    "POST",
                    "mobikul/mycart/",
                    headers={"IsGuest": "1"},
                    note="Guest cart probe",
                )
                if isinstance(cart_again, dict):
                    items = cart_again.get("items") or []
                    if items:
                        self.context["cart_line_id"] = items[0].get("lineId")
                if self.context["cart_line_id"] is not None:
                    self.request(
                        "cartToWishlist",
                        "POST",
                        "my/cartToWishlist",
                        body={
                            "productName": product_name,
                            "line_id": self.context["cart_line_id"],
                            "productId": template_id,
                        },
                        content_type="text/plain",
                        headers={"IsGuest": "1"},
                        note="Guest cart probe",
                    )
            else:
                self.blocked("setCartItemQuantity", "PUT", "mobikul/mycart/{lineId}", "No cart line id returned.")
                self.blocked("removeCartItem", "DELETE", "mobikul/mycart/{lineId}", "No cart line id returned.")
                self.blocked("cartToWishlist", "POST", "my/cartToWishlist", "No cart line id returned.")

            self.request(
                "setCartEmpty",
                "DELETE",
                "mobikul/mycart/setToEmpty",
                headers={"IsGuest": "1"},
                note="Guest cart cleanup",
            )
            self.request(
                "addToWishlist",
                "POST",
                "my/addToWishlist",
                body={"productId": str(template_id or product_id), "productName": product_name},
                content_type="text/plain",
                note="Unauthenticated wishlist probe",
            )
            wishlist = self.request("myWishlist", "POST", "mobikul/my/wishlists")
            if isinstance(wishlist, dict):
                items = wishlist.get("wishLists") or []
                if items:
                    self.context["wishlist_id"] = items[0].get("id")
                    self.context["wishlist_product_id"] = items[0].get("productId")
            if self.context["wishlist_id"] is not None and self.context["wishlist_product_id"] is not None:
                self.request(
                    "wishlistToCart",
                    "POST",
                    "my/wishlistToCart",
                    body={
                        "productName": product_name,
                        "wishlistId": self.context["wishlist_id"],
                        "productId": self.context["wishlist_product_id"],
                        "templateId": template_id,
                    },
                    content_type="text/plain",
                )
                self.request(
                    "removeWishlistItem",
                    "DELETE",
                    f"my/removeWishlist/{self.context['wishlist_id']}",
                )
            else:
                self.request(
                    "wishlistToCart",
                    "POST",
                    "my/wishlistToCart",
                    body={"wishlistId": 0, "productId": int(product_id)},
                    content_type="text/plain",
                    note="Fallback auth/validation probe",
                )
                self.request(
                    "removeWishlistItem",
                    "DELETE",
                    "my/removeWishlist/0",
                    note="Fallback auth/validation probe",
                )
        else:
            self.blocked("addToCart", "POST", "mobikul/mycart/addToCart", "No productId available from search.")
            self.blocked("myCart", "POST", "mobikul/mycart/", "No productId available from search.")
            self.blocked("setCartItemQuantity", "PUT", "mobikul/mycart/{lineId}", "No productId available from search.")
            self.blocked("removeCartItem", "DELETE", "mobikul/mycart/{lineId}", "No productId available from search.")
            self.blocked("cartToWishlist", "POST", "my/cartToWishlist", "No productId available from search.")
            self.blocked("setCartEmpty", "DELETE", "mobikul/mycart/setToEmpty", "No productId available from search.")
            self.blocked("addToWishlist", "POST", "my/addToWishlist", "No productId available from search.")
            self.blocked("myWishlist", "POST", "mobikul/my/wishlists", "No productId available from search.")
            self.blocked("wishlistToCart", "POST", "my/wishlistToCart", "No productId available from search.")
            self.blocked("removeWishlistItem", "DELETE", "my/removeWishlist/{productId}", "No productId available from search.")

        if self.context["review_id"] is not None:
            self.request(
                "likeDislikeReview",
                "POST",
                "review/likeDislike",
                body={"review_id": self.context["review_id"], "ishelpful": True},
                content_type="text/plain",
                note="Only runs when a review is available.",
            )
        else:
            self.request(
                "likeDislikeReview",
                "POST",
                "review/likeDislike",
                body={"review_id": 0, "ishelpful": True},
                content_type="text/plain",
                note="Fallback validation probe because no reviews were returned.",
            )

        self.request(
            "addReview",
            "POST",
            "my/saveReview",
            body={"rate": 5, "title": "", "detail": "", "template_id": template_id or 0},
            content_type="text/plain",
            note="Validation/auth probe only",
        )
        self.request(
            "customerLoginInvalid",
            "POST",
            "mobikul/customer/login",
            body={"fcmToken": "", "customerId": "", "fcmDeviceId": ""},
            content_type="text/plain",
            headers={
                "Login": b64(json.dumps({"login": "invalid@example.com", "pwd": "wrong-password"})),
                "IsGuest": "0",
            },
            note="Intentional invalid login probe",
        )
        self.request(
            "customerSignUpValidation",
            "POST",
            "mobikul/customer/signUp",
            body={},
            content_type="text/plain",
            headers={"IsGuest": "0"},
            note="Validation probe only to avoid creating data",
        )
        self.request(
            "mergeCartAuth",
            "POST",
            "mobikul/mergeCart",
            headers={"Login": b64("{}"), "fcmToken": ""},
            note="Auth probe",
        )
        self.request(
            "forgotPasswordInvalid",
            "POST",
            "mobikul/customer/resetPassword",
            body={"login": "invalid@example.com"},
            content_type="text/plain",
            note="Intentional invalid login probe",
        )
        self.request(
            "logoutAuth",
            "POST",
            "mobikul/customer/signOut",
            body={"fcmToken": "", "fcmDeviceId": ""},
            content_type="text/plain",
            note="Auth probe",
        )
        self.request("addressListAuth", "POST", "mobikul/my/addresses", note="Auth probe")
        self.request("deleteAddressAuth", "DELETE", "mobikul/my/address/0", note="Auth probe")
        self.request("getAddressDetailsAuth", "POST", "mobikul/my/address/0", note="Auth probe")
        self.request(
            "updateAddressAuth",
            "PUT",
            "mobikul/my/address/0",
            body={"name": "Probe", "phone": "000", "street": "N/A", "city": "N/A", "zip": "00000", "country_id": "1"},
            content_type="text/plain",
            note="Auth probe",
        )
        self.request(
            "addNewAddressValidation",
            "POST",
            "mobikul/my/address/new",
            body={},
            content_type="text/plain",
            note="Validation/auth probe only",
        )
        self.request(
            "orderReviewValidation",
            "POST",
            "mobikul/orderReviewData",
            body={"shippingAddressId": 0, "acquirerId": 0, "shippingId": 0},
            content_type="text/plain",
            note="Validation/auth probe only",
        )
        self.request(
            "placeOrderValidation",
            "POST",
            "mobikul/placeMyOrder",
            body={"paymentReference": "", "transaction_id": 0, "paymentStatus": ""},
            content_type="text/plain",
            note="Validation/auth probe only",
        )
        self.request("orderListAuth", "POST", "mobikul/my/orders", body={"offset": 0, "limit": 10}, content_type="text/plain", note="Auth probe")
        self.request("orderDetailsAuth", "POST", "mobikul/my/order/0", note="Auth probe")
        self.request("saveAccountInfoAuth", "POST", "mobikul/saveMyDetails", body={"name": "Probe"}, content_type="text/plain", note="Auth probe")
        self.request("deactivateAccountAuth", "POST", "mobikul/gdpr/deactivate", body={"type": "temporary"}, content_type="text/plain", note="Auth probe")
        self.request("downloadInfoAuth", "GET", "mobikul/gdpr/download", note="Auth probe")
        self.request("saveDefaultShippingAddressAuth", "PUT", "mobikul/my/address/default/0", note="Auth probe")
        self.request("resendVerificationAuth", "POST", "send/verifyEmail", note="Auth probe")
        notifications = self.request("notificationsAuth", "POST", "mobikul/notificationMessages", note="Auth probe")
        if isinstance(notifications, dict):
            items = notifications.get("all_notification_messages") or []
            if items:
                self.context["notification_id"] = items[0].get("id")
        notification_id = self.context["notification_id"] or 0
        self.request(
            "markReadNotificationAuth",
            "POST",
            f"mobikul/notificationMessage/{notification_id}",
            body={"isRead": True},
            content_type="text/plain",
            note="Auth probe",
        )
        self.request("deleteNotificationAuth", "DELETE", f"mobikul/notificationMessage/{notification_id}", note="Auth probe")
        self.request("deleteAccountAuth", "POST", "mobikul/delete/account", body="", content_type="text/plain", note="Auth probe")
        self.request("deleteProfileImageAuth", "DELETE", "mobikul/deleteProfileImage", note="Auth probe")
        self.request("deleteBannerImageAuth", "DELETE", "mobikul/delete/customer/banner-image", note="Auth probe")
        self.request("reorderOrderAuth", "POST", "mobikul/re-order/0", body={"needCartMerge": False}, content_type="text/plain", note="Auth probe")

        if "slider_url" in self.context:
            self.request(
                "productSliderData",
                "POST",
                self.context["slider_url"],
                body={"limit": 10, "offset": 0},
                content_type="text/plain",
                note="Dynamic slider endpoint from homepage feed",
            )
        else:
            self.blocked(
                "productSliderData",
                "POST",
                "{sliderUrl}",
                "Homepage response did not include any slider URL to probe.",
            )

        self.results.append(
            {
                "label": "liveChatDataConstant",
                "method": "-",
                "path": "mobikul/im_livechat/support",
                "http": "SKIP",
                "success": "",
                "message": "Not probed",
                "note": "Constant exists in apis.dart but there is no ApiClient method wired for it.",
            }
        )

    def write_report(self):
        REPORT_PATH.parent.mkdir(parents=True, exist_ok=True)
        lines = [
            "# Odoo API Probe",
            "",
            f"Generated: {dt.datetime.now().isoformat(timespec='seconds')}",
            f"Base URL: `{self.base_url}`",
            "",
            "| Endpoint | Method | Path | HTTP | Success | Message | Note |",
            "|---|---|---|---:|---:|---|---|",
        ]
        for entry in self.results:
            row = [
                entry["label"],
                entry["method"],
                entry["path"],
                entry["http"],
                entry["success"],
                entry["message"].replace("|", "/"),
                entry["note"].replace("|", "/"),
            ]
            lines.append("| " + " | ".join(row) + " |")

        REPORT_PATH.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main():
    base_url, base_data = read_constants()
    probe = ApiProbe(base_url, base_data)
    probe.run()
    probe.write_report()

    print(f"Wrote report to {REPORT_PATH}")
    print(f"Checked {len(probe.results)} endpoints/probes")
    for entry in probe.results:
        print(
            f"{entry['http']:>4}  {entry['label']:<28}  "
            f"success={entry['success'] or '-':<5}  {entry['message']}"
        )
    return 0


if __name__ == "__main__":
    sys.exit(main())
