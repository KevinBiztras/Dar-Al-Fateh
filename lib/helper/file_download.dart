/*
 *
 *  Webkul Software.
 * @package Mobikul Application Code.
 *  @Category Mobikul
 *  @author Webkul <support@webkul.com>
 *  @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *  @license https://store.webkul.com/license.html
 *  @link https://store.webkul.com/license.html
 *
 * /
 */

// ignore_for_file: empty_catches
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'alert_message.dart';
import 'app_localizations.dart';

class DownloadFile {
  var tag = "DownloadFile";
  Dio dio = Dio();

  Future downloadPersonalData(
      String url, String fileName, BuildContext context) async {
    if (Platform.isAndroid) {
      try {
        int androidVersion = 6;
        print("DOWNLOAD_URL==========> ${url}");
        bool manageExternalStorageGranted = false;
        if (Platform.isAndroid) {
          var androidInfo = await DeviceInfoPlugin().androidInfo;
          String version = "${androidInfo.version.release}.";
          androidVersion =
              int.parse(version.substring(0, version.indexOf('.')));
          print("DOWNLOAD_URL=========parse=> $androidVersion");
          if (androidVersion >= 12) {
            manageExternalStorageGranted =
            await requestManageStoragePermission();
          }
        }
        var status = await Permission.storage.request();
        print(
            "PERMISSION=====Status===manage storage======> ${manageExternalStorageGranted}");
        print("PERMISSION=====Status===storage======> ${status.isGranted}");

        if (status.isGranted || (manageExternalStorageGranted)) {
          try {
            var savePath = await getFilePath(fileName);
            AlertMessage.showSuccess(
                AppLocalizations.of(context)?.translate("downloading") ??
                    "Downloading",
                context);
            print("${tag}permission is granted  and path is: $savePath");
            if (androidVersion >= 12) {
              var dir = await getExternalStorageDirectory();
              if (dir != null) {
                await FlutterDownloader.enqueue(
                  url: url.trim(),
                  headers: {'Header': 'Test'},
                  savedDir: dir.path,
                  showNotification: true,
                  saveInPublicStorage: true,
                  openFileFromNotification:
                  true, // click on notification to open downloaded file (for Android)
                ).then((value) {
                  // if(value != null){
                  //   Future.delayed(const Duration(seconds: 2), () {
                  //     AlertMessage.showSuccess(
                  //         AppLocalizations.of(context)
                  //             ?.translate("download_complete") ??
                  //             "Download completed",
                  //         context);
                  //   });
                  // }
                  print("taskId=====taskId===taskId======> ${value}");
                });
              }
            } else {
              dio.download(
                url,
                savePath,
                deleteOnError: true,
                onReceiveProgress: (receivedBytes, totalBytes) async {
                  //Check if download is complete and close the alert dialog
                  if (receivedBytes == totalBytes) {}
                },
              ).then((value) {
                if (value.statusCode == 200) {
                  Future.delayed(const Duration(seconds: 2), () {
                    AlertMessage.showSuccess(
                        AppLocalizations.of(context)
                            ?.translate("download_complete") ??
                            "Download completed",
                        context);
                  });
                }
              });
            }
          } on DioError catch (e) {
            print("error downloading file $e");
          }
        } else if (status.isDenied) {
          await Permission.storage.request();
          // AlertMessage.showError(Utils.getStringValue(context, AppStringConstant.noPermissionToReadWriteStorage), context);
          debugPrint(tag + "permission is denied ->requesting");
        } else if (manageExternalStorageGranted) {
          manageExternalStorageGranted = await requestManageStoragePermission();
          // AlertMessage.showError(Utils.getStringValue(context, AppStringConstant.noPermissionToReadWriteStorage), context);
          debugPrint(tag +
              "permission is denied for manageExternalStorage ->requesting");
        }
      } catch (e) {
        // AlertMessage.showError(Utils.getStringValue(context, AppStringConstant.somethingWentWrong), context);
        debugPrint(tag + "exception while downloading invoice " + e.toString());
      }
    }
    else if (Platform.isIOS) {
      AlertMessage.showSuccess(
          AppLocalizations.of(context)?.translate("downloading") ?? "Downloading",
          context);


      Directory baseDirectory = await getApplicationDocumentsDirectory();
      String customFolderPath = "${baseDirectory.path}/MyAppDownloads";
      String filePath = "$customFolderPath/$fileName";


      Directory customFolder = Directory(customFolderPath);
      if (!await customFolder.exists()) {
        await customFolder.create(recursive: true);
      }


      await dio.download(
        url,
        filePath,
        onReceiveProgress: (receivedBytes, totalBytes) {
          if (receivedBytes == totalBytes) {
            AlertMessage.showSuccess(
                AppLocalizations.of(context)?.translate("download_complete") ??
                    "Download completed",
                context);
          }
        },
      ).then((_) async {
        print("File saved at: $filePath");


        final result = await OpenFile.open(filePath);
        if (result.type != ResultType.done) {
          print("Error opening file: ${result.message}");
        }
      }).catchError((error) {
        AlertMessage.showError("Error downloading file: $error", context);
      });
    }
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
    IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  Future<bool> requestManageStoragePermission() async {
    var status = await Permission.photos.request();
    if (status.isGranted) {
      print("Permission granted");
      return true;
    } else {
      print("Permission denied");
      return false;
    }
  }

  Future<String> getFilePath(fileName) async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    var path = '${directory?.path}/$fileName';
    return path;
  }

  void bindIsolates(BuildContext context) {
    ReceivePort _port = ReceivePort();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      int progress = data[2];
      if (progress == 100) {
        AlertMessage.showSuccess(
            AppLocalizations.of(context)?.translate("download_complete") ??
                "Download completed",
            context);

      }
    });
    FlutterDownloader.registerCallback(DownloadFile.downloadCallback);
  }
}
