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
import 'dart:io';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../constants/app_constants.dart';
import '../constants/arguments_map.dart';
import '../constants/route_constant.dart';
import '../main.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app_shared_pref.dart';

class PushNotificationsManager {
  // static final FirebaseMessaging _firebaseMessaging =
  //     FirebaseMessaging.instance;
  static final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  static const initializationSettingsAndroid =
      AndroidInitializationSettings('@drawable/ic_stat_name');

  static const initializationSettingsIOS = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  final InitializationSettings initializationSettings =
      const InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void setUpFirebase(BuildContext context) async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin().androidInfo.then((value) {
        if ((value.version.sdkInt ?? 0) >= 31) {
          flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.requestNotificationsPermission();
        }
      });
    }

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      final String? payload = notificationResponse.payload;
      if (payload?.isNotEmpty ?? false) {
        print("payload" + payload.toString());
        Map notificationModelMap = json.decode(payload.toString());
        if (notificationModelMap['type'] ==
            AppConstant.productTypeNotification) {
          Navigator.pushNamed(navigatorKey.currentContext!, productPage,
              arguments: getProductDataMap(
                  notificationModelMap['name'], notificationModelMap['id']));
        } else if (notificationModelMap['type'] ==
            AppConstant.categoryTypeNotification) {
          Navigator.pushNamed(navigatorKey.currentContext!, catalogPage,
              arguments: getCatalogMap(
                "",
                false,
                notificationModelMap['name'],
                customerId: int.parse(notificationModelMap['id']),
              ));
        } else if (notificationModelMap['type'] ==
            AppConstant.customTypeNotification) {
          Navigator.pushNamed(navigatorKey.currentContext!, catalogPage,
              arguments: getCatalogMap("", false, "Catalog",
                  fromNotification: true,
                  domain: notificationModelMap['domain']));
        } else if (notificationModelMap['type'] ==
            AppConstant.orderTypeNotification) {
          Navigator.pushNamed(navigatorKey.currentContext!, orderDetails,
              arguments: getOrderDetailDataMap(
                  "mobikul/my/order/${notificationModelMap["id"]}"));
        }
      }
    });
    await _firebaseCloudMessagingListeners(context);
  }

  Future<StyleInformation?> getNotificationStyle(String? image) async {
    if (image != null && image.isNotEmpty) {
      final ByteData imageData =
          await NetworkAssetBundle(Uri.parse(image)).load("");
      return BigPictureStyleInformation(
          ByteArrayAndroidBitmap(imageData.buffer.asUint8List()));
    } else {
      return null;
    }
  }

  void showNotification(
      String title, String body, String? payload, String? image) async {
    var notificationStyle = await getNotificationStyle(image);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '${Random().nextDouble()}', 'Odoo Notification',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
        styleInformation: notificationStyle);

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: payload);
  }

  Future<String?> createFcmToken() async {
    String? token;
    // if (Platform.isIOS) {
    //   String? apnsToken = await _firebaseMessaging.getAPNSToken();
    //   if (apnsToken != null) {
    //     token = await _firebaseMessaging.getToken();
    //   } else {
    //     await Future<void>.delayed(
    //       const Duration(
    //         seconds: 3,
    //       ),
    //     );
    //     apnsToken = await _firebaseMessaging?.getAPNSToken();
    //     if (apnsToken != null) {
    //       token = await _firebaseMessaging.getToken();
    //     }
    //   }
    // } else {
    //   token = await _firebaseMessaging.getToken();
    // }
    // print("token-->${token}");

    return token;
  }

  Future<String?> createDeviceId() async {
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print("deviceId${iosInfo.identifierForVendor}");

      AppSharedPref().setDeviceID(iosInfo.identifierForVendor.toString());
      return iosInfo.identifierForVendor.toString();
    } else {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print("deviceId${androidInfo.id}");
      AppSharedPref().setDeviceID(androidInfo.id.toString());
      return androidInfo.id.toString();
    }
  }

  _firebaseCloudMessagingListeners(BuildContext context) async {
    if (Platform.isIOS) {
      _iosPermission();
    }

    var fcmToken = await createFcmToken();
    AppSharedPref().setFcmToken(fcmToken ?? "");

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print("deviceId${iosInfo.identifierForVendor}");
      AppSharedPref().setDeviceID(iosInfo.identifierForVendor.toString());
    } else {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print("deviceId${androidInfo.id}");
      AppSharedPref().setDeviceID(androidInfo.id.toString());
    }

    // _firebaseMessaging.subscribeToTopic("Mobikul");// for PLM
    // _firebaseMessaging.subscribeToTopic("DEFAULT"); // for Live

    //When app is in Working state
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    //   RemoteNotification? notification = message.notification;
    //   print('on message ${message.data}');
    //   print("onMessageNotification${message.notification?.body}");
    //   String? title = notification?.title;
    //   String? body = notification?.body;
    //   String payload = Platform.isAndroid
    //       ? json.encode(message.data)
    //       : json.encode(message.data);

    //   String? imageUrl = "";
    //   if (Platform.isAndroid) {
    //     imageUrl = message.notification?.android?.imageUrl;
    //   } else {
    //     imageUrl = message.notification?.apple?.imageUrl;
    //   }
    //   showNotification(
    //       title!, body!, payload, message.data["attachment"] ?? "");
    // });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print("OnAppOpened==================>}");
    //   if (message.data['type'] == "product") {
    //     print("product");
    //     Navigator.pushNamed(navigatorKey.currentContext!, productPage,
    //         arguments:
    //             getProductDataMap(message.data['name'], message.data['id']));
    //   } else if (message.data['type'] == "category") {
    //     Navigator.pushNamed(navigatorKey.currentContext!, catalogPage,
    //         arguments: getCatalogMap(
    //           "",
    //           false,
    //           message.data['name'],
    //           customerId: int.parse(message.data['id']),
    //         ));
    //   } else if (message.data['type'] == AppConstant.customTypeNotification) {
    //     Navigator.pushNamed(navigatorKey.currentContext!, catalogPage,
    //         arguments: getCatalogMap(
    //             "", false, message.notification?.title ?? "",
    //             fromNotification: true, domain: message.data['domain']));
    //   } else if (message.data['type'] == AppConstant.orderTypeNotification) {
    //     Navigator.pushNamed(navigatorKey.currentContext!, orderDetails,
    //         arguments: getOrderDetailDataMap(
    //             "mobikul/my/order/${message.data["id"]}"));
    //   }
    // });
  }

  void checkInitialMessage(BuildContext context) {
    // _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
    //   print("open app data================>");
    //   print(message?.data);
    //   if (message?.data != null) {
    //     if (message?.data['type'] == "product") {
    //       Navigator.pushNamed(context, productPage,
    //           arguments: getProductDataMap(
    //               message?.data['name'], message?.data['id']));
    //     } else if (message?.data['type'] == "category") {
    //       Navigator.pushNamed(context, catalogPage,
    //           arguments: getCatalogMap(
    //             "",
    //             false,
    //             message?.data['name'],
    //             customerId: int.parse(message?.data['id']),
    //           ));
    //     } else if (message?.data['type'] ==
    //         AppConstant.customTypeNotification) {
    //       Navigator.pushNamed(navigatorKey.currentContext!, catalogPage,
    //           arguments: getCatalogMap(
    //               "", false, message?.notification?.title ?? "",
    //               fromNotification: true, domain: message?.data['domain']));
    //     } else if (message?.data['type'] == AppConstant.orderTypeNotification) {
    //       Navigator.pushNamed(navigatorKey.currentContext!, orderDetails,
    //           arguments: getOrderDetailDataMap(
    //               "mobikul/my/order/${message?.data["id"]}"));
    //     }
    //   }
    // });
  }

  _iosPermission() async {
    // await _firebaseMessaging
    //     .requestPermission(
    //   alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: false,
    //   sound: true,
    // )
    //     .then((value) {
    //   print("Settings registered: ${value.authorizationStatus}");
    // });
  }
}
