
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

class _ItemCardState extends State<ItemCard>
    with SingleTickerProviderStateMixin {
  int? quantity;
  late AnimationController _pressController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    quantity = widget.quantity ?? 1;
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.97,
      upperBound: 1.0,
      value: 1.0,
    );
    _scaleAnim = _pressController;
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool addedInWishlist =
        AppSharedPref().getWishlistData()?.contains(
          widget.product?.productId,
        ) ??
        false;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final bool hasDiscount = (widget.product?.priceReduce ?? '').isNotEmpty;
    final bool hasRibbon =
        widget.product?.ribbon?.ribbonMessage?.isNotEmpty ?? false;

    return ScaleTransition(
      scale: _scaleAnim,
      child: GestureDetector(
        onTapDown: (_) => _pressController.reverse(),
        onTapUp: (_) => _pressController.forward(),
        onTapCancel: () => _pressController.forward(),
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
                  (value) => RecentViewController.controller.sink.add(
                    widget.product?.templateId?.toString() ?? '',
                  ),
                ),
          );

          Navigator.of(context)
              .pushNamed(
                productPage,
                arguments: getProductDataMap(
                  widget.product?.name ?? '',
                  widget.product?.templateId.toString() ?? '',
                )..[productDataKey] = widget.product,
              )
              .then((value) {
                if (value == true) widget.postWishlistClick();
              });
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(4, 6, 4, 6),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E2128) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.35 : 0.07),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── Product image ──────────────────────────────────────
                  Stack(
                    children: [
                      Container(
                        color: isDark
                            ? const Color(0xFF262A34)
                            : const Color(0xFFF4F5F7),
                        // Use a fixed aspect-ratio so the image never eats
                        // into the info section on narrow grid cells.
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: ImageView(
                            fit: BoxFit.cover,
                            url: widget.product?.thumbNail,
                            width:
                                widget.imageSize ?? (AppSizes.width / 2.3) + 8,
                            height:
                                (widget.imageSize ?? (AppSizes.width / 2.3)) -
                                8,
                          ),
                        ),
                      ),
                      // Discount badge
                      if (hasDiscount)
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.shade700,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'SALE',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  // ── Info section ───────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product?.name ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                height: 1.35,
                                color: isDark
                                    ? Colors.white
                                    : const Color(0xFF111827),
                              ),
                        ),
                        const SizedBox(height: 6),
                        // Price row
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              hasDiscount
                                  ? widget.product?.priceReduce ?? ''
                                  : widget.product?.priceUnit ?? '',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: colorScheme.primary,
                                    fontSize: 15,
                                  ),
                            ),
                            if (hasDiscount) ...[
                              const SizedBox(width: 6),
                              Text(
                                widget.product?.priceUnit ?? '',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      color: isDark
                                          ? Colors.white38
                                          : Colors.black38,
                                    ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 10),

                        // ── Qty stepper + cart button ──────────────────
                        Row(
                          children: [
                            // Stepper
                            Expanded(
                              child: _QtyStepper(
                                quantity: quantity ?? 1,
                                isDark: isDark,
                                onDecrement: () {
                                  if ((quantity ?? 1) > 1) {
                                    setState(
                                      () => quantity = (quantity ?? 1) - 1,
                                    );
                                  }
                                },
                                onIncrement: () {
                                  setState(
                                    () => quantity = (quantity ?? 1) + 1,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Cart button
                            _CartButton(
                              onTap: () {
                                if (widget.onAddToCart != null &&
                                    widget.product != null) {
                                  widget.onAddToCart!(
                                    widget.product!,
                                    quantity ?? 1,
                                  );
                                  return;
                                }

                                debugPrint(
                                  "product!.productCount.toString --> ${widget.product?.productCount}",
                                );

                                if ((widget.product?.productCount ?? 1) > 1) {
                                  AppDatabase.getDatabase().then(
                                    (value) => value.recentProductDao
                                        .insertRecentProduct(
                                          RecentProduct(
                                            templateId:
                                                widget.product?.templateId
                                                    .toString() ??
                                                '',
                                            name: widget.product?.name,
                                            priceUnit:
                                                widget.product?.priceUnit,
                                            priceReduce:
                                                widget.product?.priceReduce,
                                            image:
                                                widget.product?.thumbNail ?? '',
                                            productId:
                                                widget.product?.productId ?? -1,
                                            productCount:
                                                widget.product?.productCount ??
                                                -1,
                                          ),
                                        )
                                        .then(
                                          (value) => RecentViewController
                                              .controller
                                              .sink
                                              .add(
                                                widget.product?.templateId
                                                        ?.toString() ??
                                                    '',
                                              ),
                                        ),
                                  );

                                  Navigator.of(context)
                                      .pushNamed(
                                        productPage,
                                        arguments: getProductDataMap(
                                          widget.product?.name ?? '',
                                          widget.product?.templateId
                                                  .toString() ??
                                              '',
                                        ),
                                      )
                                      .then((value) {
                                        if (value == true)
                                          widget.postWishlistClick();
                                      });
                                } else {
                                  processAddToCartRequest(
                                    widget.product,
                                    context,
                                    quantity,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // ── Ribbon badge ────────────────────────────────────────────
              if (hasRibbon)
                Positioned(
                  top: 0,
                  left: widget.product?.ribbon?.position == "left" ? 0 : null,
                  right: widget.product?.ribbon?.position != "left" ? 0 : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Color(
                        int.parse(
                          (widget.product?.ribbon?.bgColor ?? "0x000000")
                              .replaceAll("#", "0xFF"),
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: widget.product?.ribbon?.position == "left"
                            ? Radius.zero
                            : const Radius.circular(4),
                        topRight: widget.product?.ribbon?.position == "left"
                            ? const Radius.circular(4)
                            : Radius.zero,
                        bottomLeft: const Radius.circular(4),
                        bottomRight: const Radius.circular(4),
                      ),
                    ),
                    child: Text(
                      widget.product?.ribbon?.ribbonMessage ?? "",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(
                          int.parse(
                            (widget.product?.ribbon?.textColor ?? "0xFFFFFF")
                                .replaceAll("#", "0xFF"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              // ── Wishlist heart ──────────────────────────────────────────
              if (AppSharedPref().getSplashData()?.addons?.wishlist ?? false)
                Positioned(
                  top: hasRibbon ? 42 : 8,
                  right: 8,
                  child: _CircleActionBtn(
                    icon: addedInWishlist
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    iconColor: addedInWishlist ? Colors.redAccent : Colors.grey,
                    onTap: () {
                      if (AppSharedPref().getIfLogin() != null &&
                          AppSharedPref().getIfLogin() == true) {
                        processWishlistClick(
                          addedInWishlist,
                          context,
                          widget.product,
                          widget.postWishlistClick,
                        );
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

              // ── Compare ────────────────────────────────────────────────
              if ((widget.product?.productCount ?? 0) > 1 &&
                  (AppSharedPref().getCompareAvailability() ?? false))
                Positioned(
                  top: hasRibbon
                      ? 78
                      : (AppSharedPref().getSplashData()?.addons?.wishlist ??
                            false)
                      ? 42
                      : 8,
                  right: 8,
                  child: _CircleActionBtn(
                    icon: Icons.compare_arrows_rounded,
                    iconColor: Colors.grey,
                    onTap: () async {
                      List? compareData =
                          AppSharedPref().getCompareData() ?? [];
                      bool addedInCompare =
                          AppSharedPref().getCompareData()?.contains(
                            widget.product?.productId,
                          ) ??
                          false;
                      if (AppSharedPref().getIfLogin() != null &&
                          AppSharedPref().getIfLogin() == true) {
                        if (!addedInCompare) {
                          compareData.add(widget.product?.productId);
                          AppSharedPref().setCompareData(compareData);
                          AlertMessage.showSuccess(
                            AppLocalizations.of(context)?.translate(
                                  AppStringConstant.addedItemsInCompare,
                                ) ??
                                "",
                            context,
                          );
                        } else {
                          AlertMessage.showError(
                            AppLocalizations.of(context)?.translate(
                                  AppStringConstant.alreadyItemsInCompare,
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
            ],
          ),
        ),
      ),
    );
  }

  void processAddToCartRequest(
    Products? product,
    BuildContext context,
    int? quantity,
  ) async {
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
        final state = await cartBloc.stream.firstWhere(
          (s) => s is AddToCartItemSuccess || s is CartScreenError,
        );
        if (state is AddToCartItemSuccess) {
          AlertMessage.showSuccess(state.data.message ?? '', context);
          cartBloc.add(const CartScreenDataFetchEvent());
        } else if (state is CartScreenError) {
          AlertMessage.showError(state.message ?? '', context);
        }
      } catch (_) {
        print('Add to cart: no response from CartBloc');
      }
      return;
    }

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
    } catch (error, _) {
      debugPrint(error.toString());
      AlertMessage.showError(error.toString(), context);
    }
  }

  void processWishlistClick(
    bool isInWishlist,
    BuildContext context,
    Products? product,
    VoidCallback postWishlistClick,
  ) async {
    ProductScreenRepositoryImp? repository = ProductScreenRepositoryImp();
    List<int>? wishlistData = AppSharedPref().getWishlistData();
    try {
      BaseModel model = BaseModel();
      final p = product!;
      if (!isInWishlist) {
        model = await repository.addToWishlist(
          p.productId!.toString(),
          p.name ?? '',
        );
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
      String productDataBoxName = HiveConstants.getProductDataBoxName(
        p.templateId.toString(),
      );
      ProductScreenRepositoryImp().callProductDataApiAndUpdateHiveDB(
        hiveService,
        productDataBoxName,
        p.templateId.toString(),
      );

      Future.delayed(const Duration(milliseconds: 10)).then((value) {
        ProductScreenRepositoryImp().callProductDataApiAndUpdateHiveDB(
          hiveService,
          productDataBoxName,
          product.templateId!.toString(),
        );
      });

      if (mounted) setState(() {});
    } catch (error, _) {
      debugPrint(error.toString());
      AlertMessage.showError(error.toString(), context);
    }
  }
}

// ─── Micro widgets ────────────────────────────────────────────────────────────

class _QtyStepper extends StatelessWidget {
  final int quantity;
  final bool isDark;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const _QtyStepper({
    required this.quantity,
    required this.isDark,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    final border = isDark ? Colors.white24 : Colors.black12;
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.07)
            : const Color(0xFFF4F5F7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: border, width: 1),
      ),
      child: Row(
        children: [
          _StepBtn(icon: Icons.remove, onPressed: onDecrement, isDark: isDark),
          Expanded(
            child: Center(
              child: Text(
                quantity.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          _StepBtn(icon: Icons.add, onPressed: onIncrement, isDark: isDark),
        ],
      ),
    );
  }
}

class _StepBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isDark;
  const _StepBtn({
    required this.icon,
    required this.onPressed,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 32,
        height: 36,
        child: Icon(
          icon,
          size: 15,
          color: isDark ? Colors.white70 : Colors.black87,
        ),
      ),
    );
  }
}

class _CartButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CartButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withOpacity(0.40),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Icon(
          Icons.shopping_cart_outlined,
          size: 18,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _CircleActionBtn extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;
  const _CircleActionBtn({
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 16, color: iconColor),
      ),
    );
  }
}
