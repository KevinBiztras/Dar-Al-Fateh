import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../helper/app_localizations.dart';
import '../helper/app_shared_pref.dart';
import '../helper/image_view.dart';
import '../models/UserDataModel.dart';

class CommonBannerView extends StatefulWidget {
  Function(String, String)? addImageCallback;
  Function(String)? deleteImageCallBack;

  CommonBannerView(this.addImageCallback, this.deleteImageCallBack, {Key? key})
      : super(key: key);

  @override
  _CommonBannerViewState createState() => _CommonBannerViewState();
}

class _CommonBannerViewState extends State<CommonBannerView> {
  bool hasBannerImage = false;
  bool hasProfileImage = false;

  String? bannerImage;
  String? profileImage;
  String name = "";
  File? pickedBannerImage;
  File? pickedProfileImage;
  final ImagePicker _picker = ImagePicker();
  AppLocalizations? _localizations;

  @override
  void initState() {
    super.initState();
  }

  void getDetails() {
    setState(() {
      UserDataModel? userModel = AppSharedPref().getUserData();

      // bannerFromNetwork = true;
      // profileFromNetwork = true;
      bannerImage = userModel?.bannerImage;
      profileImage = userModel?.profileImage;
      if (bannerImage?.isNotEmpty ?? false) {
        hasBannerImage = true;
      } else {
        hasBannerImage = false;
      }
      if (profileImage?.isNotEmpty ?? false) {
        hasProfileImage = true;
      } else {
        hasProfileImage = false;
      }
      name = userModel?.name ?? "";
    });
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    getDetails();
    return SizedBox(
        width: AppSizes.width,
        child: commonBannerView(bannerImage, profileImage, name, () {
          setState(() {
            if (AppSharedPref().getUserData()?.email != AppConstant.demoEmail) {
              getImageOptions(
                  _localizations
                          ?.translate(AppStringConstant.uploadBannerImage)
                          .toUpperCase() ??
                      "",
                  hasBannerImage);
            } else {
              DialogHelper.showExceptionDialog(
                  _localizations?.translate(AppStringConstant.noAction) ?? "",
                  context,
                  buttonText: _localizations?.translate(AppStringConstant.ok));
            }
          });
        }, () {
          setState(() {
            if (AppSharedPref().getUserData()?.email != AppConstant.demoEmail) {
              getImageOptions(
                  _localizations
                          ?.translate(AppStringConstant.uploadProfileImage)
                          .toUpperCase() ??
                      "",
                  hasProfileImage);
            } else {
              DialogHelper.showExceptionDialog(
                  _localizations?.translate(AppStringConstant.noAction) ?? "",
                  context,
                  buttonText: _localizations?.translate(AppStringConstant.ok));
            }
          });
        }));
  }

  Widget commonBannerView(
      String? bannerImage,
      String? profileImage,
      String name,
      VoidCallback? changeBannerImage,
      VoidCallback changeProfileImage) {
    return Container(
      height: AppSizes.width,
      width: AppSizes.width,
      child: Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          child: Stack(
            children: [
              // (bannerImage != '')
              // ?
              // Container(
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //     image:
              //     NetworkImage(
              //       bannerImage ?? "",
              //     ),
              //     fit: BoxFit.fill,
              //   )),
              // )
              //     ImageView(
              //   url: bannerImage ?? '',
              //   width: AppSizes.width,
              //   fit: BoxFit.fill,
              // ),

              (bannerImage?.isNotEmpty ?? false)
                  ? Image(
                      image: CachedNetworkImageProvider(bannerImage ?? ''),
                      fit: BoxFit.fill,
                      width: AppSizes.width,
                      height: AppSizes.width,
                    )
                  : ImageView(
                      url: 'lib/assets/images/placeholder.png',
                      width: AppSizes.width,
                      fit: BoxFit.fill,
                    ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              shape: BoxShape.circle,
                              // border: Border.all(
                              //     color: MobikulTheme.accentColor,
                              //     width: 2.0)
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: (profileImage?.isNotEmpty ?? false)
                                  ? Image(
                                      image: CachedNetworkImageProvider(
                                          profileImage ?? ''),
                                      fit: BoxFit.fill)
                                  : ImageView(
                                      url: 'lib/assets/images/placeholder.png',
                                      width: AppSizes.width,
                                      fit: BoxFit.fill,
                                    ),

                              // ImageView(
                              //   url: profileImage,
                              //   fit: BoxFit.fill,
                              // )
                            )),
                        Positioned(
                            right: 2.0,
                            child: GestureDetector(
                              onTap: changeProfileImage,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  shape: BoxShape.circle,
                                ),
                                height: 25,
                                width: 25,
                                child: const Icon(
                                  Icons.edit,
                                  size: 20,
                                ),
                              ),
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.mediumPadding),
                      child: Text(
                        "${_localizations?.translate(AppStringConstant.hello) ?? ''} " +
                            name +
                            "!",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.white),
                      ),
                    )
                  ],
                ),
              ),

              Positioned(
                bottom: 10.0,
                right: 10.0,
                child: GestureDetector(
                  onTap: changeBannerImage,
                  child: Container(
                    height: 25.0,
                    width: 25.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 20,
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Future getImageOptions(String heading, bool hasImage) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            // width: AppSizes.width,
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.normalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.extraPadding),
                    child: Text(
                      heading,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  optionTile(
                      (_localizations?.translate(AppStringConstant.addImage) ??
                          ""), () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: AppSizes.height / 7,
                            width: AppSizes.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          XFile? image =
                                              await _picker.pickImage(
                                                  imageQuality: 50,
                                                  source: ImageSource.gallery);

                                          if (image != null) {
                                            var croppedFile =
                                                (await ImageCropper().cropImage(
                                              sourcePath: image.path,
                                              uiSettings: [
                                                AndroidUiSettings(
                                                    toolbarTitle: 'Cropper',
                                                    toolbarColor:
                                                        Theme.of(context)
                                                            .appBarTheme
                                                            .backgroundColor,
                                                    toolbarWidgetColor:
                                                        Theme.of(context)
                                                            .appBarTheme
                                                            .actionsIconTheme
                                                            ?.color,
                                                    initAspectRatio:
                                                        CropAspectRatioPreset
                                                            .original,
                                                    aspectRatioPresets: [
                                                      CropAspectRatioPreset.square,
                                                      CropAspectRatioPreset.ratio3x2,
                                                      CropAspectRatioPreset.original,
                                                      CropAspectRatioPreset.ratio4x3,
                                                      CropAspectRatioPreset.ratio16x9
                                                    ],
                                                    lockAspectRatio: false),
                                                IOSUiSettings(
                                                  title: 'Cropper',
                                                  minimumAspectRatio: 1.0,
                                                ),
                                                WebUiSettings(
                                                  context: context,
                                                ),
                                              ],
                                            ));
                                            setState(() {
                                              if (heading ==
                                                      (_localizations
                                                              ?.translate(
                                                                  AppStringConstant
                                                                      .uploadBannerImage)
                                                              .toUpperCase() ??
                                                          "") &&
                                                  croppedFile != null) {
                                                pickedBannerImage = File(
                                                    croppedFile?.path ?? "");
                                                final bytes = pickedBannerImage
                                                    ?.readAsBytesSync();
                                                String img64 =
                                                    base64Encode(bytes!);
                                                widget.addImageCallback!(
                                                    img64,
                                                    AppConstant
                                                        .userBannerImage);
                                              } else if (heading ==
                                                      (_localizations
                                                              ?.translate(
                                                                  AppStringConstant
                                                                      .uploadProfileImage)
                                                              .toUpperCase() ??
                                                          "") &&
                                                  croppedFile != null) {
                                                pickedProfileImage = File(
                                                    croppedFile?.path ?? "");

                                                final bytes = pickedProfileImage
                                                    ?.readAsBytesSync();
                                                String img64 =
                                                    base64Encode(bytes!);
                                                widget.addImageCallback!(img64,
                                                    AppConstant.profileImage);
                                              }

                                              Navigator.of(context).pop();
                                            });
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.browse_gallery_outlined,
                                          size: 25,
                                        )),
                                    Text(
                                      _localizations
                                              ?.translate(
                                                  AppStringConstant.gallery)
                                              .toUpperCase() ??
                                          "",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          Navigator.of(context).pop;
                                          final XFile? photo =
                                              await _picker.pickImage(
                                                  imageQuality: 50,
                                                  source: ImageSource.camera,
                                                  maxHeight: AppSizes.width,
                                                  maxWidth: AppSizes.width);
                                          if (photo != null) {
                                            var croppedFile =
                                                (await ImageCropper().cropImage(
                                              sourcePath: photo.path,
                                              uiSettings: [
                                                AndroidUiSettings(
                                                    toolbarTitle: 'Cropper',
                                                    toolbarColor:
                                                        Theme.of(context)
                                                            .appBarTheme
                                                            .backgroundColor,
                                                    toolbarWidgetColor:
                                                        Theme.of(context)
                                                            .appBarTheme
                                                            .actionsIconTheme
                                                            ?.color,
                                                    initAspectRatio:
                                                        CropAspectRatioPreset
                                                            .original,
                                                    aspectRatioPresets: [
                                                      CropAspectRatioPreset.square,
                                                      CropAspectRatioPreset.ratio3x2,
                                                      CropAspectRatioPreset.original,
                                                      CropAspectRatioPreset.ratio4x3,
                                                      // CropAspectRatioPreset.ratio16x9
                                                    ],
                                                    lockAspectRatio: false),
                                                IOSUiSettings(
                                                  title: 'Cropper',
                                                  minimumAspectRatio: 1.0,
                                                ),
                                                WebUiSettings(
                                                  context: context,
                                                ),
                                              ],
                                            ));
                                            setState(() {
                                              Navigator.of(context).pop();
                                              if (heading ==
                                                  (_localizations
                                                          ?.translate(
                                                              AppStringConstant
                                                                  .uploadBannerImage)
                                                          .toUpperCase() ??
                                                      "")) {
                                                // bannerFromNetwork = false;
                                                pickedBannerImage = File(
                                                    croppedFile?.path ?? "");
                                                final bytes = pickedBannerImage
                                                    ?.readAsBytesSync();
                                                String img64 =
                                                    base64Encode(bytes!);
                                                widget.addImageCallback!(
                                                    img64,
                                                    AppConstant
                                                        .userBannerImage);
                                              } else {
                                                // profileFromNetwork = false;
                                                pickedProfileImage = File(
                                                    croppedFile?.path ?? "");
                                                final bytes = pickedProfileImage
                                                    ?.readAsBytesSync();
                                                String img64 =
                                                    base64Encode(bytes!);
                                                widget.addImageCallback!(img64,
                                                    AppConstant.profileImage);
                                              }
                                            });
                                          }
                                        },
                                        icon: const Icon(Icons.camera)),
                                    Text(
                                        _localizations
                                                ?.translate(
                                                    AppStringConstant.camera)
                                                .toUpperCase() ??
                                            "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge)
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  }),
                  (hasImage)
                      ? optionTile(
                          (_localizations
                                  ?.translate(AppStringConstant.deleteImage) ??
                              ""), () {
                          Navigator.of(context).pop();
                          setState(() {
                            if (heading ==
                                (_localizations
                                        ?.translate(
                                            AppStringConstant.uploadBannerImage)
                                        .toUpperCase() ??
                                    "")) {
                              widget.deleteImageCallBack!(
                                  AppConstant.bannerImage);
                              // bannerFromNetwork=true;
                            } else {
                              widget.deleteImageCallBack!(
                                  AppConstant.profileImage);
                              // profileFromNetwork = true;
                            }
                          });
                        })
                      : Container(),
                  optionTile(
                      _localizations?.translate(AppStringConstant.cancel) ?? '',
                      () {
                    Navigator.pop(context);
                  }),
                ],
              ),
            ),
          );
        },
        constraints: BoxConstraints(maxHeight: AppSizes.height / 3));
  }

  Widget optionTile(String title, VoidCallback? addAction) {
    return GestureDetector(
      onTap: addAction,
      child: SizedBox(
          height: AppSizes.itemHeight,
          width: AppSizes.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Divider()
            ],
          )),
    );
  }
}
