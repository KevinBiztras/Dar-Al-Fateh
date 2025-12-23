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
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';

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
  AppLocalizations? _localizations;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = AppLocalizations.of(context);
  }

  final _customCircleImages = const [
    'assets/images/winter_carrot.jpeg',
    'assets/images/spring_images.png',
    'assets/images/summer_image1.jpeg',
    'assets/images/autumn_image.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.imageRadius,
            vertical: AppSizes.genericPadding,
          ),
          child: Text(
            widget.categories?.name ?? "",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(
            // AppSizes.imageRadius,
            // 0.0,
            // AppSizes.imageRadius,
            // 0.0,
            20,
            0,
            0,
            0,
          ),
          height: AppSizes.width / 4,
          width: AppSizes.width.toDouble(),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // itemCount: widget.categories?.data?.length,
            itemCount: 4,
            itemBuilder: (context, index) {
              final category = widget.categories?.data?[index];
              return widget.featuredCategoryViewType ==
                      AppConstant.featuredCategorySquareType
                  ? categoryCardSquare(widget.categories?.data?[index])
                  : widget.featuredCategoryViewType ==
                        AppConstant.featuredCategoryRoundedSquareType
                  ? categoryCardRoundedSquare(widget.categories?.data?[index])
                  : categoryCardCircle(category, index);
            },
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.imageRadius,
                vertical: AppSizes.genericPadding,
              ),
              child: Text(
                "Shop Vegetables",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            SizedBox(
              width: 110,
              child: ElevatedButton(
                onPressed: () {
                  final Data? vegetableCategory = widget.categories?.data
                      ?.firstWhereOrNull(
                        (item) => (item.categoryName ?? "")
                            .toLowerCase()
                            .contains("vegetable"),
                      );
                  Navigator.pushNamed(
                    context,
                    catalogPage,
                    arguments: getCatalogMap(
                      "",
                      false,
                      vegetableCategory?.categoryName ?? "Shop Vegetables",
                      customerId: vegetableCategory?.categoryId ?? 0,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 2,
                  ), // Adjust padding for better feel
                  shape: RoundedRectangleBorder(
                    // Rounded corners for a modern look
                    borderRadius: BorderRadius.circular(
                      30,
                    ), // You can adjust this for more or less rounded corners
                  ),
                  elevation: 5, // Slight shadow for depth
                  backgroundColor: Colors
                      .transparent, // Remove the solid background color to apply gradient
                  side: BorderSide(
                    color: Colors.transparent,
                  ), // Remove border if you want a cleaner look
                  shadowColor: Colors.black.withOpacity(
                    0.0,
                  ), // Soft shadow color
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      // Apply gradient
                      colors: [
                        Colors.lightBlue,
                        Colors.lightGreen,
                      ], // Gradient color range
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(
                      30,
                    ), // Match the button's border radius
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'View all',
                      style: TextStyle(
                        fontSize: 16, // Larger font size for better readability
                        fontWeight: FontWeight.bold, // Bold text for emphasis
                        color: Colors
                            .white, // Text color that stands out against the gradient
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget categoryCardCircle(Data? category, int index) {
    final ImageProvider imageProvider = index < _customCircleImages.length
        ? AssetImage(_customCircleImages[index])
        : CachedNetworkImageProvider(category?.url ?? "");

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        1.0,
        0.0,
        AppSizes.genericPadding,
        AppSizes.linePadding,
      ),
      child: Column(
        children: [
          GestureDetector(
            child: Container(
              width: AppSizes.width / 5.5,
              height: AppSizes.width / 5.5,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFCADBF1)),
                borderRadius: BorderRadius.all(
                  Radius.circular((AppSizes.width / 5) / 2),
                ),
                color: const Color(0xFFEFF6FF),
                image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                subCategory,
                arguments: subCategoryDataMap(
                  widget.fetchSubCategories
                      ?.firstWhereOrNull(
                        (e) => category?.categoryId == e.categoryId,
                      )
                      ?.children,
                  category?.categoryId,
                  category?.categoryName.toString() ?? "",
                ),
              );
            },
          ),
          const SizedBox(height: AppSizes.linePadding),
          Text(category?.categoryName ?? "", style: AppTheme.smallBoldText),
        ],
      ),
    );
  }

  Widget categoryCardSquare(Data? category) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        0.0,
        0.0,
        AppSizes.genericPadding,
        AppSizes.linePadding,
      ),
      child: Column(
        children: [
          GestureDetector(
            child: Container(
              width: AppSizes.width / 6,
              height: AppSizes.width / 6,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFCADBF1)),
                color: const Color(0xFFEFF6FF),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(category?.url ?? ""),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                subCategory,
                arguments: subCategoryDataMap(
                  widget.fetchSubCategories
                      ?.firstWhereOrNull(
                        (e) => category?.categoryId == e.categoryId,
                      )
                      ?.children,
                  category?.categoryId,
                  category?.categoryName.toString() ?? "",
                ),
              );
            },
          ),
          const SizedBox(height: AppSizes.linePadding),
          Text(category?.categoryName ?? "", style: AppTheme.smallBoldText),
        ],
      ),
    );
  }

  Widget categoryCardRoundedSquare(Data? category) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        0.0,
        0.0,
        AppSizes.genericPadding,
        AppSizes.linePadding,
      ),
      child: Column(
        children: [
          GestureDetector(
            child: Container(
              width: AppSizes.width / 6,
              height: AppSizes.width / 6,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFCADBF1)),
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppSizes.mediumPadding),
                ),
                color: const Color(0xFFEFF6FF),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(category?.url ?? ""),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                subCategory,
                arguments: subCategoryDataMap(
                  widget.fetchSubCategories
                      ?.firstWhereOrNull(
                        (e) => category?.categoryId == e.categoryId,
                      )
                      ?.children,
                  category?.categoryId,
                  category?.categoryName.toString() ?? "",
                ),
              );
            },
          ),
          const SizedBox(height: AppSizes.linePadding),
          Text(category?.categoryName ?? "", style: AppTheme.smallBoldText),
        ],
      ),
    );
  }
}
