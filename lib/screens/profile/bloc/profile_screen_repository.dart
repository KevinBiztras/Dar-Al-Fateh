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

import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/push_notifications_manager.dart';
import 'package:flutter_project_structure/models/AccountInfoModel.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

abstract class ProfileScreenRepository{
  Future<BaseModel> logOut();
  Future<AccountInfoModel> setImage(String image,String type);
  Future<BaseModel> deleteImage();
  Future<BaseModel> deleteBannerImage();
}

class ProfileScreenRepositoryImp implements ProfileScreenRepository{
  @override
  Future<BaseModel> logOut() async{
    String fcmToken = await PushNotificationsManager().createFcmToken()??"";
    String fcmDeviceId = AppSharedPref().getDeviceID() ?? "";
    Map<String, dynamic> data ={};
    data["fcmToken"] =  fcmToken;
    data["fcmDeviceId"] = fcmDeviceId;
    String body = json.encode(data);
    BaseModel? model;
    model = await ApiClient().logOut(body);
    return model;
  }

  @override
  Future<AccountInfoModel> setImage(String image,String type) async{
    AccountInfoModel? model;
    Map<String,dynamic> data = {};
    data[type] = image;
    String body = json.encode(data);
    model = await ApiClient().saveAccountInfo(body);
    return model;
  }

  @override
  Future<BaseModel> deleteImage() async{
    BaseModel? baseModel;
    baseModel = await ApiClient().deleteProfileImage();
    return baseModel;
  }

  @override
  Future<BaseModel> deleteBannerImage() async{
    BaseModel? baseModel;
    baseModel = await ApiClient().deleteBannerImage();
    return baseModel;
  }
}
