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
import 'package:flutter_project_structure/config/theme.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/LocalDb/floor/database.dart';
import 'package:flutter_project_structure/helper/LocalDb/floor/entities/recent_product.dart';
import 'package:flutter_project_structure/helper/LocalDb/floor/recent_view_controller.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/firebase_analytics.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_repository.dart';

import '../../../constants/arguments_map.dart';
import '../../../constants/route_constant.dart';

class RecentView extends StatefulWidget {
  const RecentView({Key? key}) : super(key: key);

  @override
  State<RecentView> createState() => _RecentViewState();
}

class _RecentViewState extends State<RecentView> {
  AppLocalizations? _localizations;
  Map<int, int> productQuantities =
      {}; // Stores quantity for each product (by index)

  List<RecentProduct>? _recentProducts;
  late double _size;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _size = (AppSizes.width / 2.5) - AppSizes.linePadding;
    fetchRecentProducts();

    RecentViewController.controller.stream.listen((event) {
      fetchRecentProducts();
    });

    super.initState();
  }

  void fetchRecentProducts() async {
    _recentProducts = await (await AppDatabase.getDatabase()).recentProductDao
        .getProducts();
    _recentProducts = _recentProducts?.reversed.toList();
    for (int i = 0; i < (_recentProducts?.length ?? 0); i++) {
      productQuantities[i] = _recentProducts?[i].productCount ?? 1;
    }
    if (mounted) {
      setState(() {});
    }
  }

  void _updateQuantity(int index, int change) {
    setState(() {
      int currentQuantity = productQuantities[index] ?? 1;
      int newQuantity = (currentQuantity + change).clamp(
        1,
        99,
      ); // Min 1, Max 99
      productQuantities[index] =
          newQuantity; // Update only the specific product quantity
    });
  }

  /// Safely parse hex color string to Color
  /// Handles null, empty, or invalid color strings
  Color _parseColor(String? colorString, Color defaultColor) {
    if (colorString == null || colorString.isEmpty) {
      return defaultColor;
    }
    
    try {
      // Remove # if present and ensure proper format
      String hexColor = colorString.replaceAll("#", "");
      
      // If empty after removing #, return default
      if (hexColor.isEmpty) {
        return defaultColor;
      }
      
      // Add 0xFF prefix for alpha channel if not present
      if (!hexColor.startsWith("0x") && !hexColor.startsWith("0X")) {
        hexColor = "0xFF$hexColor";
      }
      
      return Color(int.parse(hexColor));
    } catch (e) {
      // If parsing fails, return default color
      debugPrint("Error parsing color: $colorString - $e");
      return defaultColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return _recentProducts == null || _recentProducts?.isEmpty == true
        ? Container()
        : Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.imageRadius,
            ),
            margin: const EdgeInsets.symmetric(vertical: AppSizes.imageRadius),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppSizes.sidePadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _localizations?.translate(
                          AppStringConstant.recentlyViewed,
                        ) ??
                        "",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSizes.extraPadding),
                  SizedBox(
                    height: AppSizes.width / 1.5,
                    width: AppSizes.width,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        print(
                          "_recentProducts-->${_recentProducts?.elementAt(index).position}",
                        );

                        bool addedInWishlist =
                            AppSharedPref().getWishlistData()?.contains(
                              _recentProducts?.elementAt(index).productId,
                            ) ??
                            false;
                        return GestureDetector(
                          onTap: () {
                            AppDatabase.getDatabase().then(
                              (value) => value.recentProductDao
                                  .insertRecentProduct(
                                    RecentProduct(
                                      templateId:
                                          _recentProducts
                                              ?.elementAt(index)
                                              .templateId
                                              .toString() ??
                                          '',
                                      name: _recentProducts
                                          ?.elementAt(index)
                                          .name,
                                      priceUnit: _recentProducts
                                          ?.elementAt(index)
                                          .priceUnit,
                                      priceReduce: _recentProducts
                                          ?.elementAt(index)
                                          .priceReduce,
                                      image:
                                          _recentProducts
                                              ?.elementAt(index)
                                              .image ??
                                          '',
                                      productId:
                                          _recentProducts
                                              ?.elementAt(index)
                                              .productId ??
                                          -1,
                                      productCount:
                                          _recentProducts
                                              ?.elementAt(index)
                                              .productCount ??
                                          -1,
                                    ),
                                  )
                                  .then(
                                    (value) => RecentViewController
                                        .controller
                                        .sink
                                        .add(
                                          _recentProducts
                                                  ?.elementAt(index)
                                                  .templateId
                                                  ?.toString() ??
                                              '',
                                        ),
                                  ),
                            );
                            Navigator.of(context).pushNamed(
                              productPage,
                              arguments: getProductDataMap(
                                _recentProducts?.elementAt(index).name ?? '',
                                _recentProducts
                                        ?.elementAt(index)
                                        .templateId
                                        .toString() ??
                                    '',
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isDarkMode
                                        ? MobikulTheme.lightGrey
                                        : AppColors.gray.withOpacity(0.1),
                                    width: 2,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(AppSizes.linePadding),
                                  ),
                                ),
                                margin: const EdgeInsets.fromLTRB(
                                  AppSizes.normalPadding,
                                  AppSizes.normalPadding,
                                  AppSizes.normalPadding,
                                  0,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(
                                            AppSizes.normalPadding,
                                          ),
                                          child: ImageView(
                                            fit: BoxFit.fill,
                                            url: _recentProducts
                                                ?.elementAt(index)
                                                .image,
                                            width:
                                                _size - AppSizes.normalPadding,
                                            height:
                                                _size - AppSizes.normalPadding,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: _size,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: AppSizes.imageRadius,
                                          // top: AppSizes.imageRadius,
                                          right: AppSizes.imageRadius,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              flex: 3,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _recentProducts
                                                            ?.elementAt(index)
                                                            .name ??
                                                        '',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(
                                                      context,
                                                    ).textTheme.bodyMedium,
                                                  ),
                                                  const SizedBox(height: 8.0),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          (_recentProducts
                                                                          ?.elementAt(
                                                                            index,
                                                                          )
                                                                          .priceReduce ??
                                                                      '')
                                                                  .isNotEmpty
                                                              ? _recentProducts
                                                                        ?.elementAt(
                                                                          index,
                                                                        )
                                                                        .priceReduce ??
                                                                    ''
                                                              : _recentProducts
                                                                        ?.elementAt(
                                                                          index,
                                                                        )
                                                                        .priceUnit ??
                                                                    '',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                          style: Theme.of(
                                                            context,
                                                          ).textTheme.bodyLarge,
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible:
                                                            (_recentProducts
                                                                        ?.elementAt(
                                                                          index,
                                                                        )
                                                                        .priceReduce ??
                                                                    '')
                                                                .isNotEmpty,
                                                        child: const SizedBox(
                                                          width: 4.0,
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible:
                                                            (_recentProducts
                                                                        ?.elementAt(
                                                                          index,
                                                                        )
                                                                        .priceReduce ??
                                                                    '')
                                                                .isNotEmpty,
                                                        child: Text(
                                                          _recentProducts
                                                                  ?.elementAt(
                                                                    index,
                                                                  )
                                                                  .priceUnit ??
                                                              '',
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8.0),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          height:
                                                              AppSizes.width *
                                                              0.08,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  4,
                                                                ),
                                                            border: Border.all(
                                                              color:
                                                                  Colors.black,
                                                              width: 1,
                                                            ),
                                                          ),
                                                          padding:
                                                              const EdgeInsets.symmetric(
                                                                horizontal: 4,
                                                                vertical: 4,
                                                              ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              // Minus button with right border
                                                              IconButton(
                                                                onPressed: () {
                                                                  if ((productQuantities[index] ??
                                                                          1) >
                                                                      0) {
                                                                    setState(() {
                                                                      _updateQuantity(
                                                                        index,
                                                                        -1,
                                                                      );
                                                                    });
                                                                  }
                                                                },
                                                                icon: const Icon(
                                                                  Icons.remove,
                                                                  size: 18,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                constraints:
                                                                    const BoxConstraints(),
                                                              ),

                                                              // Quantity with right border
                                                              Expanded(
                                                                child: Center(
                                                                  child: Text(
                                                                    (productQuantities[index] ??
                                                                            1)
                                                                        .toString(),
                                                                    maxLines: 1,
                                                                    style: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyLarge
                                                                        ?.copyWith(
                                                                          color:
                                                                              Colors.black,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),

                                                              // Plus button
                                                              IconButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    _updateQuantity(
                                                                      index,
                                                                      1,
                                                                    );
                                                                  });
                                                                },
                                                                icon: const Icon(
                                                                  Icons.add,
                                                                  size: 18,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                constraints:
                                                                    const BoxConstraints(),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Container(
                                                        height:
                                                            AppSizes.width *
                                                            0.08,
                                                        width:
                                                            AppSizes.width *
                                                            0.08,
                                                        decoration: BoxDecoration(
                                                          color: MobikulTheme
                                                              .clientPrimaryColor,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                4,
                                                              ),
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey
                                                                .shade400,
                                                          ),
                                                        ),
                                                        child: InkWell(
                                                          onTap: () {
                                                            if ((AppSharedPref()
                                                                            .getIfLogin() !=
                                                                        null &&
                                                                    AppSharedPref()
                                                                            .getIfLogin() ==
                                                                        true) ||
                                                                AppSharedPref()
                                                                    .getGuestCheckout()) {
                                                              debugPrint(
                                                                "product!.productCount.toString --> ${_recentProducts!.elementAt(index).productCount!}",
                                                              );

                                                              if (_recentProducts!
                                                                      .elementAt(
                                                                        index,
                                                                      )
                                                                      .productCount! >
                                                                  1) {
                                                                AppDatabase.getDatabase().then(
                                                                  (
                                                                    value,
                                                                  ) => value
                                                                      .recentProductDao
                                                                      .insertRecentProduct(
                                                                        RecentProduct(
                                                                          templateId:
                                                                              _recentProducts!
                                                                                  .elementAt(
                                                                                    index,
                                                                                  )
                                                                                  .templateId
                                                                                  .toString() ??
                                                                              '',
                                                                          name: _recentProducts!
                                                                              .elementAt(
                                                                                index,
                                                                              )
                                                                              .name,
                                                                          priceUnit: _recentProducts!
                                                                              .elementAt(
                                                                                index,
                                                                              )
                                                                              .priceUnit,
                                                                          priceReduce: _recentProducts!
                                                                              .elementAt(
                                                                                index,
                                                                              )
                                                                              .priceReduce,
                                                                          image:
                                                                              _recentProducts!
                                                                                  .elementAt(
                                                                                    index,
                                                                                  )
                                                                                  .image ??
                                                                              '',
                                                                          productId:
                                                                              _recentProducts
                                                                                  ?.elementAt(
                                                                                    index,
                                                                                  )
                                                                                  .productId ??
                                                                              -1,
                                                                          productCount:
                                                                              _recentProducts
                                                                                  ?.elementAt(
                                                                                    index,
                                                                                  )
                                                                                  .productCount ??
                                                                              -1,
                                                                        ),
                                                                      )
                                                                      .then(
                                                                        (
                                                                          value,
                                                                        ) => RecentViewController.controller.sink.add(
                                                                          _recentProducts!
                                                                                  .elementAt(
                                                                                    index,
                                                                                  )
                                                                                  .templateId
                                                                                  ?.toString() ??
                                                                              '',
                                                                        ),
                                                                      ),
                                                                );

                                                                Navigator.of(
                                                                  context,
                                                                ).pushNamed(
                                                                  productPage,
                                                                  arguments: getProductDataMap(
                                                                    _recentProducts!
                                                                            .elementAt(
                                                                              index,
                                                                            )
                                                                            .name ??
                                                                        '',
                                                                    _recentProducts!
                                                                            .elementAt(
                                                                              index,
                                                                            )
                                                                            .templateId
                                                                            .toString() ??
                                                                        '',
                                                                  ),
                                                                );
                                                              } else if (_recentProducts!
                                                                      .elementAt(
                                                                        index,
                                                                      )
                                                                      .productCount! ==
                                                                  1) {
                                                                // DialogHelper.loaderDialog(
                                                                //     AppStringConstant
                                                                //         .loadingMessage,
                                                                //     AppStringConstant
                                                                //         .addToCartDescription,
                                                                //     context,
                                                                //     AppLocalizations.of(
                                                                //         context));
                                                                processAddToCartRequest(
                                                                  _recentProducts!
                                                                      .elementAt(
                                                                        index,
                                                                      ),
                                                                  context,
                                                                  productQuantities[index],
                                                                );
                                                              }
                                                            } else {
                                                              DialogHelper.confirmationDialog(
                                                                "${AppLocalizations.of(context)?.translate(AppStringConstant.signInToContinue)}",
                                                                context,
                                                                AppLocalizations.of(
                                                                  context,
                                                                ),
                                                                onConfirm: () async {
                                                                  Navigator.pushNamed(
                                                                    context,
                                                                    loginSignup,
                                                                    arguments:
                                                                        false,
                                                                  );
                                                                },
                                                              );
                                                            }
                                                          },
                                                          child: const Icon(
                                                            Icons
                                                                .shopping_cart_outlined,
                                                            size: 18,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible:
                                    _recentProducts
                                        ?.elementAt(index)
                                        .ribbonMessage
                                        ?.isNotEmpty ??
                                    false,
                                child:
                                    _recentProducts
                                            ?.elementAt(index)
                                            .position ==
                                        "left"
                                    ? Positioned(
                                        left: 8.0,
                                        child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          margin: const EdgeInsets.all(16.0),
                                          decoration: BoxDecoration(
                                            color: _parseColor(
                                              _recentProducts
                                                  ?.elementAt(index)
                                                  .bgColor,
                                              Colors.black,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              4.0,
                                            ),
                                          ),
                                          child: Text(
                                            _recentProducts
                                                    ?.elementAt(index)
                                                    .ribbonMessage ??
                                                "",
                                            style: TextStyle(
                                              color: _parseColor(
                                                _recentProducts
                                                    ?.elementAt(index)
                                                    .textColor,
                                                Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Positioned(
                                        right: 0.0,
                                        child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          margin: const EdgeInsets.all(16.0),
                                          decoration: BoxDecoration(
                                            color: _parseColor(
                                              _recentProducts
                                                  ?.elementAt(index)
                                                  .bgColor,
                                              Colors.black,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              4.0,
                                            ),
                                          ),
                                          child: Text(
                                            _recentProducts
                                                    ?.elementAt(index)
                                                    .ribbonMessage ??
                                                "",
                                            style: TextStyle(
                                              color: _parseColor(
                                                _recentProducts
                                                    ?.elementAt(index)
                                                    .textColor,
                                                Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                              Visibility(
                                visible:
                                    AppSharedPref()
                                        .getSplashData()
                                        ?.addons
                                        ?.wishlist ??
                                    false,
                                child: Positioned(
                                  top:
                                      _recentProducts
                                                  ?.elementAt(index)
                                                  .position ==
                                              "left" ||
                                          (_recentProducts
                                                  ?.elementAt(index)
                                                  .ribbonMessage
                                                  ?.isEmpty ??
                                              false)
                                      ? AppSizes.widgetSidePadding
                                      : AppSizes.widgetSidePadding,
                                  right: AppSizes.width * 0.05,
                                  child: Container(
                                    height: 28,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: InkWell(
                                      child: Icon(
                                        addedInWishlist == true
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        color: !addedInWishlist
                                            ? AppColors.lightGray
                                            : AppColors.red,
                                        size: 20,
                                      ),
                                      onTap: () {
                                        if (AppSharedPref().getIfLogin() !=
                                                null &&
                                            AppSharedPref().getIfLogin() ==
                                                true) {
                                          DialogHelper.loaderDialog(
                                            AppStringConstant.loadingMessage,
                                            '',
                                            context,
                                            AppLocalizations.of(context),
                                          );
                                          processWishlistClick(
                                            addedInWishlist,
                                            context,
                                            _recentProducts?.elementAt(index),
                                          );
                                          // AnalyticsEventsFirebase()
                                          //     .addWishListEvent(
                                          //       _recentProducts
                                          //               ?.elementAt(index)
                                          //               .productId
                                          //               .toString() ??
                                          //           "",
                                          //       _recentProducts
                                          //               ?.elementAt(index)
                                          //               .name ??
                                          //           "",
                                          //       _recentProducts
                                          //               ?.elementAt(index)
                                          //               .productCount ??
                                          //           1,
                                          //     );
                                        } else {
                                          DialogHelper.confirmationDialog(
                                            "${AppLocalizations.of(context)?.translate(AppStringConstant.signInToContinue)}",
                                            context,
                                            AppLocalizations.of(context),
                                            onConfirm: () async {
                                              Navigator.pushNamed(
                                                context,
                                                loginSignup,
                                                arguments: false,
                                              );
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible:
                                    (_recentProducts
                                                ?.elementAt(index)
                                                .productCount ??
                                            0) >
                                        1 &&
                                    (AppSharedPref().getCompareAvailability() ??
                                        false),
                                child: Positioned(
                                  top:
                                      _recentProducts
                                                  ?.elementAt(index)
                                                  .position ==
                                              "left" ||
                                          (_recentProducts
                                                  ?.elementAt(index)
                                                  .ribbonMessage
                                                  ?.isEmpty ??
                                              false)
                                      ? AppSizes.buttonHeight * 1.2
                                      : AppSizes.buttonHeight * 1.2 +
                                            AppSizes.normalPadding,
                                  right: AppSizes.width * 0.05,
                                  child: Container(
                                    height: 28,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: InkWell(
                                      child: const Icon(
                                        Icons.compare_arrows,
                                        color: AppColors.lightGray,
                                        size: 20,
                                      ),
                                      onTap: () async {
                                        List? compareData =
                                            AppSharedPref().getCompareData() ??
                                            [];
                                        bool addedInCompare =
                                            AppSharedPref()
                                                .getCompareData()
                                                ?.contains(
                                                  _recentProducts
                                                      ?.elementAt(index)
                                                      .productId,
                                                ) ??
                                            false;
                                        if (AppSharedPref().getIfLogin() !=
                                                null &&
                                            AppSharedPref().getIfLogin() ==
                                                true) {
                                          if (!addedInCompare) {
                                            compareData.add(
                                              _recentProducts
                                                  ?.elementAt(index)
                                                  .productId,
                                            );
                                            AppSharedPref().setCompareData(
                                              compareData,
                                            );
                                            AlertMessage.showSuccess(
                                              AppLocalizations.of(
                                                    context,
                                                  )?.translate(
                                                    AppStringConstant
                                                        .addedItemsInCompare,
                                                  ) ??
                                                  "",
                                              context,
                                            );
                                            print(
                                              "compareListId:---$compareData",
                                            );
                                          } else {
                                            AlertMessage.showError(
                                              AppLocalizations.of(
                                                    context,
                                                  )?.translate(
                                                    AppStringConstant
                                                        .alreadyItemsInCompare,
                                                  ) ??
                                                  "",
                                              context,
                                            );
                                          }
                                        } else {
                                          DialogHelper.confirmationDialog(
                                            "${AppLocalizations.of(context)?.translate(AppStringConstant.signInToContinue)}",
                                            context,
                                            AppLocalizations.of(context),
                                            onConfirm: () async {
                                              Navigator.pushNamed(
                                                context,
                                                loginSignup,
                                                arguments: false,
                                              );
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: _recentProducts?.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  void processAddToCartRequest(
    RecentProduct? product,
    BuildContext context,
    int? quantity,
  ) async {
    ProductScreenRepositoryImp? repository = ProductScreenRepositoryImp();
    try {
      BaseModel model = await repository.addTocart(
        product!.productId!.toString(),
        quantity ?? 1,
      );
      if (model.success!) {
        AlertMessage.showSuccess(model.message!, context);
        AppSharedPref().setGuestCartCount(model.cartCount ?? 0);
      } else {
        AlertMessage.showError(model.message!, context);
      }
      // Navigator.pop(context);
    } catch (error, _) {
      debugPrint(error.toString());
      // Navigator.pop(context);
      AlertMessage.showError(error.toString(), context);
    }
  }

  void processWishlistClick(
    bool isInWishlist,
    BuildContext context,
    RecentProduct? product,
  ) async {
    ProductScreenRepositoryImp? repository = ProductScreenRepositoryImp();
    List<int>? wishlistData = AppSharedPref().getWishlistData();
    try {
      BaseModel model = BaseModel();
      if (!isInWishlist) {
        model = await repository.addToWishlist(
          product!.productId!.toString(),
          product.name ?? '',
        );
        if (model.success!) {
          AlertMessage.showSuccess(model.message!, context);
          wishlistData!.add(product.productId!);
          AppSharedPref().setWishlistData(wishlistData);
        } else {
          AlertMessage.showError(model.message!, context);
        }
      } else {
        model = await repository.removeFromWishlist(
          product!.productId.toString(),
        );
        if (model.success!) {
          AlertMessage.showSuccess(model.message!, context);
          wishlistData!.remove(product.productId);
          AppSharedPref().setWishlistData(wishlistData);
        } else {
          AlertMessage.showError(model.message!, context);
        }
      }
      reassemble();

      Navigator.pop(context);
    } catch (error, _) {
      debugPrint(error.toString());
      Navigator.pop(context);
      AlertMessage.showError(error.toString(), context);
    }
    setState(() {});
  }
}
