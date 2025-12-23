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
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

abstract class AddressBookRepository {
  Future<AddressListModel> getAddressList();
  Future<BaseModel> deleteAddress(String addressId);
}

class AddressBookRepositoryImp extends AddressBookRepository {
  @override
  Future<AddressListModel> getAddressData() async {
    AddressListModel model;
    model = await ApiClient().getAddressList();
    return model;
  }

  @override
  Future<AddressListModel> getAddressList() async {
    AddressListModel model;
    model = await ApiClient().getAddressList();
    print("qwdqwd--${model.defaultShippingAddressId?.toJson()}");
    return model;
  }

  @override
  Future<BaseModel> deleteAddress(String addressId)async {
    BaseModel model;
    model = await ApiClient().deleteAddress(addressId);
    return model;
  }
}
