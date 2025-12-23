//============================Map Keys==============================//
import 'package:flutter_project_structure/models/OrderDetailModel.dart';

import '../models/HomeScreenModel.dart';

const addressKey = 'address';
const shippingMethodKey = 'shippingMethod';
const shippingIdKey = "shippingId";
const shippingAddressIdKey = "shippingAddressId";
const customerIdKey = "customerId";
const urlKey = 'url';
const fromHomePageKey = "fromHomePage";
const productIdKey = "productId";
const productNameKey = "productName";
const productImageKey = "productImage";
const productDataKey = "productData";
const subCategoryListKey = "subCategoryList";
const addressEndpointKey = "addressEndpoint";
const templateIdKey = "templateId";
const categoryNameKey = "categoryName";
const fromNotificationKey = "fromNotification";
const domainKey = "domain";
const productUrlKey = "productUrlKey";
const fromOrderListKey = "fromOrderListKey";
const amtToBePaidKey = "amtToBePaidKey";
const isHasDefaultShippingKey = "isHasDefaultShippingKey";
const deliveryBoyIdKey = "deliveryBoyId";
const shippingAddressKey = "shippingAddress";
const shippingAddressLat = "shippingAddressLat";
const shippingAddressLong = "shippingAddressLong";
const wareHouseAddress = "wareHouseAddress";
const wareHouseAddressLat = "wareHouseAddressLat";
const wareHouseAddressLong = "wareHouseAddressLong";

const categoryIdKey = "categoryIdKey";
const maxPriceKey = "maxPriceKey";
const minPriceKey = "minPriceKey";
const filterListKey = "filterListKey";

//===============================================================//

Map<String, dynamic> getCheckoutMap(
    int shippingId, int shippingAddressId, String addressEndpoint) {
  Map<String, dynamic> args = {};
  args[addressEndpointKey] = addressEndpoint;
  args[shippingAddressIdKey] = shippingAddressId;
  args[shippingIdKey] = shippingId;
  return args;
}

Map<String, dynamic> getCatalogMap(
     String url, bool fromHomepage,String categoryName,{bool fromNotification = false, String domain = "",int customerId = 0}) {
  Map<String, dynamic> args = {};
  args[customerIdKey] = customerId;
  args[urlKey] = url;
  args[fromHomePageKey] = fromHomepage;
  args[categoryNameKey] = categoryName;
  args[fromNotificationKey] = fromNotification;
  args[domainKey] = domain;
  return args;
}

Map<String, dynamic> getProductDataMap(String productName, String productId) {
  Map<String, dynamic> args = {};
  args[productNameKey] = productName;
  args[productIdKey] = productId;
  return args;
}

Map<String, dynamic> subCategoryDataMap(
    List<Categories>? subCategoryList, int? customerId,String categoryName) {
  Map<String, dynamic> args = {};
  args[subCategoryListKey] = subCategoryList;
  args[customerIdKey] = customerId;
  args[categoryNameKey] = categoryName;
  return args;
}


Map<String, dynamic> getReviewDataMap(String productName, String thumbNail, int templateId){
  Map<String, dynamic> args = {};
  args[productNameKey] = productName;
  args[productImageKey] = thumbNail;
  args[templateIdKey] = templateId;
  return args;
}

Map<String, dynamic> getOrderDetailDataMap(String productUrl, {bool fromOrderList = true})
{
  Map<String, dynamic> args = {};
  args[productUrlKey] = productUrl;
  args[fromOrderListKey] = fromOrderList;
  return args;
}
Map<String, dynamic> getCheckoutDataMap( String amtToBePaid,bool isHasDefaultShipping, )
{
  Map<String, dynamic> args = {};
  args[amtToBePaidKey] = amtToBePaid;
  args[isHasDefaultShippingKey] = isHasDefaultShipping;
  return args;
}

Map<String, dynamic> getOrderTrackingDataMap(String deliveryBoyId,String shippingAddress, double latitude, double longitude, WarehouseDetails? warehouseDetails)
{
  Map<String, dynamic> args = {};
  args[deliveryBoyIdKey] = deliveryBoyId;
  args[shippingAddressKey] = shippingAddress;
  args[shippingAddressLat] = latitude;
  args[shippingAddressLong] = longitude;
  args[wareHouseAddress] = warehouseDetails?.address??"";
  args[wareHouseAddressLat] = warehouseDetails?.lat??"";
  args[wareHouseAddressLong] = warehouseDetails?.long??"";
  return args;
}
Map<String, dynamic> getFilterDetailDataMap(double maxPrice ,double minPrice,int categoryId,List<dynamic>? filterList )
{
  Map<String, dynamic> args = {};
  args[categoryIdKey] = categoryId;
  args[maxPriceKey] = maxPrice;
  args[minPriceKey] = minPrice;
  args[filterListKey] = filterList;
  return args;
}
