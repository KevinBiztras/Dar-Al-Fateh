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
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/local_database/hive_constants.dart';
import 'package:flutter_project_structure/local_database/hive_service.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_bloc.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_event.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_state.dart';

import '../../../helper/LocalDb/floor/database.dart';
import '../../../helper/LocalDb/floor/entities/recent_product.dart';
import '../../../helper/LocalDb/floor/recent_view_controller.dart';
// removed unused imports

class ItemCard extends StatefulWidget {
  final double? imageSize; 
  final int? quantity;

  final Products? product;
  final VoidCallback postWishlistClick;
  final void Function(Products product, int quantity)? onAddToCart;

  const ItemCard({
    Key? key,
    this.product,
    this.imageSize,
    required this.postWishlistClick,
    this.onAddToCart,
    this.quantity,
  }) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  int? quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.quantity ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    bool addedInWishlist =
        AppSharedPref().getWishlistData()?.contains(widget.product?.productId) ?? false;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        AppDatabase.getDatabase().then(
          (value) => value.recentProductDao
              .insertRecentProduct(
                RecentProduct(
                  templateId: widget.product?.templateId.toString() ?? '',
                  name: widget.product?.name,
                  priceUnit: widget.product?.priceUnit,
                  priceReduce: widget.product?.priceReduce,
                  image: widget.product?.thumbNail ?? '',
                  productId: widget.product?.productId ?? -1,
                  productCount: widget.product?.productCount ?? 1,
                  ribbonMessage: widget.product?.ribbon?.ribbonMessage ?? "",
                  textColor: widget.product?.ribbon?.textColor ?? "",
                  bgColor: widget.product?.ribbon?.bgColor ?? "",
                  position: widget.product?.ribbon?.position ?? "",
                ),
              )
              .then(
                (value) => RecentViewController.controller.sink
                    .add(widget.product?.templateId?.toString() ?? ''),
              ),
        );

        Navigator.of(context)
            .pushNamed(
              productPage,
              arguments: getProductDataMap(
                widget.product?.name ?? '',
                widget.product?.templateId.toString() ?? '',
              )
                ..[productDataKey] = widget.product,
            )
            .then((value) {
          if (value == true) {
            widget.postWishlistClick();
          }
        });
      },
      child: Stack(
        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(
                              AppSizes.linePadding,
                              AppSizes.normalPadding,
                              AppSizes.normalPadding,
                              0,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isDarkMode ? MobikulTheme.lightGrey : const Color(0xFFE2E8F0),
                                width: 2,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(AppSizes.linePadding),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                                  child: ImageView(
                                    fit: BoxFit.cover,
                                    url: widget.product?.thumbNail,
                                    width: (widget.imageSize ?? (AppSizes.width / 2.3)) + AppSizes.normalPadding,
                                    height: (widget.imageSize ?? (AppSizes.width / 2.3)) - AppSizes.normalPadding,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                  child: SizedBox(
                                    width: widget.imageSize ?? (AppSizes.width / 2.3),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const SizedBox(height: 8.0),
                                        Text(
                                          widget.product?.name ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.bodyLarge,
                                        ),
                                        const SizedBox(height: 8.0),
                                        Row(
                                          children: [
                                            Text(
                                              (widget.product?.priceReduce ?? '').isNotEmpty
                                                  ? widget.product?.priceReduce ?? ''
                                                  : widget.product?.priceUnit ?? '',
                                              style: Theme.of(context).textTheme.bodyLarge,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            Visibility(
                                              visible: (widget.product?.priceReduce ?? '').isNotEmpty,
                                              child: const SizedBox(width: 4.0),
                                            ),
                                            Visibility(
                                              visible: (widget.product?.priceReduce ?? '').isNotEmpty,
                                              child: Flexible(
                                                child: Text(
                                                  widget.product?.priceUnit ?? '',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                        decoration: TextDecoration.lineThrough,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8.0),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: AppSizes.width * 0.08,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(4),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1,
                                                  ),
                                                ),
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 4,
                                                  vertical: 4,
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        if ((quantity ?? 1) > 1) {
                                                          setState(() {
                                                            quantity = (quantity ?? 1) - 1;
                                                          });
                                                        }
                                                      },
                                                      icon: const Icon(
                                                        Icons.remove,
                                                        size: 18,
                                                        color: Colors.black,
                                                      ),
                                                      padding: EdgeInsets.zero,
                                                      constraints: const BoxConstraints(),
                                                    ),
                                                    Expanded(
                                                      child: Center(
                                                        child: Text(
                                                          (quantity ?? 1).toString(),
                                                          maxLines: 1,
                                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                                color: Colors.black,
                                                                fontWeight: FontWeight.bold,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          quantity = (quantity ?? 1) + 1;
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons.add,
                                                        size: 18,
                                                        color: Colors.black,
                                                      ),
                                                      padding: EdgeInsets.zero,
                                                      constraints: const BoxConstraints(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              height: AppSizes.width * 0.08,
                                              width: AppSizes.width * 0.08,
                                              decoration: BoxDecoration(
                                                color: MobikulTheme.clientPrimaryColor,
                                                borderRadius: BorderRadius.circular(4),
                                                border: Border.all(color: Colors.grey.shade400),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  // If parent provided handler, use it
                                                  if (widget.onAddToCart != null && widget.product != null) {
                                                    widget.onAddToCart!(widget.product!, quantity ?? 1);
                                                    return;
                                                  }

                                                  // Always allow adding to cart (or navigating to product for multi-variant items)
                                                  debugPrint("product!.productCount.toString --> ${widget.product?.productCount}");

                                                  if ((widget.product?.productCount ?? 1) > 1) {
                                                    AppDatabase.getDatabase().then((value) => value.recentProductDao.insertRecentProduct(
                                                          RecentProduct(
                                                            templateId: widget.product?.templateId.toString() ?? '',
                                                            name: widget.product?.name,
                                                            priceUnit: widget.product?.priceUnit,
                                                            priceReduce: widget.product?.priceReduce,
                                                            image: widget.product?.thumbNail ?? '',
                                                            productId: widget.product?.productId ?? -1,
                                                            productCount: widget.product?.productCount ?? -1,
                                                          ),
                                                        ).then((value) => RecentViewController.controller.sink.add(widget.product?.templateId?.toString() ?? '')));

                                                    Navigator.of(context).pushNamed(
                                                      productPage,
                                                      arguments: getProductDataMap(widget.product?.name ?? '', widget.product?.templateId.toString() ?? ''),
                                                    ).then((value) {
                                                      if (value == true) widget.postWishlistClick();
                                                    });
                                                  } else {
                                                    processAddToCartRequest(widget.product, context, quantity);
                                                  }
                                                },
                                                child: const Icon(
                                                  Icons.shopping_cart_outlined,
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
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: widget.product?.ribbon?.ribbonMessage?.isNotEmpty ?? false,
                            child: widget.product?.ribbon?.position == "left"
                                ? Positioned(
                                    left: 8,
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color: Color(int.parse((widget.product?.ribbon?.bgColor ?? "0x000000").replaceAll("#", "0xFF")),
                                        ),
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                      child: Text(
                                        widget.product?.ribbon?.ribbonMessage ?? "",
                                        style: TextStyle(
                                          color: Color(int.parse((widget.product?.ribbon?.textColor ?? "0xFFFFFF").replaceAll("#", "0xFF")),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Positioned(
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color: Color(int.parse((widget.product?.ribbon?.bgColor ?? "0x000000").replaceAll("#", "0xFF")),
                                        ),
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                      child: Text(
                                        widget.product?.ribbon?.ribbonMessage ?? "",
                                        style: TextStyle(
                                          color: Color(int.parse((widget.product?.ribbon?.textColor ?? "0xFFFFFF").replaceAll("#", "0xFF")),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                          Visibility(
                            visible: AppSharedPref().getSplashData()?.addons?.wishlist ?? false,
                            child: Positioned(
                              top: widget.product?.ribbon?.position == "left" || (widget.product?.ribbon?.ribbonMessage?.isEmpty ?? false)
                                  ? AppSizes.extraPadding * 1.5
                                  : (AppSizes.buttonRadius * 2) + AppSizes.linePadding,
                              right: AppSizes.width * 0.055,
                              child: Container(
                                height: 28,
                                width: 30,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      blurRadius: 2,
                                    ),
                                  ],
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: InkWell(
                                  child: Icon(
                                    addedInWishlist == true ? Icons.favorite : Icons.favorite_border_outlined,
                                    color: !addedInWishlist ? AppColors.lightGray : AppColors.red,
                                    size: 20,
                                  ),
                                  onTap: () {
                                    if (AppSharedPref().getIfLogin() != null && AppSharedPref().getIfLogin() == true) {
                                      processWishlistClick(addedInWishlist, context, widget.product, widget.postWishlistClick);
                                    } else {
                                      DialogHelper.confirmationDialog(
                                        "${AppLocalizations.of(context)?.translate(AppStringConstant.signInToContinue)}",
                                        context,
                                        AppLocalizations.of(context),
                                        onConfirm: () async {
                                          Navigator.pushNamed(context, loginSignup, arguments: false);
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: (widget.product?.productCount ?? 0) > 1 && (AppSharedPref().getCompareAvailability() ?? false),
                            child: Positioned(
                              top: widget.product?.ribbon?.position == "left" || (widget.product?.ribbon?.ribbonMessage?.isEmpty ?? false)
                                  ? AppSizes.buttonRadius * 2.3
                                  : AppSizes.buttonHeight * 2 + AppSizes.normalPadding,
                              right: AppSizes.width * 0.055,
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
                                    bool addedInCompare = AppSharedPref().getCompareData()?.contains(widget.product?.productId) ?? false;
                                    if (AppSharedPref().getIfLogin() != null && AppSharedPref().getIfLogin() == true) {
                                      if (!addedInCompare) {
                                        compareData.add(widget.product?.productId);
                                        AppSharedPref().setCompareData(compareData);
                                        AlertMessage.showSuccess(AppLocalizations.of(context)?.translate(AppStringConstant.addedItemsInCompare) ?? "", context);
                                      } else {
                                        AlertMessage.showError(AppLocalizations.of(context)?.translate(AppStringConstant.alreadyItemsInCompare) ?? "", context);
                                      }
                                    } else {
                                      DialogHelper.confirmationDialog(
                                        "${AppLocalizations.of(context)?.translate(AppStringConstant.signInToContinue)}",
                                        context,
                                        AppLocalizations.of(context),
                                        onConfirm: () async {
                                          Navigator.pushNamed(context, loginSignup, arguments: false);
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
                  }

                  void processAddToCartRequest(Products? product, BuildContext context, int? quantity) async {
                    // Prefer dispatching to CartScreenBloc when available so cart UI updates
                    // (CartMainView listens to the bloc and will refresh accordingly).
                    CartScreenBloc? cartBloc;
                    try {
                      cartBloc = context.read<CartScreenBloc>();
                    } catch (e) {
                      cartBloc = null;
                    }

                    if (cartBloc != null) {
                      cartBloc.add(AddToCartEvent(product?.productId ?? 0));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${product?.name ?? ""} added to cart')),
                      );
                      try {
                        final state = await cartBloc.stream.firstWhere((s) => s is AddToCartItemSuccess || s is CartScreenError);
                        if (state is AddToCartItemSuccess) {
                          AlertMessage.showSuccess(state.data.message ?? '', context);
                          // Refresh cart data
                          cartBloc.add(const CartScreenDataFetchEvent());
                        } else if (state is CartScreenError) {
                          AlertMessage.showError(state.message ?? '', context);
                        }
                      } catch (_) {
                        // ignore: avoid_print
                        print('Add to cart: no response from CartBloc');
                      }
                      return;
                    }

                    // Fallback: call repository directly if no CartScreenBloc is present.
                    ProductScreenRepositoryImp? repository = ProductScreenRepositoryImp();
                    try {
                      BaseModel model = await repository.addTocart(product!.productId!.toString(), quantity ?? 1);
                      if (model.success!) {
                        AlertMessage.showSuccess(model.message!, context);
                        AppSharedPref().setGuestCartCount(model.cartCount ?? 0);
                      } else {
                        AlertMessage.showError(model.message!, context);
                      }
                    } catch (error, _) {
                      debugPrint(error.toString());
                      AlertMessage.showError(error.toString(), context);
                    }
                  }

                  void processWishlistClick(bool isInWishlist, BuildContext context, Products? product, VoidCallback postWishlistClick) async {
                    ProductScreenRepositoryImp? repository = ProductScreenRepositoryImp();
                    List<int>? wishlistData = AppSharedPref().getWishlistData();
                    try {
                      BaseModel model = BaseModel();
                      final p = product!;
                      if (!isInWishlist) {
                        model = await repository.addToWishlist(p.productId!.toString(), p.name ?? '');
                        if (model.success!) {
                          AlertMessage.showSuccess(model.message!, context);
                          wishlistData!.add(p.productId!);
                          AppSharedPref().setWishlistData(wishlistData);
                        } else {
                          AlertMessage.showError(model.message!, context);
                        }
                      } else {
                        model = await repository.removeFromWishlist(p.productId.toString());
                        if (model.success!) {
                          AlertMessage.showSuccess(model.message!, context);
                          wishlistData!.remove(p.productId);
                          AppSharedPref().setWishlistData(wishlistData);
                        } else {
                          AlertMessage.showError(model.message!, context);
                        }
                      }

                      final HiveService hiveService = HiveService();
                      String productDataBoxName = HiveConstants.getProductDataBoxName(p.templateId.toString());
                      ProductScreenRepositoryImp().callProductDataApiAndUpdateHiveDB(hiveService, productDataBoxName, p.templateId.toString());

                      Future.delayed(const Duration(milliseconds: 10)).then((value) {
                        ProductScreenRepositoryImp().callProductDataApiAndUpdateHiveDB(hiveService, productDataBoxName, product.templateId!.toString());
                      });

                      if (mounted) setState(() {});
                    } catch (error, _) {
                      debugPrint(error.toString());
                      AlertMessage.showError(error.toString(), context);
                    }
                  }
                }
