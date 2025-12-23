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

import 'dart:convert';

import 'package:flutter_project_structure/models/AccountInfoModel.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/LoginResponseModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

import '../../../helper/app_shared_pref.dart';
import '../../../helper/encryption.dart';
import '../../../helper/push_notifications_manager.dart';

abstract class AccountInfoRepository {
  Future<AccountInfoModel> saveAccountInfo(String name, String password);

  Future<AccountInfoModel> deactivateAccount(String type);

  Future<AccountInfoModel> downloadAccountInfo();

  Future<BaseModel> resendVerificationMail();

  Future<LoginResponseModel> loginUser(String email, String password);

  Future<LoginResponseModel> loginUserOnWatch(String fcmToken,String fcmDeviceId,bool watchLogin);

  Future<BaseModel> deleteAccount();
}

class AccountInfoRepositoryImp implements AccountInfoRepository {
  @override
  Future<AccountInfoModel> deactivateAccount(String type) async {
    AccountInfoModel? model;
    Map<String, dynamic> data = {};
    data["type"] = type;
    String body = json.encode(data);
    model = await ApiClient().deactivateAccount(body);
    return model;
  }

  @override
  Future<AccountInfoModel> downloadAccountInfo() async {
    AccountInfoModel? model;
    model = await ApiClient().downloadInfo();
    return model;
  }

  @override
  Future<AccountInfoModel> saveAccountInfo(String name, String password) async {
    AccountInfoModel? model;
    Map<String, dynamic> data = {};
    data["name"] = name;
    if (password != '') {
      data["password"] = password;
    }
    String body = json.encode(data);
    model = await ApiClient().saveAccountInfo(body);
    if (model.success == true && password != '') {
      Map<String, dynamic> header = {};
      header["login"] = AppSharedPref().getUserData()?.email;
      header["pwd"] = password;
      String key = generateEncodedApiKey(json.encode(header));
      AppSharedPref().setLoginKey(key);
    }
    return model;
  }

  @override
  Future<BaseModel> resendVerificationMail() async {
    BaseModel? model;
    model = await ApiClient().resendVerification();
    return model;
  }

  @override
  Future<LoginResponseModel> loginUser(String email, String password) async {
    var firebaseToken = await PushNotificationsManager().createFcmToken();
    print(firebaseToken);
    Map<String, dynamic> header = {};
    Map<String, dynamic> data = {};
    header["login"] = email;
    header["pwd"] = password;
    data['fcmToken'] = firebaseToken;
    data['customerId'] = "";
    data['fcmDeviceId'] = AppSharedPref().getDeviceID() ?? "";
    String headerData = json.encode(header);
    String bodyData = json.encode(data);
    String key = generateEncodedApiKey(headerData);
    var model = await ApiClient().getCustomerLogIn(key, bodyData, "text/plain",0);
    if (model.success == true) {
      AppSharedPref().setLoginKey(key);
    }
    return model;
  }

  @override
  Future<LoginResponseModel> loginUserOnWatch(String fcmToken,String fcmDeviceId,bool watchLogin) async {
    Map<String, dynamic> data = {};
    data['watch_login'] = watchLogin;
    data['fcmToken'] = fcmToken;
    data['customerId'] = "";
    data['fcmDeviceId'] = fcmDeviceId;
    String bodyData = json.encode(data);
    var model = await ApiClient().getCustomerLogIn(AppSharedPref().getLoginKey() ?? '', bodyData, "text/plain",0);
    if (model.success == true) {
      AppSharedPref().setLoginKey(AppSharedPref().getLoginKey() ?? '');
    }
    return model;
  }


  @override
  Future<BaseModel> deleteAccount() async {
    BaseModel? model;
    model = await ApiClient().deleteAccount("");
    return model;
  }
}
