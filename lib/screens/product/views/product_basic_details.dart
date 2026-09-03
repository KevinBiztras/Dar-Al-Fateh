

/*
 * Webkul Software.
 * @package Mobikul App
 * @Category Mobikul
 * @author Webkul <support@webkul.com>
 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 * @license https://store.webkul.com/license.html ASL Licence
 * @link https://store.webkul.com/license.html
 */

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/firebase_analytics.dart';
import 'package:flutter_project_structure/helper/open_bottom_model_sheet.dart';
import 'package:flutter_project_structure/models/ProductScreenModel.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_bloc.dart';
import 'package:flutter_project_structure/screens/product/views/rating_container.dart';
import 'package:share_plus/share_plus.dart';
import '../../../constants/arguments_map.dart';
import '../../../constants/route_constant.dart';
import '../../../helper/alert_message.dart';
import '../../../helper/app_shared_pref.dart';
import '../bloc/product_screen_event.dart';
import '../bloc/product_screen_state.dart';

class ProductPageBasicDetailsView extends StatefulWidget {
  final ProductScreenModel? product;
  final ValueChanged<bool>? callback;
  bool addedToWishlist = false;
  ProductScreenBloc? productPageBloc;

  ProductPageBasicDetailsView(
    this.addedToWishlist,
    this.productPageBloc, {
    Key? key,
    this.product,
    this.callback,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductPageBasicDetailsViewState();
  }
}

class ProductPageBasicDetailsViewState
    extends State<ProductPageBasicDetailsView> {
  AppLocalizations? _localizations;

  bool _isInGuestWishlist() {
    final int? templateId =
        widget.product?.templateId ?? widget.product?.productId;
    if (templateId == null) return false;
    return AppSharedPref().getGuestWishlistItems().any(
      (item) =>
          (int.tryParse(item["templateId"].toString()) ?? 0) == templateId,
    );
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
  }

  bool get _isWishlisted =>
      widget.addedToWishlist ||
      widget.product?.addedToWishlist == true ||
      _isInGuestWishlist();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasDiscount = (widget.product?.priceReduce ?? '').isNotEmpty;

    return Container(
      color: theme.cardColor,
      padding: EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stock badge
          if ((widget.product?.stockDisplayMsg ?? '').isNotEmpty) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.green.withOpacity(0.4)),
              ),
              child: Text(
                widget.product?.stockDisplayMsg ?? '',
                style: TextStyle(
                  color: Colors.green[700],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 12),
          ],

          // Product name
          Text(
            widget.product?.name ?? '',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),
          SizedBox(height: 12),

          // Price row
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                hasDiscount
                    ? widget.product?.priceReduce ?? ''
                    : widget.product?.priceUnit ?? '',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              if (hasDiscount) ...[
                SizedBox(width: 10),
                Text(
                  widget.product?.priceUnit ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.grey,
                  ),
                ),
                SizedBox(width: 10),
                // Discount badge
                _buildDiscountBadge(),
              ],
            ],
          ),
          SizedBox(height: 14),

          // Reviews row
          if (AppSharedPref().getSplashData()?.addons?.review ?? false)
            _buildReviewRow(),

          SizedBox(height: 16),

          // Divider
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.withOpacity(0.15),
          ),
          SizedBox(height: 4),

          // Action buttons (Wishlist / Compare / Share)
          _buildActionRow(theme),
          SizedBox(height: 4),

          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.withOpacity(0.15),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscountBadge() {
    // Try to compute discount %
    try {
      final original = double.parse(
        widget.product?.priceUnit?.replaceAll(RegExp(r'[^0-9.]'), '') ?? '',
      );
      final discounted = double.parse(
        widget.product?.priceReduce?.replaceAll(RegExp(r'[^0-9.]'), '') ?? '',
      );
      if (original > 0) {
        final pct = ((original - discounted) / original * 100).round();
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.red[50],
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.red.withOpacity(0.3)),
          ),
          child: Text(
            '$pct% OFF',
            style: TextStyle(
              color: Colors.red[700],
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      }
    } catch (_) {}
    return SizedBox.shrink();
  }

  Widget _buildReviewRow() {
    final hasReviews = (widget.product?.totalReview ?? 0) > 0;
    return Row(
      children: [
        if (hasReviews)
          productReviews(
            widget.product?.totalReview ?? 0,
            widget.product?.avgRating ?? 0,
          )
        else
          Text(
            _localizations?.translate(AppStringConstant.noReview) ?? '',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
        SizedBox(width: 12),
        InkWell(
          onTap: () {
            if (AppSharedPref().getIfLogin() == true) {
              reviewBottomModalSheet(
                context,
                widget.product?.name ?? '',
                widget.product?.thumbNail ?? '',
                widget.product?.templateId ?? 0,
                function: () {
                  widget.productPageBloc?.emit(ProductScreenInitial());
                  widget.productPageBloc?.add(
                    ProductScreenDataFetchEvent(
                      widget.product?.templateId.toString(),
                    ),
                  );
                },
              );
            } else {
              DialogHelper.confirmationDialog(
                "${_localizations?.translate(AppStringConstant.signInToContinue)}",
                context,
                _localizations,
                onConfirm: () async {
                  Navigator.pushNamed(context, loginSignup, arguments: false);
                },
              );
            }
          },
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Text(
              _localizations?.translate(AppStringConstant.addReview) ?? '',
              style: TextStyle(
                color: AppColors.blue,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget productReviews(int totalReview, double avgReview) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(
              reviewList,
              arguments: getReviewDataMap(
                widget.product?.name ?? "",
                widget.product?.thumbNail ?? "",
                widget.product?.templateId ?? 0,
              ),
            )
            .then((value) {
              widget.productPageBloc?.emit(ProductScreenInitial());
              widget.productPageBloc?.add(
                ProductScreenDataFetchEvent(
                  widget.product?.templateId.toString(),
                ),
              );
            });
      },
      borderRadius: BorderRadius.circular(6),
      child: Row(
        children: [
          RatingContainer(widget.product?.avgRating?.toDouble() ?? 0.0),
          SizedBox(width: 6),
          Text(
            "($totalReview)",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionRow(ThemeData theme) {
    final showCompare =
        (widget.product?.productCount ?? 0) > 1 &&
        (AppSharedPref().getCompareAvailability() ?? false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Wishlist
        _ActionChip(
          icon: _isWishlisted ? Icons.favorite : Icons.favorite_border,
          iconColor: _isWishlisted ? Colors.red : Colors.grey[600]!,
          label:
              _localizations?.translate(AppStringConstant.wishList) ??
              'Wishlist',
          onTap: () {
            final bool isLoggedIn = AppSharedPref().getIfLogin() == true;
            if (!isLoggedIn) AppSharedPref().setGuestCheckout(true);
            final String productId =
                (widget.product?.templateId ?? widget.product?.productId ?? 0)
                    .toString();
            if (!_isWishlisted) {
              widget.productPageBloc?.add(
                AddToWishlistEvent(productId, widget.product?.name ?? ""),
              );
            } else {
              widget.productPageBloc?.add(RemoveFromWishlistEvent(productId));
            }
            setState(() {
              widget.addedToWishlist = !_isWishlisted;
              if (widget.product != null) {
                widget.product!.addedToWishlist = !_isWishlisted;
              }
            });
            widget.productPageBloc?.emit(ProductScreenInitial());
          },
        ),

        // Vertical divider
        Container(height: 28, width: 1, color: Colors.grey.withOpacity(0.2)),

        // Compare (conditional)
        if (showCompare) ...[
          _ActionChip(
            icon: Icons.compare_arrows,
            iconColor: Colors.grey[600]!,
            label:
                _localizations?.translate(AppStringConstant.compare) ??
                'Compare',
            onTap: () async {
              List? compareData = AppSharedPref().getCompareData() ?? [];
              bool addedInCompare =
                  AppSharedPref().getCompareData()?.contains(
                    widget.product?.productId,
                  ) ??
                  false;
              if (AppSharedPref().getIfLogin() == true) {
                if (!addedInCompare) {
                  compareData.add(widget.product?.productId);
                  AppSharedPref().setCompareData(compareData);
                  AlertMessage.showSuccess(
                    _localizations?.translate(
                          AppStringConstant.addedItemsInCompare,
                        ) ??
                        "",
                    context,
                  );
                } else {
                  AlertMessage.showError(
                    _localizations?.translate(
                          AppStringConstant.alreadyItemsInCompare,
                        ) ??
                        "",
                    context,
                  );
                }
              } else {
                DialogHelper.confirmationDialog(
                  "${_localizations?.translate(AppStringConstant.signInToContinue)}",
                  context,
                  _localizations,
                  onConfirm: () async {
                    Navigator.pushNamed(context, loginSignup, arguments: false);
                  },
                );
              }
            },
          ),
          Container(height: 28, width: 1, color: Colors.grey.withOpacity(0.2)),
        ],

        // Share
        _ActionChip(
          icon: Icons.share_outlined,
          iconColor: Colors.grey[600]!,
          label: _localizations?.translate(AppStringConstant.share) ?? 'Share',
          onTap: () async {
            await Share.share(
              widget.product?.absoluteUrl ?? "",
              subject: widget.product?.absoluteUrl ?? '',
            );
          },
        ),
      ],
    );
  }
}

// ── Small reusable action chip widget ──────────────────────────────────────
class _ActionChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback onTap;

  const _ActionChip({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 20),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
