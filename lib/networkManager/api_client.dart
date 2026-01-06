import 'dart:convert';
import 'dart:developer';

/*
 * *
 *
 *  Webkul Software.
 *
 *  @package Mobikul App
 *
 *  @Category Mobikul
 *
 *  @author Webkul <support@webkul.com>
 *
 *  @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *
 *  @license https://store.webkul.com/license.html ASL Licence
 *
 *  @link https://store.webkul.com/license.html
 *
 * /
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/encryption.dart';
import 'package:flutter_project_structure/helper/extension.dart';
import 'package:flutter_project_structure/main.dart';
import 'package:flutter_project_structure/models/AccountInfoModel.dart';
import 'package:flutter_project_structure/models/AddressDetailModel.dart';
import 'package:flutter_project_structure/models/AddressListModel.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/CartViewModel.dart';
import 'package:flutter_project_structure/models/CategoryScreenModel.dart';
import 'package:flutter_project_structure/models/ContactUsModel.dart';
import 'package:flutter_project_structure/models/CountryListModel.dart';
import 'package:flutter_project_structure/models/GooglePlaceModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/models/LoginResponseModel.dart';
import 'package:flutter_project_structure/models/NotificationModel.dart';
import 'package:flutter_project_structure/models/OrderModel.dart';
import 'package:flutter_project_structure/models/OrderDetailModel.dart';
import 'package:flutter_project_structure/models/OrderReviewModel.dart';
import 'package:flutter_project_structure/models/PaymentModel.dart';
import 'package:flutter_project_structure/models/PlaceOrderModel.dart';
import 'package:flutter_project_structure/models/ProductScreenModel.dart';
import 'package:flutter_project_structure/models/ReviewListModel.dart';
import 'package:flutter_project_structure/models/SearchScreenModel.dart';
import 'package:flutter_project_structure/models/SignUpScreenModel.dart';
import 'package:flutter_project_structure/models/SignUpTermsModel.dart';
import 'package:flutter_project_structure/models/SplashScreenModel.dart';
import 'package:flutter_project_structure/models/WishlistModel.dart';
import 'package:flutter_project_structure/models/compare_product_model.dart';
import 'package:flutter_project_structure/models/walkThroughModel.dart';
import 'package:flutter_project_structure/networkManager/apis.dart';
import 'package:flutter_project_structure/networkManager/dio_exceptions.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../constants/route_constant.dart';
import '../helper/push_notifications_manager.dart';
import '../models/FilterDataModel.dart';
import '../models/ShippingMethodModel.dart';

part 'api_client.g.dart';

const List<Map<String, dynamic>> _demoProducts = [
  {
    "templateId": 1,
    "name": "Butternut",
    "priceUnit": "29.99",
    "priceReduce": "19.99",
    "productId": 1,
    "thumbNail": "assets/images/Butternut.png",
  },
  {
    "templateId": 2,
    "name": "Beetroot",
    "priceUnit": "39.99",
    "priceReduce": "29.99",
    "productId": 2,
    "thumbNail": "assets/images/beetroot.png",
  },
  {
    "templateId": 3,
    "name": "Broccoli",
    "priceUnit": "49.99",
    "priceReduce": "39.99",
    "productId": 3,
    "thumbNail": "assets/images/broccoli.png",
  },
  {
    "templateId": 4,
    "name": "Pumpkin",
    "priceUnit": "49.99",
    "priceReduce": "39.99",
    "productId": 4,
    "thumbNail": "assets/images/pumpkin.png",
  },
  {
    "templateId": 5,
    "name": "Cucumber",
    "priceUnit": "49.99",
    "priceReduce": "39.99",
    "productId": 5,
    "thumbNail": "assets/images/cucumber.png",
  },
  {
    "templateId": 6,
    "name": "Fresh spinach",
    "priceUnit": "49.99",
    "priceReduce": "39.99",
    "productId": 6,
    "thumbNail": "assets/images/fresh_spinach.png",
  },
  {
    "templateId": 7,
    "name": "Green leaves",
    "priceUnit": "49.99",
    "priceReduce": "39.99",
    "productId": 7,
    "thumbNail": "assets/images/green_leaves.png",
  },
  {
    "templateId": 8,
    "name": "Pumkin green",
    "priceUnit": "49.99",
    "priceReduce": "39.99",
    "productId": 8,
    "thumbNail": "assets/images/pumkin_green.png",
  },
  {
    "templateId": 9,
    "name": "Water melon yellow",
    "priceUnit": "49.99",
    "priceReduce": "39.99",
    "productId": 9,
    "thumbNail": "assets/images/water_melon_yellow.png",
  },
  {
    "templateId": 10,
    "name": "Water melon",
    "priceUnit": "49.99",
    "priceReduce": "39.99",
    "productId": 10,
    "thumbNail": "assets/images/water_melon.png",
  },
];

double _parsePrice(String? value) {
  return double.tryParse(value ?? "") ?? 0.0;
}

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class ApiClient {
  factory ApiClient({String? baseUrl, bool isFromCache = false}) {
    Dio dio = Dio();
    dio.options = BaseOptions(
      receiveTimeout: Duration(seconds: 100000),
      connectTimeout: Duration(seconds: 100000),

      baseUrl: ApiConstant.baseUrl,
    );
    dio.options.headers["Content-Type"] = "text/plain";
    dio.options.headers["Authorization"] =
        "Basic ${generateEncodedApiKey(ApiConstant.baseData)}";
    if (AppSharedPref().getLoginKey() != null) {
      dio.options.headers[AppSharedPref().getIsSocialLogin()
          ? "Login"
          : "Login"] = AppSharedPref()
          .getLoginKey()!;
    }
    if (AppSharedPref().getAppLanguage() != null) {
      dio.options.headers["lang"] = AppSharedPref().getAppLanguage()!;
    }

    if (AppSharedPref().getAppCurrency() != null) {
      dio.options.headers["pricelist"] = AppSharedPref().getAppCurrency()!;
    }

    if (AppSharedPref().getTimeZone() != null) {
      dio.options.headers["tz"] = AppSharedPref().getTimeZone()!;
    }
    if (!(AppSharedPref().getIfLogin() != null &&
        (AppSharedPref().getIfLogin() ?? false))) {
      dio.options.headers["fcmToken"] = AppSharedPref().getFcmToken();
    }
    if (!(AppSharedPref().getIfLogin() != null &&
        (AppSharedPref().getIfLogin() ?? false))) {
      dio.options.headers["fcmDeviceId"] = AppSharedPref().getDeviceID() ?? "";
    }
    if (!(AppSharedPref().getIfLogin() != null &&
        (AppSharedPref().getIfLogin() ?? false))) {
      dio.options.headers["IsGuest"] = AppSharedPref().getGuestCheckout()
          ? 1
          : 0;
    }

    RequestOptions? reqOptions;
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          reqOptions = options;

          // Intercept homepage API call for demo mode
          final isPlaceholderHost = dio.options.baseUrl.contains('example.com');
          if (isPlaceholderHost && options.path.contains('mobikul/homepage')) {
            // Return mock response directly
            final mockData = {
              "success": true,
              "homepageData": [
                {
                  "type": "slider",
                  "name": "Featured Products",
                  "data": [
                    {
                      "title": "New Arrivals",
                      "slider_mode": "default",
                      "url": "",
                      "products":
                          _demoProducts.map((item) => Map<String, dynamic>.from(item)).toList(),
                    },
                  ],
                },
                {
                  "type": "featured_category",
                  "name": "Shop by Categories",
                  "featured_category_view_type": "grid",
                  "data": [
                    {
                      "categoryId": 1,
                      "categoryName": "WINTER",
                      "url":
                          "https://via.placeholder.com/300/6C5CE7/FFFFFF?text=Men",
                    },
                    {
                      "categoryId": 2,
                      "categoryName": "SPRING",
                      "url":
                          "https://via.placeholder.com/300/FDCB6E/FFFFFF?text=Women",
                    },
                    {
                      "categoryId": 3,
                      "categoryName": "SUMMER",
                      "url":
                          "https://via.placeholder.com/300/74B9FF/FFFFFF?text=Kids",
                    },
                    {
                      "categoryId": 4,
                      // "categoryName": "Electronics",
                      "categoryName": "AUTUMN",
                      "url":
                          "https://via.placeholder.com/300/A29BFE/FFFFFF?text=Electronics",
                    },
                  ],
                },
                {
                  "type": "banner",
                  "name": "Special Offers",
                  "data": [
                    {
                      "bannerName": "B1",
                      "bannerType": "image",
                      "url": "assets/images/bannerimage1.png",
                    },
                    {
                      "bannerName": "B2",
                      "bannerType": "image",
                      "url": "assets/images/bannerimage2.png",
                    },
                    {
                      "bannerName": "B3",
                      "bannerType": "image",
                      "url": "assets/images/bannerimage3.png",
                    },
                  ],
                },
              ],
              "homepageDataCount": 3,
              "cartCount": 0,
              "wishlist": [],
              "categories": [
                {
                  "category_id": 1,
                  "name": "Men",
                  "icon":
                      "https://via.placeholder.com/300/6C5CE7/FFFFFF?text=Men",
                },
                {
                  "category_id": 2,
                  "name": "Women",
                  "icon":
                      "https://via.placeholder.com/300/FDCB6E/FFFFFF?text=Women",
                },
                {
                  "category_id": 3,
                  "name": "Kids",
                  "icon":
                      "https://via.placeholder.com/300/74B9FF/FFFFFF?text=Kids",
                },
              ],
              "defaultPricelist": ["USD"],
            };

            return handler.resolve(
              Response(
                requestOptions: options,
                data: mockData,
                statusCode: 200,
              ),
            );
          }
          if (isPlaceholderHost && options.path.contains('mobikul/search')) {
            final mockData = {
              "success": true,
              "offset": 0,
              "itemsPerPage": 10,
              "tcount": 10,
              "total_product_count": 10,
              "wishlist": [],
              "categories": [],
              "filters": [],
              "applied_filters": [],
              "available_min_price": 19.99,
              "available_max_price": 49.99,
              "min_price": 19.99,
              "max_price": 49.99,
              "products":
                  _demoProducts.map((item) => Map<String, dynamic>.from(item)).toList(),
            };

            return handler.resolve(
              Response(
                requestOptions: options,
                data: mockData,
                statusCode: 200,
              ),
            );
          }
          if (isPlaceholderHost &&
              options.path.contains('mobikul/mycart/addToCart')) {
            Map<String, dynamic> payload = {};
            if (options.data is String) {
              payload = json.decode(options.data as String);
            } else if (options.data is Map) {
              payload = Map<String, dynamic>.from(options.data as Map);
            }
            final int productId =
                int.tryParse(payload["productId"].toString()) ?? 0;
            final int addQty =
                int.tryParse(payload["add_qty"].toString()) ?? 1;

            final List<Map<String, dynamic>> cartItems =
                AppSharedPref().getGuestCartItems();
            final Map<String, dynamic> product = _demoProducts.firstWhere(
              (item) => item["productId"] == productId,
              orElse: () => {},
            );
            if (product.isNotEmpty) {
              final int? existingIndex = cartItems.indexWhere(
                (item) => item["productId"] == productId,
              );
              if (existingIndex != -1) {
                final Map<String, dynamic> existingItem = cartItems[existingIndex!];
                final int currentQty =
                    int.tryParse(existingItem["qty"].toString()) ?? 0;
                existingItem["qty"] = currentQty + addQty;
                final double unitPrice = _parsePrice(
                  existingItem["priceReduce"] ?? existingItem["priceUnit"],
                );
                existingItem["total"] =
                    (unitPrice * (existingItem["qty"] as int)).toStringAsFixed(2);
                cartItems[existingIndex] = existingItem;
              } else {
                int nextLineId = 1;
                for (final item in cartItems) {
                  final int lineId =
                      int.tryParse(item["lineId"].toString()) ?? 0;
                  if (lineId >= nextLineId) {
                    nextLineId = lineId + 1;
                  }
                }
                final double unitPrice = _parsePrice(
                  product["priceReduce"] ?? product["priceUnit"],
                );
                cartItems.add({
                  "lineId": nextLineId,
                  "templateId": product["templateId"],
                  "productId": product["productId"],
                  "name": product["name"],
                  "thumbNail": product["thumbNail"],
                  "priceReduce": product["priceReduce"],
                  "priceUnit": product["priceUnit"],
                  "qty": addQty,
                  "total": (unitPrice * addQty).toStringAsFixed(2),
                  "discount": "0.00",
                  "isEditable": true,
                });
              }
            }
            AppSharedPref().setGuestCartItems(cartItems);
            int cartCount = 0;
            for (final item in cartItems) {
              cartCount += int.tryParse(item["qty"].toString()) ?? 0;
            }
            AppSharedPref().setGuestCartCount(cartCount);

            return handler.resolve(
              Response(
                requestOptions: options,
                data: {
                  "success": true,
                  "responseCode": 200,
                  "message": "Added to cart",
                  "cartCount": cartCount,
                },
                statusCode: 200,
              ),
            );
          }
          if (isPlaceholderHost &&
              options.path.contains('mobikul/mycart/setToEmpty')) {
            AppSharedPref().setGuestCartItems([]);
            AppSharedPref().setGuestCartCount(0);
            return handler.resolve(
              Response(
                requestOptions: options,
                data: {
                  "success": true,
                  "responseCode": 200,
                  "message": "Cart emptied",
                  "cartCount": 0,
                },
                statusCode: 200,
              ),
            );
          }
          if (isPlaceholderHost &&
              options.path.contains('mobikul/mycart/') &&
              options.method.toUpperCase() == 'DELETE' &&
              !options.path.contains('setToEmpty')) {
            final String lineIdRaw = options.path.split('/').last;
            final int lineId = int.tryParse(lineIdRaw) ?? 0;
            final List<Map<String, dynamic>> cartItems =
                AppSharedPref().getGuestCartItems();
            cartItems.removeWhere(
              (item) => (int.tryParse(item["lineId"].toString()) ?? 0) == lineId,
            );
            AppSharedPref().setGuestCartItems(cartItems);
            int cartCount = 0;
            for (final item in cartItems) {
              cartCount += int.tryParse(item["qty"].toString()) ?? 0;
            }
            AppSharedPref().setGuestCartCount(cartCount);
            return handler.resolve(
              Response(
                requestOptions: options,
                data: {
                  "success": true,
                  "responseCode": 200,
                  "message": "Removed from cart",
                  "cartCount": cartCount,
                },
                statusCode: 200,
              ),
            );
          }
          if (isPlaceholderHost &&
              options.path.contains('mobikul/mycart/') &&
              options.method.toUpperCase() == 'PUT') {
            final String lineIdRaw = options.path.split('/').last;
            final int lineId = int.tryParse(lineIdRaw) ?? 0;
            Map<String, dynamic> payload = {};
            if (options.data is String) {
              payload = json.decode(options.data as String);
            } else if (options.data is Map) {
              payload = Map<String, dynamic>.from(options.data as Map);
            }
            final int setQty =
                int.tryParse(payload["set_qty"].toString()) ?? 1;
            final List<Map<String, dynamic>> cartItems =
                AppSharedPref().getGuestCartItems();
            for (int i = 0; i < cartItems.length; i++) {
              final Map<String, dynamic> item = cartItems[i];
              final int itemLineId =
                  int.tryParse(item["lineId"].toString()) ?? 0;
              if (itemLineId == lineId) {
                if (setQty <= 0) {
                  cartItems.removeAt(i);
                } else {
                  item["qty"] = setQty;
                  final double unitPrice = _parsePrice(
                    item["priceReduce"] ?? item["priceUnit"],
                  );
                  item["total"] =
                      (unitPrice * setQty).toStringAsFixed(2);
                  cartItems[i] = item;
                }
                break;
              }
            }
            AppSharedPref().setGuestCartItems(cartItems);
            int cartCount = 0;
            for (final item in cartItems) {
              cartCount += int.tryParse(item["qty"].toString()) ?? 0;
            }
            AppSharedPref().setGuestCartCount(cartCount);
            return handler.resolve(
              Response(
                requestOptions: options,
                data: {
                  "success": true,
                  "responseCode": 200,
                  "message": "Cart updated",
                  "cartCount": cartCount,
                },
                statusCode: 200,
              ),
            );
          }
          if (isPlaceholderHost &&
              options.path.contains('mobikul/mycart/') &&
              options.method.toUpperCase() == 'POST') {
            final List<Map<String, dynamic>> cartItems =
                AppSharedPref().getGuestCartItems();
            double subtotalValue = 0.0;
            int cartCount = 0;
            for (final item in cartItems) {
              final int qty = int.tryParse(item["qty"].toString()) ?? 0;
              cartCount += qty;
              final double unitPrice =
                  _parsePrice(item["priceReduce"] ?? item["priceUnit"]);
              subtotalValue += unitPrice * qty;
            }
            AppSharedPref().setGuestCartCount(cartCount);
            final String subtotalText = subtotalValue.toStringAsFixed(2);
            final mockData = {
              "success": true,
              "responseCode": 200,
              "message": "Cart loaded",
              "cartCount": cartCount,
              "wishlistCount": 0,
              "is_email_verified": true,
              "name": "My Cart",
              "subtotal": {"title": "Subtotal", "value": subtotalText},
              "tax": {"title": "Tax", "value": "0.00"},
              "grandtotal": {"title": "Total", "value": subtotalText},
              "items": cartItems,
              "accessoriesProducts": [],
            };

            return handler.resolve(
              Response(
                requestOptions: options,
                data: mockData,
                statusCode: 200,
              ),
            );
          }
          if (isPlaceholderHost &&
              options.path.contains('mobikul/my/wishlists')) {
            final List<Map<String, dynamic>> wishlistItems =
                AppSharedPref().getGuestWishlistItems();
            return handler.resolve(
              Response(
                requestOptions: options,
                data: {
                  "success": true,
                  "responseCode": 200,
                  "message": "Wishlist loaded",
                  "wishlistCount": wishlistItems.length,
                  "wishLists": wishlistItems,
                },
                statusCode: 200,
              ),
            );
          }
          if (isPlaceholderHost && options.path.contains('my/addToWishlist')) {
            Map<String, dynamic> payload = {};
            if (options.data is String) {
              payload = json.decode(options.data as String);
            } else if (options.data is Map) {
              payload = Map<String, dynamic>.from(options.data as Map);
            }
            final int templateId =
                int.tryParse(payload["productId"].toString()) ?? 0;
            final String productName = payload["productName"]?.toString() ?? "";
            final List<Map<String, dynamic>> wishlistItems =
                AppSharedPref().getGuestWishlistItems();
            final Map<String, dynamic> product = _demoProducts.firstWhere(
              (item) => item["templateId"] == templateId,
              orElse: () => {},
            );
            if (product.isNotEmpty) {
              final bool exists = wishlistItems.any(
                (item) => item["templateId"] == templateId,
              );
              if (!exists) {
                int nextId = 1;
                for (final item in wishlistItems) {
                  final int id =
                      int.tryParse(item["id"].toString()) ?? 0;
                  if (id >= nextId) {
                    nextId = id + 1;
                  }
                }
                wishlistItems.add({
                  "id": nextId,
                  "name": productName.isNotEmpty
                      ? productName
                      : product["name"],
                  "thumbNail": product["thumbNail"],
                  "priceReduce": product["priceReduce"],
                  "priceUnit": product["priceUnit"],
                  "productId": product["templateId"],
                  "templateId": product["templateId"],
                });
              }
            }
            AppSharedPref().setGuestWishlistItems(wishlistItems);
            return handler.resolve(
              Response(
                requestOptions: options,
                data: {
                  "success": true,
                  "responseCode": 200,
                  "message": "Added to wishlist",
                  "wishlistCount": wishlistItems.length,
                },
                statusCode: 200,
              ),
            );
          }
          if (isPlaceholderHost &&
              options.path.contains('my/removeFromWishlist/')) {
            final String productIdRaw = options.path.split('/').last;
            final int templateId = int.tryParse(productIdRaw) ?? 0;
            final List<Map<String, dynamic>> wishlistItems =
                AppSharedPref().getGuestWishlistItems();
            wishlistItems.removeWhere(
              (item) => (int.tryParse(item["templateId"].toString()) ?? 0) == templateId,
            );
            AppSharedPref().setGuestWishlistItems(wishlistItems);
            return handler.resolve(
              Response(
                requestOptions: options,
                data: {
                  "success": true,
                  "responseCode": 200,
                  "message": "Removed from wishlist",
                  "wishlistCount": wishlistItems.length,
                },
                statusCode: 200,
              ),
            );
          }
          if (isPlaceholderHost && options.path.contains('my/cartToWishlist')) {
            Map<String, dynamic> payload = {};
            if (options.data is String) {
              payload = json.decode(options.data as String);
            } else if (options.data is Map) {
              payload = Map<String, dynamic>.from(options.data as Map);
            }
            final int lineId =
                int.tryParse(payload["line_id"].toString()) ?? 0;
            final int templateId =
                int.tryParse(payload["productId"].toString()) ?? 0;
            final String productName = payload["productName"]?.toString() ?? "";

            final List<Map<String, dynamic>> cartItems =
                AppSharedPref().getGuestCartItems();
            Map<String, dynamic>? cartItem;
            for (final item in cartItems) {
              final int itemLineId =
                  int.tryParse(item["lineId"].toString()) ?? 0;
              if (itemLineId == lineId) {
                cartItem = item;
                break;
              }
            }
            final int resolvedTemplateId = templateId != 0
                ? templateId
                : int.tryParse(cartItem?["templateId"].toString() ?? "0") ?? 0;
            final List<Map<String, dynamic>> wishlistItems =
                AppSharedPref().getGuestWishlistItems();

            if (resolvedTemplateId != 0) {
              final bool exists = wishlistItems.any(
                (item) => item["templateId"] == resolvedTemplateId,
              );
              if (!exists) {
                int nextId = 1;
                for (final item in wishlistItems) {
                  final int id =
                      int.tryParse(item["id"].toString()) ?? 0;
                  if (id >= nextId) {
                    nextId = id + 1;
                  }
                }
                final Map<String, dynamic> product = _demoProducts.firstWhere(
                  (item) => item["templateId"] == resolvedTemplateId,
                  orElse: () => {},
                );
                wishlistItems.add({
                  "id": nextId,
                  "name": productName.isNotEmpty
                      ? productName
                      : (product["name"] ?? cartItem?["name"] ?? ""),
                  "thumbNail":
                      product["thumbNail"] ?? cartItem?["thumbNail"],
                  "priceReduce":
                      product["priceReduce"] ?? cartItem?["priceReduce"],
                  "priceUnit":
                      product["priceUnit"] ?? cartItem?["priceUnit"],
                  "productId": resolvedTemplateId,
                  "templateId": resolvedTemplateId,
                });
              }
            }
            if (lineId != 0) {
              cartItems.removeWhere(
                (item) =>
                    (int.tryParse(item["lineId"].toString()) ?? 0) == lineId,
              );
            }
            AppSharedPref().setGuestWishlistItems(wishlistItems);
            AppSharedPref().setGuestCartItems(cartItems);
            int cartCount = 0;
            for (final item in cartItems) {
              cartCount += int.tryParse(item["qty"].toString()) ?? 0;
            }
            AppSharedPref().setGuestCartCount(cartCount);
            return handler.resolve(
              Response(
                requestOptions: options,
                data: {
                  "success": true,
                  "responseCode": 200,
                  "message": "Moved to wishlist",
                  "cartCount": cartCount,
                  "wishlistCount": wishlistItems.length,
                },
                statusCode: 200,
              ),
            );
          }
          if (isPlaceholderHost &&
              options.path.contains('my/wishlistToCart')) {
            Map<String, dynamic> payload = {};
            if (options.data is String) {
              payload = json.decode(options.data as String);
            } else if (options.data is Map) {
              payload = Map<String, dynamic>.from(options.data as Map);
            }
            final int wishlistId =
                int.tryParse(payload["wishlistId"].toString()) ?? 0;
            final int templateId = int.tryParse(
                    (payload["templateId"] ?? payload["productId"]).toString()) ??
                0;
            final String productName = payload["productName"]?.toString() ?? "";

            final List<Map<String, dynamic>> wishlistItems =
                AppSharedPref().getGuestWishlistItems();
            Map<String, dynamic>? wishlistItem;
            for (final item in wishlistItems) {
              final int itemId = int.tryParse(item["id"].toString()) ?? 0;
              if (itemId == wishlistId) {
                wishlistItem = item;
                break;
              }
            }

            final List<Map<String, dynamic>> cartItems =
                AppSharedPref().getGuestCartItems();
            final int resolvedTemplateId = templateId != 0
                ? templateId
                : int.tryParse(wishlistItem?["templateId"].toString() ?? "0") ??
                    0;
            final Map<String, dynamic> product = _demoProducts.firstWhere(
              (item) => item["templateId"] == resolvedTemplateId,
              orElse: () => {},
            );
            if (resolvedTemplateId != 0) {
              final int existingIndex = cartItems.indexWhere(
                (item) =>
                    (int.tryParse(item["templateId"].toString()) ?? 0) ==
                    resolvedTemplateId,
              );
              if (existingIndex != -1) {
                final Map<String, dynamic> existingItem = cartItems[existingIndex];
                final int currentQty =
                    int.tryParse(existingItem["qty"].toString()) ?? 0;
                existingItem["qty"] = currentQty + 1;
                final double unitPrice = _parsePrice(
                  existingItem["priceReduce"] ?? existingItem["priceUnit"],
                );
                existingItem["total"] =
                    (unitPrice * (existingItem["qty"] as int)).toStringAsFixed(2);
                cartItems[existingIndex] = existingItem;
              } else {
                int nextLineId = 1;
                for (final item in cartItems) {
                  final int lineId =
                      int.tryParse(item["lineId"].toString()) ?? 0;
                  if (lineId >= nextLineId) {
                    nextLineId = lineId + 1;
                  }
                }
                final double unitPrice = _parsePrice(
                  (product["priceReduce"] ??
                          wishlistItem?["priceReduce"] ??
                          product["priceUnit"] ??
                          wishlistItem?["priceUnit"])
                      ?.toString(),
                );
                cartItems.add({
                  "lineId": nextLineId,
                  "templateId": resolvedTemplateId,
                  "productId": resolvedTemplateId,
                  "name": productName.isNotEmpty
                      ? productName
                      : (product["name"] ?? wishlistItem?["name"] ?? ""),
                  "thumbNail":
                      product["thumbNail"] ?? wishlistItem?["thumbNail"],
                  "priceReduce":
                      product["priceReduce"] ?? wishlistItem?["priceReduce"],
                  "priceUnit":
                      product["priceUnit"] ?? wishlistItem?["priceUnit"],
                  "qty": 1,
                  "total": unitPrice.toStringAsFixed(2),
                  "discount": "0.00",
                  "isEditable": true,
                });
              }
            }

            if (wishlistId != 0) {
              wishlistItems.removeWhere(
                (item) =>
                    (int.tryParse(item["id"].toString()) ?? 0) == wishlistId,
              );
            }

            AppSharedPref().setGuestWishlistItems(wishlistItems);
            AppSharedPref().setGuestCartItems(cartItems);
            int cartCount = 0;
            for (final item in cartItems) {
              cartCount += int.tryParse(item["qty"].toString()) ?? 0;
            }
            AppSharedPref().setGuestCartCount(cartCount);

            return handler.resolve(
              Response(
                requestOptions: options,
                data: {
                  "success": true,
                  "responseCode": 200,
                  "message": "Moved to cart",
                  "cartCount": cartCount,
                  "wishlistCount": wishlistItems.length,
                },
                statusCode: 200,
              ),
            );
          }

          return handler.next(options);
        },
        onResponse: (response, handler) async {
          log("Response::: ${response}");
          if ((response.data["accessDenied"] ?? false) &&
              response.data["message"] != "Login Failed.") {
            Map<String, dynamic> data = {};
            data["fcmToken"] =
                await PushNotificationsManager().createFcmToken() ?? "";
            data["fcmDeviceId"] = AppSharedPref().getDeviceID() ?? "";
            String body = json.encode(data);
            ApiClient().logOut(body).then((val) {
              if (val.success ?? false) {
                AppSharedPref().logoutUser();
                Navigator.pushNamedAndRemoveUntil(
                  navigatorKey.currentContext!,
                  splash,
                  (route) => false,
                );
              }
              log("Log out::: ${val}");
            });
          }
          if (response.statusCode == 301 || response.statusCode == 302) {}

          checkCartAndEmailVerification(response);
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          debugPrint("Error: ${e.message}");
          // Suppress retry/dialog in demo/offline placeholder host
          final isPlaceholderHost = (dio.options.baseUrl).contains(
            'example.com',
          );

          if (!isFromCache && !isPlaceholderHost) {
            retryApiFromClient(e, reqOptions, dio, handler);
          } else {
            return handler.reject(e);
          }
          // return handler.next(err);
        },
      ),
    );
    return _ApiClient(dio, baseUrl: baseUrl);
  }

  // @POST(Apis.getHomePage)
  // Future<HomePageData> getHomePageData(
  //   @Field() String apiKey,
  //   @Body() String data,
  //   @Header("Content-Type") String type,
  //   @Query("offset") String offset,
  //   @Query("limit") String limit,
  // );
  @POST(Apis.getHomePage)
  Future<HomePageData> getHomePageData(
    @Field() String apiKey,
    @Body() String data,
    @Header("Content-Type") String type,
    @Query("offset") String offset,
    @Query("limit") String limit,
  );

  // @FormUrlEncoded()
  // @POST(Apis.getSplashData)
  // Future<SplashScreenModel> getSplashData(@Field() String apiKey);
  @FormUrlEncoded()
  @POST(Apis.getSplashData)
  Future<SplashScreenModel> getSplashData(@Field() String apiKey) async {
    // Fake successful splash data - works 100% offline
    await Future.delayed(const Duration(milliseconds: 800));

    return SplashScreenModel.fromJson({
      "success": true,
      "homePageData": {
        "carouselImages": [
          {
            "imageUrl":
                "https://via.placeholder.com/800x400/FF6B6B/FFFFFF?text=Flash+Sale+50%25+Off",
          },
          {
            "imageUrl":
                "https://via.placeholder.com/800x400/4ECDC4/FFFFFF?text=New+Arrivals",
          },
          {
            "imageUrl":
                "https://via.placeholder.com/800x400/45B7D1/FFFFFF?text=Free+Shipping",
          },
        ],
        "bannerImages": [
          {
            "imageUrl":
                "https://via.placeholder.com/800x250/FFA502/FFFFFF?text=Mega+Sale+Ends+Soon",
            "bannerLink": "",
          },
        ],
        "featuredCategories": [
          {
            "id": "1",
            "name": "Men",
            "imageUrl":
                "https://via.placeholder.com/300/6C5CE7/FFFFFF?text=Men",
            "hasChildren": true,
          },
          {
            "id": "2",
            "name": "Women",
            "imageUrl":
                "https://via.placeholder.com/300/FDCB6E/FFFFFF?text=Women",
            "hasChildren": true,
          },
          {
            "id": "3",
            "name": "Kids",
            "imageUrl":
                "https://via.placeholder.com/300/74B9FF/FFFFFF?text=Kids",
            "hasChildren": true,
          },
          {
            "id": "4",
            "name": "Electronics",
            "imageUrl":
                "https://via.placeholder.com/300/A29BFE/FFFFFF?text=Electronics",
            "hasChildren": true,
          },
        ],
        "newProducts": [],
        "featuredProducts": [],
      },
      "appLogo": "https://via.placeholder.com/200/2D3436/FFFFFF?text=SHOP",
      "appName": "Demo Store",
      "currency": "USD",
      "currencySymbol": "\$",
      "isRtl": false,
    });
  }

  @FormUrlEncoded()
  @POST(Apis.getProductData)
  Future<ProductScreenModel> getProductData(
    @Field() String apiKey,
    @Path() String templateId,
  );

  @POST(Apis.getCatalogProducts)
  Future<GetFilterAttribute> getCatalogData(@Body() String data);

  @POST(Apis.customerSignUp)
  Future<SignUpScreenModel> getCustomerSignUp(
    @Body() String data,
    @Header("IsGuest") int isGuest,
  );

  @POST(Apis.customerLogin)
  Future<LoginResponseModel> getCustomerLogIn(
    @Header("Login") String login,
    @Body() String data,
    @Header("Content-Type") String type,
    @Header("IsGuest") int isGuest,
  );

  @POST(Apis.mergeCart)
  Future<CartViewModel> getMergeCart(
    @Header("Login") String login,
    @Header("fcmToken") String fcmToken,
  );

  @POST(Apis.forgetPassword)
  Future<BaseModel> forgetPassword(@Body() String data);

  @FormUrlEncoded()
  @POST("{endpoint}")
  Future<GetFilterAttribute> getProductSliderData(
    @Path() String endpoint,
    @Body() String data,
    @Header("Content-Type") String contentType,
  );

  @POST(Apis.getReviewList)
  Future<ReviewListModel> getReviewList(@Body() String data);

  @POST(Apis.likeDislikeReview)
  Future<BaseModel> likeDislikeReview(@Body() String data);

  @POST(Apis.myCart)
  Future<CartViewModel> getCartData();

  @DELETE(Apis.myCart + "{lineId}")
  Future<BaseModel> removeCartItem(@Path() int lineId);

  @POST(Apis.addToWishlist)
  Future<BaseModel> addToWishlist(
    @Header("Content-Type") String contentType,
    @Body() String data,
  );

  @DELETE(Apis.removeWishlist + "{productId}")
  Future<BaseModel> removeItemFromWishlist(@Path() String productId);

  @POST(Apis.addToCart)
  Future<BaseModel> addToCart(
    @Body() String data,
    @Header("Content-Type") String contentType,
  );

  @POST(Apis.cartToWishlist)
  Future<BaseModel> cartToWishlist(
    @Body() String data,
    @Header("Content-Type") String contentType,
  );

  @DELETE(Apis.setCartEmpty)
  Future<BaseModel> setCartEmpty();

  @PUT(Apis.myCart + "{lineId}")
  Future<BaseModel> setCartItemQuantity(
    @Path() int lineId,
    @Body() String data,
  );

  @POST(Apis.addReview)
  Future<BaseModel> addReview(
    @Header("Content-Type") String contentType,
    @Body() String data,
  );

  @POST(Apis.logOut)
  Future<BaseModel> logOut(@Body() String body);

  @POST(Apis.addressList)
  Future<AddressListModel> getAddressList();

  @DELETE(Apis.deleteAddress)
  Future<BaseModel> deleteAddress(@Path() String addressId);

  @POST(Apis.countryList)
  Future<CountryListModel> getCountryList();

  @GET(Apis.shippingMethods)
  Future<ShippingMethodModel> getShippingMethods();

  @POST(Apis.paymentMethods)
  Future<PaymentModel> getPaymentMethods();

  @POST("{endpoint}")
  Future<AddressDetailModel> getAddressDetails(@Path() String endpoint);

  @PUT("{endpoint}")
  Future<BaseModel> updateAddress(@Path() String endpoint, @Body() String data);

  @POST(Apis.addNewAddress)
  Future<BaseModel> addNewAddress(@Body() String data);

  @POST(Apis.orderReview)
  Future<OrderReviewModel> getOrderReviewData(@Body() String data);

  @POST(Apis.placeOrder)
  Future<PlaceOrderModel> placeOrder(@Body() String data);

  @POST(Apis.applyCouponCode)
  Future<BaseModel> applyCouponCode(@Body() String data);

  @POST(Apis.myWishlist)
  Future<WishlistModel> getWishlistItems();

  @POST(Apis.wishlistToCart)
  Future<BaseModel> moveWishlistToCart(@Body() String data);

  @POST("{endpoint}")
  Future<OrderDetailModel> orderDetails(@Path() String endpoint);

  @POST(Apis.orderList)
  Future<OrderModel> getOrderList(@Body() String data);

  @POST(Apis.saveAccountInfo)
  Future<AccountInfoModel> saveAccountInfo(@Body() String data);

  @POST(Apis.deactivateAccount)
  Future<AccountInfoModel> deactivateAccount(@Body() String data);

  @GET(Apis.downloadInfo)
  Future<AccountInfoModel> downloadInfo();

  @PUT(Apis.saveDefaultShippingAddress + "{endPoint}")
  Future<BaseModel> saveDefaultShippingAddress(@Path() String endPoint);

  @POST(Apis.resendVerification)
  Future<BaseModel> resendVerification();

  @POST(Apis.notificationsList)
  Future<NotificationModel> getNotificationData();

  @POST(Apis.markReadNotification + "{endPoint}")
  Future<NotificationList> markReadNotification(
    @Path() String endPoint,
    @Body() String data,
  );

  @DELETE(Apis.markReadNotification + "{endPoint}")
  Future<NotificationList> deleteNotification(@Path() String endPoint);

  @POST(Apis.search)
  Future<SearchScreenModel> getSearchList(@Body() String data);

  @POST(Apis.deleteAccount)
  Future<BaseModel> deleteAccount(@Body() String data);

  @DELETE(Apis.deleteProfileImage)
  Future<BaseModel> deleteProfileImage();

  @DELETE(Apis.deleteBannerImage)
  Future<BaseModel> deleteBannerImage();

  @GET(Apis.googlePlace + "{endPoint}")
  Future<GooglePlaceModel> getGooglePlace(@Path() String endPoint);

  @GET(Apis.compare)
  Future<CompareProductModel> customerCompareList(
    @Query("products") String products,
  );

  @GET(Apis.signUpTerms)
  Future<SignUpTermsModel> getSignUpTerms();

  @GET(Apis.contactUS)
  Future<ContactUsModel> getContactUsDetails();

  @GET(Apis.walkThrough)
  Future<WalkThroughModel> getWalkThrough();

  @POST(Apis.reOrder)
  Future<BaseModel> reorderOrder(@Path() String id, @Body() String data);

  @POST(Apis.getFilterProducts)
  Future<GetFilterAttribute> getFilterProducts(@Body() String body);
}
