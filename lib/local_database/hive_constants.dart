/*
 *  Webkul Software.
 *
 *  @package  Mobikul Application Code.
 *  @Category Mobikul
 *  @author Webkul <support@webkul.com>
 *  @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *  @license https://store.webkul.com/license.html 
 *  @link https://store.webkul.com/license.html
 *
 */

import 'dart:convert';

class HiveConstants {
  static String getSplashModelBoxName() {
    String modelName = 'SplashModelBox';
    String boxName = modelName;
    return boxName;
  }

  static String getHomePageModelBoxName() {
    String modelName = 'HomePageModelBox';
    String boxName = modelName;
    return boxName;
  }

  static String getProductPageModelBoxName(String idLang, String idCurrency, String productId) {
    String modelName = 'ProductPageModelBox';
    String boxName = "${modelName}_${idLang}_${idCurrency}_$productId";
    return boxName;
  }

  static String getCategoryPageBoxName(String body) {
    Map<String, dynamic> data = json.decode(body);
    var cid = data["cid"]??"" ;
    var limit = data["limit"] ??"";
    var offset = data["offset"]??"";
    String modelName = 'CategoryPageModelBox';
    String boxName = "${modelName}_cid${cid}_limit${limit}_offset${offset}";
    return boxName;
  }

  static String getProductSliderBoxName(String body, String url) {
    url =  url.replaceAll("/", "_");
    Map<String, dynamic> data = json.decode(body);
    var limit = data["limit"]??"";
    var offset = data["offset"]??"";
    String modelName = 'ProductSliderModelBox';
    String boxName = "${modelName}_limit${limit}_offset${offset}_${url}";
    return boxName;
  }

  static String getProductDataBoxName(String templateId) {
    String modelName = 'ProductDataModelBox';
    String boxName = "${modelName}_${templateId}";
    return boxName;
  }
}
