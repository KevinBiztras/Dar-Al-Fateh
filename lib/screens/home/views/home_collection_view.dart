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
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/screens/home/views/product_list_widgets/product_list_widgets.dart';

class HomeCollection extends StatefulWidget {
  List<Data>? products;

  final VoidCallback postWishlistClick;

  HomeCollection({Key? key, this.products, required this.postWishlistClick})
    : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeCollectionState();
  }
}

class HomeCollectionState extends State<HomeCollection> {
  int selectedCard = -1;
  AppLocalizations? _localizations;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.products?.length ?? 0,
      itemBuilder: (context, index) => getProductSlider(
        widget.products![index],
        index,
        widget.postWishlistClick,
      ),
    );
  }

  Widget getProductSlider(
    Data productSliders,
    int index,
    VoidCallback postWishlistClick,
  ) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.imageRadius),
      margin: const EdgeInsets.symmetric(vertical: AppSizes.imageRadius),
      color: Colors.amber,
      //  isDarkMode ? AppColors.black : AppColors.backgroundLight,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.sidePadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(AppSizes.imageRadius / 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppSizes.imageRadius / 2,
                    ),
                    // color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  child: Text(
                    // productSliders.title ?? "",
                    'Vegitables',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Visibility(
                  visible: getViewAllVisibility(
                    productSliders.sliderMode ?? "",
                    (productSliders.products?.length ?? 0),
                  ),
                  child: viewAllButton(context, () {
                    Navigator.pushNamed(
                      context,
                      catalogPage,
                      arguments: getCatalogMap(
                        productSliders.url ?? '',
                        true,
                        "Catalog",
                        customerId: 0,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          getProductListType(
            productSliders.products ?? [],
            productSliders.sliderMode ?? "",
            productSliders.url,
            postWishlistClick,
          ),
        ],
      ),
    );
  }

  //==============Products List Item Types============//

  Widget getProductListType(
    List<Products> products,
    String sliderMode,
    String? url,
    VoidCallback postWishlistClick,
  ) {
    if (sliderMode == AppConstant.productFixed) {
      return buildStaggeredGrid(
        products,
        _localizations,
        postWishlistClick: postWishlistClick,
      );
    } else if (sliderMode == AppConstant.productDefault) {
      return buildHorizontalProduct(
        products,
        _localizations,
        url: url,
        postWishlistClick: postWishlistClick,
      );
    } else {
      var list = [
        buildHorizontalProduct(
          products,
          _localizations,
          url: url,
          postWishlistClick: postWishlistClick,
        ),
        buildStaggered(products, postWishlistClick: postWishlistClick),
        buildStaggeredGrid(
          products,
          _localizations,
          postWishlistClick: postWishlistClick,
        ),
      ];
      return (list..shuffle()).first;
    }
  }

  bool getViewAllVisibility(String sliderMode, int length) {
    if (sliderMode == AppConstant.productFixed) {
      return length.isEven ? true : false;
    } else if (sliderMode == AppConstant.productDefault) {
      if (length > 10) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}

Widget viewAllButton(BuildContext context, GestureTapCallback onClick) {
  return SizedBox(
    height: AppSizes.width / 15,
    child: ElevatedButton(
      onPressed: onClick,
      child: Text(
        AppLocalizations.of(context)!.translate(AppStringConstant.viewAll),
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).colorScheme.onPrimary),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    ),
  );
}
