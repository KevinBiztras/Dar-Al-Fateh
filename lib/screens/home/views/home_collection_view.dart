/**
 * Webkul Software.
 * @package Mobikul App
 * @Category Mobikul
 * @author Webkul <support@webkul.com>
 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 * @license https://store.webkul.com/license.html ASL Licence
 */

import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';

// ── Shared brand tokens ───────────────────────────────────────────────────────
class _C {
  static const Color emerald = Color(0xFF1A3C2B);
  static const Color leafGreen = Color(0xFF4CAF78);
  static const Color saffron = Color(0xFFF9A825);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color bgPage = Color(0xFFF7F9F7);
  static const Color textPrimary = Color(0xFF1E1E1E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textPrice = Color(0xFF1A3C2B);
  static const Color cardBorder = Color(0xFF4CAF78);
}

// ─────────────────────────────────────────────────────────────────────────────
// HomeCollection
// ─────────────────────────────────────────────────────────────────────────────
class HomeCollection extends StatefulWidget {
  final List<Data>? products;
  final VoidCallback postWishlistClick;

  const HomeCollection({
    Key? key,
    this.products,
    required this.postWishlistClick,
  }) : super(key: key);

  @override
  State<HomeCollection> createState() => HomeCollectionState();
}

class HomeCollectionState extends State<HomeCollection> {
  AppLocalizations? _localizations;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = AppLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.products?.length ?? 0,
      itemBuilder: (context, index) => _ProductSliderSection(
        sliderData: widget.products![index],
        localizations: _localizations,
        postWishlistClick: widget.postWishlistClick,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// One slider section: header row + 2-column product grid (reference style)
// ─────────────────────────────────────────────────────────────────────────────
class _ProductSliderSection extends StatelessWidget {
  final Data sliderData;
  final AppLocalizations? localizations;
  final VoidCallback postWishlistClick;

  const _ProductSliderSection({
    required this.sliderData,
    required this.localizations,
    required this.postWishlistClick,
  });

  bool _showViewAll(String sliderMode, int length) {
    if (sliderMode == AppConstant.productFixed) return length.isEven;
    if (sliderMode == AppConstant.productDefault) return length > 10;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final String sliderMode = sliderData.sliderMode ?? '';
    final List<Products> products = sliderData.products ?? [];
    final bool showViewAll = _showViewAll(sliderMode, products.length);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section header ────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left: accent + title (ALL-CAPS like reference)
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 22,
                    decoration: BoxDecoration(
                      color: _C.emerald,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    (sliderData.title ?? 'Best Sellers').toUpperCase(),
                    style: const TextStyle(
                      color: _C.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),

              // Right: "See all" link
              if (showViewAll)
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    catalogPage,
                    arguments: getCatalogMap(
                      sliderData.url ?? '',
                      true,
                      'Catalog',
                      customerId: 0,
                    ),
                  ),
                  child: Text(
                    localizations?.translate(AppStringConstant.viewAll) ??
                        'See all',
                    style: const TextStyle(
                      color: _C.emerald,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: _C.emerald,
                    ),
                  ),
                ),
            ],
          ),
        ),

        // ── 2-column product grid (reference image style) ─────────────
        _ProductGridLayout(
          products: products,
          sliderMode: sliderMode,
          url: sliderData.url,
          localizations: localizations,
          postWishlistClick: postWishlistClick,
        ),

        const SizedBox(height: 8),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Product list type router
// ─────────────────────────────────────────────────────────────────────────────
class _ProductGridLayout extends StatelessWidget {
  final List<Products> products;
  final String sliderMode;
  final String? url;
  final AppLocalizations? localizations;
  final VoidCallback postWishlistClick;

  const _ProductGridLayout({
    required this.products,
    required this.sliderMode,
    required this.url,
    required this.localizations,
    required this.postWishlistClick,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    // Always use 2-column grid for reference image style
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) =>
            _ReferenceProductCard(product: products[index], index: index),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Individual product card — matches reference image exactly:
// White card, green border, image top, name + price in middle, green "Add to
// Cart" button at bottom.
// ─────────────────────────────────────────────────────────────────────────────
class _ReferenceProductCard extends StatelessWidget {
  final Products product;
  final int index;

  const _ReferenceProductCard({required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    final String thumb = product.thumbNail ?? '';
    final bool isAsset = thumb.startsWith('assets/');

    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        productPage,
        arguments: getProductDataMap(
          product.name ?? '',
          (product.templateId ?? product.productId ?? '').toString(),
        )..[productDataKey] = product,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: _C.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _C.cardBorder, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Product image ─────────────────────────────────────────
            Expanded(
              flex: 5,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Container(
                  color: const Color(0xFFF5F5F5),
                  padding: const EdgeInsets.all(12),
                  child: isAsset
                      ? Image.asset(thumb, fit: BoxFit.contain)
                      : Image.network(
                          thumb,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => Image.asset(
                            'assets/images/cabbage.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                ),
              ),
            ),

            // ── Product info ──────────────────────────────────────────
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Product name
                    Text(
                      product.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _C.textPrimary,
                        height: 1.3,
                      ),
                    ),

                    // Price
                    Text(
                      product.priceUnit ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: _C.textPrice,
                      ),
                    ),

                    // "Add to Cart" button — green filled, matches reference
                    SizedBox(
                      height: 32,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pushNamed(
                          productPage,
                          arguments: getProductDataMap(
                            product.name ?? '',
                            (product.templateId ?? product.productId ?? '')
                                .toString(),
                          )..[productDataKey] = product,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _C.emerald,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Backward-compatibility helpers (used by product_list_widgets & HomeScreen)
// ─────────────────────────────────────────────────────────────────────────────
Widget viewAllButton(BuildContext context, GestureTapCallback onClick) {
  return GestureDetector(
    onTap: onClick,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: _C.emerald, width: 1.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(
                  context,
                )?.translate(AppStringConstant.viewAll) ??
                'View all',
            style: const TextStyle(
              color: _C.emerald,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_forward, size: 13, color: _C.emerald),
        ],
      ),
    ),
  );
}
