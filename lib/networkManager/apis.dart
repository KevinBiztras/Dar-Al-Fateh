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

class Apis {
  static const String getHomePage = 'mobikul/homepage';
  static const String getSplashData = "mobikul/splashPageData";
  static const String getProductData = "mobikul/template/{templateId}";
  static const String getCatalogProducts = "mobikul/search";
  static const String myCart = "mobikul/mycart/";
  static const String getReviewList = "product/reviews";
  static const String likeDislikeReview = "review/likeDislike";
  static const String addToWishlist = "my/addToWishlist";
  static const String removeWishlist = "my/removeFromWishlist/";
  static const String addToCart = "mobikul/mycart/addToCart";
  static const String customerSignUp = "mobikul/customer/signUp";
  static const String customerLogin = "mobikul/customer/login";
  static const String forgetPassword = "mobikul/customer/resetPassword";
  static const String cartToWishlist = "my/cartToWishlist";
  static const String setCartEmpty = "mobikul/mycart/setToEmpty";
  static const String addReview = "my/saveReview";
  static const String logOut = "mobikul/customer/signOut";
  static const String addressList = "mobikul/my/addresses";
  static const String deleteAddress = "mobikul/my/address/{addressId}";
  static const String countryList = "mobikul/localizationData";
  static const String shippingMethods = "mobikul/ShippingMethods";
  static const String paymentMethods = "mobikul/paymentAcquirers";
  static const String addNewAddress = "mobikul/my/address/new";
  static const String orderReview = "mobikul/orderReviewData";
  static const String placeOrder = "mobikul/placeMyOrder";
  static const String applyCouponCode = "mobikul/apply-coupons";
  static const String orderList = "mobikul/my/orders";
  static const String myWishlist = "mobikul/my/wishlists";
  static const String wishlistToCart = "my/wishlistToCart";
  static const String removeFromWishlist = "my/removeWishlist/";
  static const String deactivateAccount = "mobikul/gdpr/deactivate";
  static const String saveAccountInfo = "mobikul/saveMyDetails";
  static const String downloadInfo = "mobikul/gdpr/download";
  static const String saveDefaultShippingAddress = "mobikul/my/address/default/";
  static const String resendVerification = "send/verifyEmail";
  static const String notificationsList = "mobikul/notificationMessages";
  static const String markReadNotification = "mobikul/notificationMessage/";
  static const String search = "mobikul/search";
  static const String deleteProfileImage = "mobikul/deleteProfileImage";
  static const String deleteBannerImage = "mobikul/delete/customer/banner-image";
  static const String googlePlace = "place/textsearch/json?query=";
  static const String signUpTerms = "mobikul/signup/terms";
  static const String deleteAccount = "mobikul/delete/account";
  static const String contactUS = "mobikul/contactUs";
  static const String walkThrough  = "mobikul/walkThrough";
  static const String compare  = "mobikul/addToCompare";
  static const String mergeCart  = "mobikul/mergeCart";
  static const String reOrder  = "mobikul/re-order/{id}";
  static const String getFilterProducts  = "mobikul/search/filter";
  static const String getLiveChatData  = "mobikul/im_livechat/support";

}
