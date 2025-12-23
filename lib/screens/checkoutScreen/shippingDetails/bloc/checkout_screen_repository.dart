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

import 'package:flutter_project_structure/models/AddressListModel.dart';
import 'package:flutter_project_structure/models/ShippingMethodModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

abstract class CheckoutScreenRepository {
  Future<AddressListModel> getShippingAddress();
  Future<ShippingMethodModel> getShippingMethods();
}

class CheckoutScreenRepositoryImp extends CheckoutScreenRepository {
  @override
  Future<AddressListModel> getShippingAddress() async {
    AddressListModel model;
    model = await ApiClient().getAddressList();
    return model;
  }

  @override
  Future<ShippingMethodModel> getShippingMethods() async {
    ShippingMethodModel model;
    model = await ApiClient().getShippingMethods();
    return model;
  }

}