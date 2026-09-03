# Odoo API Probe

Generated: 2026-06-16T18:57:13
Base URL: `https://doc-colleges-customs-status.trycloudflare.com`

| Endpoint | Method | Path | HTTP | Success | Message | Note |
|---|---|---|---:|---:|---|---|
| splashPageData | POST | mobikul/splashPageData | 200 | True | Splash Data. |  |
| homepage | POST | mobikul/homepage?offset=0&limit=5 | 200 | True | Homepage Data. |  |
| catalogSearch | POST | mobikul/search | 200 | True | Search result. |  |
| searchSuggestions | POST | mobikul/search | 200 | True | Search result. |  |
| countryList | POST | mobikul/localizationData | 200 | True | Localization Data. |  |
| shippingMethods | GET | mobikul/ShippingMethods | 200 | False | Insufficient data to authenticate !!! |  |
| paymentMethods | POST | mobikul/paymentAcquirers | 200 | False | Insufficient data to authenticate !!! |  |
| signUpTerms | GET | mobikul/signup/terms | 200 | True | Login successfully. |  |
| contactUs | GET | mobikul/contactUs | 200 | True | Login successfully. |  |
| walkThrough | GET | mobikul/walkThrough | 200 | True | Login successfully. |  |
| filterProducts | POST | mobikul/search/filter | 403 |  | <!DOCTYPE html> <html lang="en-US" data-website-id="1" data-main-object="ir.ui.view(263,)" data-add2cart-redirect="1"> < |  |
| googlePlaceViaConfiguredBaseUrl | GET | place/textsearch/json?query=Dubai | 404 |  | <!DOCTYPE html> <html lang="en-US" data-website-id="1" data-main-object="ir.ui.view(264,)" data-add2cart-redirect="1"> < | This endpoint is external to Odoo and currently uses the app baseUrl. |
| productDetails | POST | mobikul/template/281 | 200 | True | Template detail. |  |
| productReviews | POST | product/reviews | 200 | False | Review Module not install !!! |  |
| compareProducts | GET | mobikul/addToCompare?products=%5B281%2C+247%5D | 200 | False | Product Comparison Module is not installed. |  |
| addToCart | POST | mobikul/mycart/addToCart | 200 | True | Added Successfully. | Guest cart probe |
| myCart | POST | mobikul/mycart/ | 200 | True | Welcome Guest user | Guest cart probe |
| setCartItemQuantity | PUT | mobikul/mycart/35935 | 200 | True | Updated successfully. | Guest cart probe |
| applyCouponCode | POST | mobikul/apply-coupons | 500 |  | <html> <head> <title>Internal Server Error</title> <link rel="stylesheet" href="/web/static/lib/bootstrap/dist/css/boots | Guest cart probe |
| removeCartItem | DELETE | mobikul/mycart/35935 | 200 | True | Beans Valentino Pkt 2 Kg was removed from your Shopping Bag. | Guest cart probe |
| addToCartSecondPass | POST | mobikul/mycart/addToCart | 200 | True | Added Successfully. | Guest cart probe to set up cartToWishlist |
| myCartSecondPass | POST | mobikul/mycart/ | 200 | True | Welcome Guest user | Guest cart probe |
| cartToWishlist | POST | my/cartToWishlist | 200 | False | Wishlist is not Active !!! | Guest cart probe |
| setCartEmpty | DELETE | mobikul/mycart/setToEmpty | 200 | True | Your Shopping Bag has been set to Empty. | Guest cart cleanup |
| addToWishlist | POST | my/addToWishlist | 200 | False | Insufficient data to authenticate !!! | Unauthenticated wishlist probe |
| myWishlist | POST | mobikul/my/wishlists | 200 | False | Insufficient data to authenticate !!! |  |
| wishlistToCart | POST | my/wishlistToCart | 200 | False | Insufficient data to authenticate !!! | Fallback auth/validation probe |
| removeWishlistItem | DELETE | my/removeWishlist/0 | 200 | False | Insufficient data to authenticate !!! | Fallback auth/validation probe |
| likeDislikeReview | POST | review/likeDislike | 500 |  | <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN"> <title>500 Internal Server Error</title> <h1>Internal Server Err | Fallback validation probe because no reviews were returned. |
| addReview | POST | my/saveReview | 200 | False | Insufficient data to authenticate !!! | Validation/auth probe only |
| customerLoginInvalid | POST | mobikul/customer/login | 200 | False | Invalid email address. | Intentional invalid login probe |
| customerSignUpValidation | POST | mobikul/customer/signUp | 200 | False | No login provided. | Validation probe only to avoid creating data |
| mergeCartAuth | POST | mobikul/mergeCart | 200 | False | Insufficient data to authenticate !!! | Auth probe |
| forgotPasswordInvalid | POST | mobikul/customer/resetPassword | 200 | False | Invalid Username/Email. | Intentional invalid login probe |
| logoutAuth | POST | mobikul/customer/signOut | 200 | True | Have a Good Day !!! | Auth probe |
| addressListAuth | POST | mobikul/my/addresses | 200 | False | Insufficient data to authenticate !!! | Auth probe |
| deleteAddressAuth | DELETE | mobikul/my/address/0 | 200 | False | Insufficient data to authenticate !!! | Auth probe |
| getAddressDetailsAuth | POST | mobikul/my/address/0 | 200 | False | Insufficient data to authenticate !!! | Auth probe |
| updateAddressAuth | PUT | mobikul/my/address/0 | 200 | False | Insufficient data to authenticate !!! | Auth probe |
| addNewAddressValidation | POST | mobikul/my/address/new | 200 | False | Insufficient data to authenticate !!! | Validation/auth probe only |
| orderReviewValidation | POST | mobikul/orderReviewData | 200 | False | Insufficient data to authenticate !!! | Validation/auth probe only |
| placeOrderValidation | POST | mobikul/placeMyOrder | 200 | False | Insufficient data to authenticate !!! | Validation/auth probe only |
| orderListAuth | POST | mobikul/my/orders | 200 | False | Insufficient data to authenticate !!! | Auth probe |
| orderDetailsAuth | POST | mobikul/my/order/0 | 200 | False | Insufficient data to authenticate !!! | Auth probe |
| saveAccountInfoAuth | POST | mobikul/saveMyDetails | 200 | False | Insufficient data to authenticate !!! | Auth probe |
| deactivateAccountAuth | POST | mobikul/gdpr/deactivate | 200 | False | Insufficient data to authenticate !!! | Auth probe |
| downloadInfoAuth | GET | mobikul/gdpr/download | 200 | False | Insufficient data to authenticate !!! | Auth probe |
| saveDefaultShippingAddressAuth | PUT | mobikul/my/address/default/0 | 200 | False | Insufficient data to authenticate !!! | Auth probe |
| resendVerificationAuth | POST | send/verifyEmail | 200 | False | Insufficient data to authenticate !!! | Auth probe |
| notificationsAuth | POST | mobikul/notificationMessages | 200 | False | Insufficient data to authenticate !!! | Auth probe |
| markReadNotificationAuth | POST | mobikul/notificationMessage/0 | 200 | False | Insufficient data to authenticate !!! | Auth probe |
| deleteNotificationAuth | DELETE | mobikul/notificationMessage/0 | 200 | False | Insufficient data to authenticate !!! | Auth probe |
| deleteAccountAuth | POST | mobikul/delete/account | 200 | False | Insufficient data to authenticate !!! | Auth probe |
| deleteProfileImageAuth | DELETE | mobikul/deleteProfileImage | 200 | False | Insufficient data to authenticate !!! | Auth probe |
| deleteBannerImageAuth | DELETE | mobikul/delete/customer/banner-image | 200 | False | Insufficient data to authenticate !!! | Auth probe |
| reorderOrderAuth | POST | mobikul/re-order/0 | 200 | False | Insufficient data to authenticate !!! | Auth probe |
| productSliderData | POST | {sliderUrl} | SKIP |  | Not probed | Homepage response did not include any slider URL to probe. |
| liveChatDataConstant | - | mobikul/im_livechat/support | SKIP |  | Not probed | Constant exists in apis.dart but there is no ApiClient method wired for it. |
