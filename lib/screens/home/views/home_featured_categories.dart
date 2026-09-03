/**
 * Webkul Software.
 * @package Mobikul App
 * @Category Mobikul
 * @author Webkul <support@webkul.com>
 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 * @license https://store.webkul.com/license.html ASL Licence
 */

import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';

// ── Brand tokens ──────────────────────────────────────────────────────────────
class _T {
  static const Color emerald = Color(0xFF1A3C2B);
  static const Color leafGreen = Color(0xFF4CAF78);
  static const Color textPrimary = Color(0xFF1E1E1E);

  // Per-index pastel fills for grid card background fallback
  static const List<Color> bubbleFills = [
    Color(0xFFE8F5E9),
    Color(0xFFFFF3E0),
    Color(0xFFE3F2FD),
    Color(0xFFF3E5F5),
    Color(0xFFFCE4EC),
    Color(0xFFE0F7FA),
  ];
}

// ─────────────────────────────────────────────────────────────────────────────
// HomeFeaturedCategories
// ─────────────────────────────────────────────────────────────────────────────
class HomeFeaturedCategories extends StatefulWidget {
  const HomeFeaturedCategories(
    this.categories,
    this.featuredCategoryViewType,
    this.fetchSubCategories, {
    Key? key,
  }) : super(key: key);

  final HomepageDataList? categories;
  final List<Categories>? fetchSubCategories;
  final String? featuredCategoryViewType;

  @override
  _HomeFeaturedCategoriesState createState() => _HomeFeaturedCategoriesState();
}

class _HomeFeaturedCategoriesState extends State<HomeFeaturedCategories> {
  // Custom seasonal background images for category grid cards (PLACEHOLDER)
  final _customGridImages = const [
    'assets/images/autumn_image.jpeg',
    'assets/images/spring_images.png',
    'assets/images/summer_image1.jpeg',
    'assets/images/winter_carrot.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    final int itemCount = (widget.categories?.data?.length ?? 0).clamp(0, 6);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section header ────────────────────────────────────────────
        _SectionHeader(
          title: widget.categories?.name ?? 'SHOP BY CATEGORY',
          onSeeAll: () {
            final Data? firstCat = widget.categories?.data?.first;
            Navigator.pushNamed(
              context,
              catalogPage,
              arguments: getCatalogMap(
                '',
                false,
                firstCat?.categoryName ?? widget.categories?.name ?? '',
                customerId: firstCat?.categoryId ?? 0,
              ),
            );
          },
        ),

        const SizedBox(height: 12),

        // ── 2-column category grid ────────────────────────────────────
        if (itemCount > 0) _buildCategoryGrid(context, itemCount),

        const SizedBox(height: 8),

        // ── "Shop Vegetables" section sub-row ─────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: _T.leafGreen,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Shop Vegetables',
                    style: TextStyle(
                      color: _T.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ),
              _SeeAllChip(
                onTap: () {
                  final Data? vegetableCategory = widget.categories?.data
                      ?.firstWhereOrNull(
                        (item) => (item.categoryName ?? '')
                            .toLowerCase()
                            .contains('vegetable'),
                      );
                  Navigator.pushNamed(
                    context,
                    catalogPage,
                    arguments: getCatalogMap(
                      '',
                      false,
                      vegetableCategory?.categoryName ?? 'Shop Vegetables',
                      customerId: vegetableCategory?.categoryId ?? 0,
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  /// 2-column grid (reference image style)
  Widget _buildCategoryGrid(BuildContext context, int itemCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.25,
        ),
        itemBuilder: (context, index) {
          final category = widget.categories?.data?[index];
          final bgImage = index < _customGridImages.length
              ? _customGridImages[index]
              : null;
          return _CategoryGridCard(
            category: category,
            index: index,
            backgroundImage: bgImage,
            fetchSubCategories: widget.fetchSubCategories,
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section header with optional "See all" link — reference image style
// ─────────────────────────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;
  const _SectionHeader({required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: accent bar + ALL-CAPS bold title
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 4,
                height: 22,
                decoration: BoxDecoration(
                  color: _T.emerald,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  color: _T.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),

          // Right: "See all" link
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: Text(
                'See all',
                style: TextStyle(
                  color: _T.emerald,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: _T.emerald,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// "See all →" outlined chip
// ─────────────────────────────────────────────────────────────────────────────
class _SeeAllChip extends StatelessWidget {
  final VoidCallback onTap;
  const _SeeAllChip({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: _T.emerald, width: 1.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'See all',
              style: TextStyle(
                color: _T.emerald,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.arrow_forward, size: 13, color: _T.emerald),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared category navigation helper
// ─────────────────────────────────────────────────────────────────────────────
void _navigateToCatalog(
  BuildContext context,
  Data? category,
  List<Categories>? fetchSubCategories,
) {
  Navigator.pushNamed(
    context,
    subCategory,
    arguments: subCategoryDataMap(
      fetchSubCategories
          ?.firstWhereOrNull((e) => category?.categoryId == e.categoryId)
          ?.children,
      category?.categoryId,
      category?.categoryName.toString() ?? '',
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Large grid category card — full-bleed background image + dark gradient scrim
// + label at bottom. Matches reference image style exactly.
// ─────────────────────────────────────────────────────────────────────────────
class _CategoryGridCard extends StatelessWidget {
  final Data? category;
  final int index;
  final String? backgroundImage; // local asset override (PLACEHOLDER)
  final List<Categories>? fetchSubCategories;

  const _CategoryGridCard({
    required this.category,
    required this.index,
    required this.fetchSubCategories,
    this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    final String remoteUrl = category?.url ?? '';
    final bool hasRemote = remoteUrl.isNotEmpty;

    return GestureDetector(
      onTap: () => _navigateToCatalog(context, category, fetchSubCategories),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Background image ──────────────────────────────────────
            if (backgroundImage != null)
              Image.asset(backgroundImage!, fit: BoxFit.cover)
            else if (hasRemote)
              CachedNetworkImage(
                imageUrl: remoteUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                    Container(color: const Color(0xFFDCEDC8)),
                errorWidget: (_, __, ___) =>
                    Container(color: const Color(0xFFDCEDC8)),
              )
            else
              Container(color: _T.bubbleFills[index % _T.bubbleFills.length]),

            // ── Dark gradient overlay for readability ─────────────────
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                ),
              ),
            ),

            // ── Category label at bottom ──────────────────────────────
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Text(
                category?.categoryName ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                  shadows: [Shadow(blurRadius: 4, color: Colors.black54)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
