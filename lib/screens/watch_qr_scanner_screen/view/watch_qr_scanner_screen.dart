/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/models/LoginResponseModel.dart';
import 'package:flutter_project_structure/screens/accountInfo/bloc/account_info_bloc.dart';
import 'package:flutter_project_structure/screens/accountInfo/bloc/account_info_events.dart';
import 'package:flutter_project_structure/screens/accountInfo/bloc/account_info_state.dart';

import '../../search/views/bar_code_scanner_file.dart';

class WatchQRScannerScreen extends StatefulWidget {
  const WatchQRScannerScreen({Key? key}) : super(key: key);

  @override
  State<WatchQRScannerScreen> createState() => _WatchQRScannerScreenState();
}

class _WatchQRScannerScreenState extends State<WatchQRScannerScreen> {
  LoginResponseModel? loginResponseModel;
  AccountInfoBloc? accountInfoBloc;
  bool isLoading = false;

  @override
  void initState() {
    accountInfoBloc = context.read();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MobileScannerSimple()),
    ).then((value) {
      print("here is the value ==>${value}");
      if (value.isNotEmpty) {
        var data = json.decode(value);
        if (data != -1) {
          accountInfoBloc?.add(
            LoginOnWatchEvent(
              data['fcmToken'],
              data['fcmDeviceId'],
              data['watch_login'],
            ),
          );
        } else {
          Navigator.pop(context);
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AccountInfoBloc, AccountInfoState>(
        builder: (BuildContext context, AccountInfoState currentState) {
          if (currentState is AccountInfoLoadingState) {
            isLoading = true;
          } else if (currentState is LoginOnWatchSuccessState) {
            isLoading = false;
            loginResponseModel = currentState.data;
            if (loginResponseModel?.success == true) {
              // AppSharedPref().setUserData(loginResponseModel);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  splash,
                  (route) => false,
                );
              });
            }
          } else if (currentState is AccountInfoErrorState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AlertMessage.showError(currentState.message, context);
            });
          }
          return Loader();
        },
      ),
    );
  }
}
