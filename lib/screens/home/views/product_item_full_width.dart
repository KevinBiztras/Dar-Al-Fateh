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
import 'package:flutter_project_structure/constants/arguments_map.dart';

import '../../../config/theme.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_string_constant.dart';
import '../../../constants/route_constant.dart';
import '../../../customWidgtes/dialog_helper.dart';
import '../../../helper/LocalDb/floor/database.dart';
import '../../../helper/LocalDb/floor/entities/recent_product.dart';
import '../../../helper/LocalDb/floor/recent_view_controller.dart';
import '../../../helper/alert_message.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/app_shared_pref.dart';
import '../../../helper/firebase_analytics.dart';
import '../../../helper/image_view.dart';
import '../../../local_database/hive_constants.dart';
import '../../../local_database/hive_service.dart';
import '../../../models/BaseModel.dart';
import '../../../models/HomeScreenModel.dart';
import '../../product/bloc/product_screen_repository.dart';

class ProductItemFullWidth extends StatefulWidget {
  final Products? product;
  final void Function(Products product)? onAddToCart;

  const ProductItemFullWidth({super.key, this.product,this.onAddToCart});

  @override
  State<StatefulWidget> createState() {
    return ProductItemFullWidthState();
  }
}

class ProductItemFullWidthState extends State<ProductItemFullWidth> {
  double? imageSize;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    imageSize = (AppSizes.width / 2.5) - AppSizes.linePadding;
    bool addedInWishlist = AppSharedPref()
            .getWishlistData()
            ?.contains(widget.product?.productId) ??
        false;
    return GestureDetector(
      onTap: () {
        AppDatabase.getDatabase().then(
          (value) => value.recentProductDao
              .insertRecentProduct(
                RecentProduct(
                    templateId: widget.product?.templateId?.toString() ?? '',
                    name: widget.product?.name,
                    priceUnit: widget.product?.priceUnit,
                    priceReduce: widget.product?.priceReduce,
                    image: widget.product?.thumbNail,
                    productCount: widget.product?.productCount,
                    productId: widget.product?.productId),
              )
              .then(
                (value) => RecentViewController.controller.sink
                    .add(widget.product?.templateId?.toString() ?? ''),
              ),
        );
        Navigator.of(context).pushNamed(productPage,
            arguments: getProductDataMap(widget.product?.name ?? '',
                widget.product?.templateId.toString() ?? ''));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              color: MobikulTheme.lightGrey,
            )),
        margin: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: AppSizes.imageRadius,
            ),
            Stack(children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                child: ImageView(
                  fit: BoxFit.cover,
                  url: widget.product?.thumbNail,
                  width: imageSize!,
                  height: imageSize! - AppSizes.normalPadding,
                ),
              ),
              Visibility(
                visible: (widget.product?.productCount ?? 0) > 1,
                child: Positioned(
                  top: widget.product?.ribbon?.position == "left" ||
                      (widget.product?.ribbon?.ribbonMessage?.isEmpty ?? false)
                      ? AppSizes.buttonRadius * 2
                      : AppSizes.buttonHeight * 2 + AppSizes.normalPadding,
                  right: AppSizes.width * 0.03,
                  child: Container(
                    height: 28,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: InkWell(
                      child: const Icon(
                        Icons.compare_arrows,
                        color: AppColors.lightGray,
                        size: 20,
                      ),
                      onTap: () async {
                        List? compareData = AppSharedPref().getCompareData() ?? [];
                        bool addedInCompare = AppSharedPref()
                            .getCompareData()
                            ?.contains(widget.product?.productId) ??
                            false;
                        if (AppSharedPref().getIfLogin() != null &&
                            AppSharedPref().getIfLogin() == true) {
                          if (!addedInCompare) {
                            compareData.add(widget.product?.productId);
                            AppSharedPref().setCompareData(compareData);
                            AlertMessage.showSuccess(
                                AppLocalizations.of(context)?.translate(
                                    AppStringConstant.addedItemsInCompare) ??
                                    "",
                                context);
                            print("compareListId:---$compareData");
                          } else {
                            AlertMessage.showError(
                                AppLocalizations.of(context)?.translate(
                                    AppStringConstant.alreadyItemsInCompare) ??
                                    "",
                                context);
                          }
                        } else {
                          DialogHelper.confirmationDialog(
                              "${AppLocalizations.of(context)?.translate(AppStringConstant.signInToContinue)}",
                              context,
                              AppLocalizations.of(context), onConfirm: () async {
                            Navigator.pushNamed(context, loginSignup,
                                arguments: false);
                          });
                        }
                      },
                    ),
                  ),
                ),
              ),
              // Visibility(
              //   visible:
              //   (widget.product?.productCount ?? 0) > 1,
              //   child: widget.product?.ribbon?.position == "left"
              //       ? Positioned(
              //           left: 8.0,
              //           child: Container(
              //               padding: const EdgeInsets.all(8.0),
              //               margin: const EdgeInsets.all(16.0),
              //               decoration: BoxDecoration(
              //                   color: Color(int.parse(
              //                       (widget.product?.ribbon?.bgColor ?? "")
              //                           .replaceAll("#", "0xFF"))),
              //                   borderRadius: BorderRadius.circular(4.0)),
              //               child: Text(widget.product?.ribbon?.ribbonMessage ?? "",
              //                   style: TextStyle(
              //                       color: Color(int.parse(
              //                           (widget.product?.ribbon?.textColor ?? "")
              //                               .replaceAll("#", "0xFF")))))),
              //         )
              //       : Positioned(
              //           right: 0.0,
              //           child: Container(
              //               padding: const EdgeInsets.all(8.0),
              //               margin: const EdgeInsets.all(16.0),
              //               decoration: BoxDecoration(
              //                   color: Color(int.parse(
              //                       (widget.product?.ribbon?.bgColor ?? "")
              //                           .replaceAll("#", "0xFF"))),
              //                   borderRadius: BorderRadius.circular(4.0)),
              //               child: Text(
              //                 widget.product?.ribbon?.ribbonMessage ?? "",
              //                 style: TextStyle(
              //                     color: Color(int.parse(
              //                         (widget.product?.ribbon?.textColor ?? "")
              //                             .replaceAll("#", "0xFF")))),
              //               )),
              //         ),
              // ),
              Positioned(
                top: widget.product?.ribbon?.position == "left" ||
                    (widget.product?.ribbon?.ribbonMessage?.isEmpty ?? false)
                    ? AppSizes.buttonRadius * 0.5
                    : AppSizes.buttonHeight * 0.5 + AppSizes.normalPadding,
                right: AppSizes.width * 0.03,
                child: InkWell(
                  onTap: () {
                    if (AppSharedPref().getIfLogin() != null &&
                        AppSharedPref().getIfLogin() == true) {
                      DialogHelper.loaderDialog(
                          AppStringConstant.loadingMessage,
                          '',
                          context,
                          AppLocalizations.of(context));
                      processWishlistClick(
                        addedInWishlist,
                        context,
                        widget.product,
                      );
                      // AnalyticsEventsFirebase().addWishListEvent(
                      //     widget.product?.productId.toString() ?? "",
                      //     widget.product?.name ?? "",
                      //     widget.product?.productCount ?? 1);
                    } else {
                      DialogHelper.confirmationDialog(
                          "${AppLocalizations.of(context)?.translate(AppStringConstant.signInToContinue)}",
                          context,
                          AppLocalizations.of(context), onConfirm: () async {
                        Navigator.pushNamed(context, loginSignup,
                            arguments: false);
                      });
                    }
                  },
                  child:  Container(
                    height: 28,
                    width: 30,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        blurRadius: 2,
                      ),
                    ], color: Colors.white, shape: BoxShape.circle),
                    child: Icon(
                      addedInWishlist == true
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: !addedInWishlist
                          ? AppColors.lightGray
                          : AppColors.red,
                      size: 20,
                    ),
                  )
                  //
                  // Icon(
                  //   addedInWishlist == true
                  //       ? Icons.favorite
                  //       : Icons.favorite_border_outlined,
                  //   color:
                  //       !addedInWishlist ? AppColors.lightGray : AppColors.red,
                  //   size: 28,
                  // ),
                ),
              ),
            ]),
            const SizedBox(
              width: AppSizes.imageRadius,
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          (widget.product?.priceReduce ?? '').isNotEmpty
                              ? widget.product?.priceReduce ?? ''
                              : widget.product?.priceUnit ?? '',
                          style: Theme.of(context).textTheme.bodyLarge
                          // const TextStyle(
                          //   fontSize: 12.0,
                          //   color: Colors.black,
                          //   fontWeight: FontWeight.bold
                          // ),
                          ),
                      Visibility(
                          visible:
                              (widget.product?.priceReduce ?? '').isNotEmpty,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: AppSizes.linePadding,
                              ),
                              Text(widget.product?.priceUnit ?? '',
                                  style: Theme.of(context).textTheme.bodyMedium
                                  // const TextStyle(
                                  //     fontSize: 11.0,
                                  //     decoration: TextDecoration.lineThrough),
                                  ),
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 2.0,
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(widget.product?.name ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium
                        // const TextStyle(fontSize: 12.0, color: Colors.black),
                        ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // Center everything horizontally
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // Align items vertically
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              // Dark background for better contrast
                              borderRadius: BorderRadius.circular(4),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 35,
                                height: 35,
                                child: IconButton(
                                  onPressed: () {
                                    if (quantity! > 1) {
                                      if (((quantity! - 1) ?? 1) > 1) {
                                        setState(() {
                                          quantity = (quantity ?? 1) - 1;
                                          // widget.product!.productCount =
                                          //     widget.product!.productCount! + 1;
                                        });
                                      }
                                    }
                                  },
                                  icon: const Icon(Icons.remove,
                                      // color:MobikulTheme.clientAccentColor,
                                      size: 20),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  quantity.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          //    color:MobikulTheme.clientAccentColor,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                width: 35,
                                height: 35,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                    // color:MobikulTheme.clientAccentColor,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    // if(((quantity!+1)??1)<=(widget.product!.productCount??1))
                                    setState(() {
                                      quantity = (quantity ?? 1) + 1;
                                      // widget.product!.productCount =
                                      //     widget.product!.productCount! - 1;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: MobikulTheme.clientPrimaryColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: InkWell(
                            // onTap: () {
                            //   if ((AppSharedPref().getIfLogin() != null &&
                            //           AppSharedPref().getIfLogin() == true) ||
                            //       AppSharedPref().getGuestCheckout()) {
                            //     debugPrint(
                            //         "product!.productCount.toString --> " +
                            //             widget.product!.productCount
                            //                 .toString());

                            //     if (widget.product!.productCount! > 1) {
                            //       AppDatabase.getDatabase().then(
                            //         (value) => value.recentProductDao
                            //             .insertRecentProduct(
                            //               RecentProduct(
                            //                 templateId: widget
                            //                         .product?.templateId
                            //                         .toString() ??
                            //                     '',
                            //                 name: widget.product?.name,
                            //                 priceUnit:
                            //                     widget.product?.priceUnit,
                            //                 priceReduce:
                            //                     widget.product?.priceReduce,
                            //                 image:
                            //                     widget.product?.thumbNail ?? '',
                            //                 productId:
                            //                     widget.product?.productId ?? -1,
                            //                 productCount: quantity ?? 1,
                            //               ),
                            //             )
                            //             .then(
                            //               (value) => RecentViewController
                            //                   .controller.sink
                            //                   .add(widget.product?.templateId
                            //                           ?.toString() ??
                            //                       ''),
                            //             ),
                            //       );
                            //       // DialogHelper.loaderDialog(
                            //       //     AppStringConstant.loadingMessage,
                            //       //     AppStringConstant.addToCartDescription,
                            //       //     context,
                            //       //     AppLocalizations.of(context));
                            //       processAddToCartRequest(
                            //           widget.product, context, quantity);
                            //       // Navigator.of(context)
                            //       //     .pushNamed(productPage,
                            //       //     arguments: getProductDataMap(
                            //       //         widget.product?.name ?? '',
                            //       //         widget.product?.templateId.toString() ?? ''))
                            //       //     .then((value) {
                            //       //   if (value == true) {
                            //       //     widget.postWishlistClick();
                            //       //     DialogHelper.loaderDialog(
                            //       //         AppStringConstant.loadingMessage,
                            //       //         AppStringConstant.addToCartDescription,
                            //       //         context,
                            //       //         AppLocalizations.of(context));
                            //       //   processAddToCartRequest(widget.product, context,quantity);
                            //       //   }
                            //       // });
                            //     } else if (widget.product!.productCount! == 1) {
                            //       // DialogHelper.loaderDialog(
                            //       //     AppStringConstant.loadingMessage,
                            //       //     AppStringConstant.addToCartDescription,
                            //       //     context,
                            //       //     AppLocalizations.of(context));
                            //       processAddToCartRequest(
                            //           widget.product, context, quantity);
                            //     }
                            //   } else {
                            //     DialogHelper.confirmationDialog(
                            //         "${AppLocalizations.of(context)?.translate(AppStringConstant.signInToContinue)}",
                            //         context,
                            //         AppLocalizations.of(context),
                            //         onConfirm: () async {
                            //       Navigator.pushNamed(context, loginSignup,
                            //           arguments: false);
                            //     });
                            //   }
                            // },
                            onTap: () {
                              if(widget.onAddToCart!=null){
                                widget.onAddToCart!(widget.product!);
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('${widget.product?.name} added to cart'))
                                );
                              }
                            },
                            child: const Icon(
                              Icons.shopping_cart_outlined,
                              size: 30,
                              //color: Colors.black,
                            ),
                          ),
                        ),

                        // Space between cart and quantity selector
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  //
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     InkWell(
                  //       onTap: () {
                  //         if (AppSharedPref().getIfLogin() != null &&
                  //             AppSharedPref().getIfLogin() == true) {
                  //           DialogHelper.loaderDialog(
                  //               AppStringConstant.loadingMessage,
                  //               '',
                  //               context,
                  //               AppLocalizations.of(context));
                  //           processWishlistClick(
                  //               addedInWishlist, context, widget.product,);
                  //           AnalyticsEventsFirebase().addWishListEvent(
                  //               widget.product?.productId.toString() ?? "",
                  //               widget.product?.name ?? "",
                  //               widget.product?.productCount ?? 1);
                  //         } else {
                  //           DialogHelper.confirmationDialog(
                  //               "${AppLocalizations.of(context)?.translate(AppStringConstant.signInToContinue)}",
                  //               context,
                  //               AppLocalizations.of(context),
                  //               onConfirm: () async {
                  //                 Navigator.pushNamed(context, loginSignup,
                  //                     arguments: false);
                  //               });
                  //         }
                  //       },
                  //       child: Icon(
                  //         addedInWishlist == true
                  //             ? Icons.favorite
                  //             : Icons.favorite_border_outlined,
                  //         color: !addedInWishlist
                  //             ? AppColors.lightGray
                  //             : AppColors.red,
                  //         size: 32,
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 8.0,
                  //     ),
                  //     InkWell(
                  //       onTap: () {
                  //         if ((AppSharedPref().getIfLogin() != null &&
                  //             AppSharedPref().getIfLogin() == true )|| AppSharedPref().getGuestCheckout()) {
                  //           debugPrint("product!.productCount.toString --> " +
                  //               widget.product!.productCount.toString());
                  //
                  //           if (widget.product!.productCount! > 1) {
                  //             AppDatabase.getDatabase().then(
                  //                   (value) => value.recentProductDao
                  //                   .insertRecentProduct(
                  //                 RecentProduct(
                  //                     templateId: widget.product?.templateId
                  //                         .toString() ??
                  //                         '',
                  //                     name: widget.product?.name,
                  //                     priceUnit: widget.product?.priceUnit,
                  //                     priceReduce:
                  //                     widget.product?.priceReduce,
                  //                     image:
                  //                     widget.product?.thumbNail ?? '',
                  //                     productId:
                  //                     widget.product?.productId ?? -1,
                  //                     productCount:
                  //                     widget.product?.productCount ??
                  //                         -1),
                  //               )
                  //                   .then(
                  //                     (value) => RecentViewController
                  //                     .controller.sink
                  //                     .add(widget.product?.templateId
                  //                     ?.toString() ??
                  //                     ''),
                  //               ),
                  //             );
                  //
                  //             Navigator.of(context).pushNamed(productPage,
                  //                 arguments: getProductDataMap(
                  //                     widget.product?.name ?? '',
                  //                     widget.product?.templateId.toString() ??
                  //                         ''));
                  //           } else if (widget.product!.productCount! == 1) {
                  //             DialogHelper.loaderDialog(
                  //                 AppStringConstant.loadingMessage,
                  //                 AppStringConstant.addToCartDescription,
                  //                 context,
                  //                 AppLocalizations.of(context));
                  //             processAddToCartRequest(widget.product, context);
                  //           }
                  //         } else {
                  //           DialogHelper.confirmationDialog(
                  //               "${AppLocalizations.of(context)?.translate(AppStringConstant.signInToContinue)}",
                  //               context,
                  //               AppLocalizations.of(context),
                  //               onConfirm: () async {
                  //                 Navigator.pushNamed(context, loginSignup,
                  //                     arguments: false);
                  //               });
                  //         }
                  //       },
                  //       child: const Icon(
                  //         Icons.shopping_cart_outlined,
                  //         size: 32,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void processWishlistClick(
      bool isInWishlist, BuildContext context, Products? product) async {
    ProductScreenRepositoryImp? repository = ProductScreenRepositoryImp();
    List<int>? wishlistData = AppSharedPref().getWishlistData();
    try {
      BaseModel model = BaseModel();
      if (!isInWishlist) {
        model = await repository.addToWishlist(
            product!.productId!.toString(), product.name ?? '');
        if (model.success!) {
          AlertMessage.showSuccess(model.message!, context);
          wishlistData!.add(product.productId!);
          AppSharedPref().setWishlistData(wishlistData);
        } else {
          AlertMessage.showError(model.message!, context);
        }
      } else {
        model =
            await repository.removeFromWishlist(product!.productId.toString());
        if (model.success!) {
          AlertMessage.showSuccess(model.message!, context);
          wishlistData!.remove(product.productId);
          AppSharedPref().setWishlistData(wishlistData);
        } else {
          AlertMessage.showError(model.message!, context);
        }
      }
      (context as Element).reassemble();

      Navigator.pop(context);
    } catch (error, _) {
      debugPrint(error.toString());
      Navigator.pop(context);
      AlertMessage.showError(error.toString(), context);
    }
  }

  void processAddToCartRequest(
      Products? product, BuildContext context, int? quantity) async {
    ProductScreenRepositoryImp? repository = ProductScreenRepositoryImp();
    try {
      BaseModel model = await repository.addTocart(
          product!.productId!.toString(), quantity ?? 1);
      if (model.success!) {
        AlertMessage.showSuccess(model.message!, context);
        AppSharedPref().setGuestCartCount(model.cartCount ?? 0);
      } else {
        AlertMessage.showError(model.message!, context);
      }
      Navigator.pop(context);
    } catch (error, _) {
      debugPrint(error.toString());
      Navigator.pop(context);
      AlertMessage.showError(error.toString(), context);
    }
  }
}
