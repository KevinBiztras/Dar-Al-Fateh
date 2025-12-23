import 'dart:convert';

// import 'package:firebase_analytics/firebase_analytics.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/firebase_analytics.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/helper/open_bottom_model_sheet.dart';
import 'package:flutter_project_structure/local_database/hive_constants.dart';
import 'package:flutter_project_structure/local_database/hive_service.dart';
import 'package:flutter_project_structure/models/CategoryScreenModel.dart';
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/screens/category/bloc/category_screen_bloc.dart';
import 'package:flutter_project_structure/screens/category/widgets/category_products.dart';
import 'package:flutter_project_structure/screens/category/widgets/category_tile.dart';

import '../../models/FilterDataModel.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  AppLocalizations? _localizations;
  CategoryScreenBloc? categoryScreenBloc;
  int _selectedIndex = 0;
  HomePageData? homePageData;
  bool? isSubCategoryLoading;
  bool isLoading = true;
  List<Categories>? categories;
  GetFilterAttribute? categoryScreenModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = AppLocalizations.of(context);
  }

  @override
  void initState() {
    super.initState();
    categoryScreenBloc = context.read<CategoryScreenBloc>();
    categoryScreenBloc?.add(CategoryHomeFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          "${_localizations?.translate(AppStringConstant.categories)}", context,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, searchPage);
                },
                icon: const Icon(
                  Icons.search,
                )),
            IconButton(
                onPressed: () {
                  notificationBottomModelSheet(context);
                },
                icon: const Icon(
                  Icons.notifications,
                ))
          ]),
      body: BlocBuilder<CategoryScreenBloc, CategoryScreenState>(
          builder: (context, state) {
        if (state is CategoryScreenInitial) {
          isSubCategoryLoading = true;
        } else if (state is CategoryHomeApiSuccess) {
          categories = state.homePageData?.categories;
          if (categories?.isNotEmpty ?? false) {
            categoryScreenBloc?.add(CategoryScreenDataFetchEvent(
                categories?[0].categoryId ?? 0, 10, 0));
          }
          isLoading = false;
        } else if (state is CategoryScreenSuccess) {
          categoryScreenModel = state.category;
          isSubCategoryLoading = false;
          // AnalyticsEventsFirebase().viewCategory(categoryScreenModel?.products
          //     ?.map((e) => AnalyticsEventItem(
          //           itemId: e.productId.toString(),
          //           itemName: e.name,
          //         ))
          //     .toList());
        } else if (state is CategoryScreenError) {
          isSubCategoryLoading = true;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(state.message ?? '', context);
          });
        }
        return (isLoading == true)
            ? Loader()
            : (categories?.isNotEmpty ?? false)
                ? Container(
                    color: Theme.of(context).colorScheme.primary,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [categoryListView(), subcategoryListView()],
                    ),
                  )
                : Center(
                    child: Text(_localizations
                            ?.translate(AppStringConstant.noCategoryData) ??
                        ''),
                  );
      }),
    );
  }

  //========For Left (main) categories==========//
  Widget categoryListView() {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: AppSizes.width / 5,
      height: AppSizes.height,
      color: AppColors.lightGray.withOpacity(0.1),
      child: ListView.builder(
          itemCount: categories?.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                categoryScreenModel?.products = null;
                categoryScreenBloc?.add(CategoryScreenDataFetchEvent(
                    categories?[index].categoryId ?? 0, 10, 0));
                categoryScreenBloc?.emit(CategoryScreenInitial());
                setState(() {
                  _selectedIndex = index;
                  // if(categories?[index].children?.length == 0){
                  // }
                });
              },
              child: Container(
                color: _selectedIndex == index
                    ? isDarkMode ? AppColors.black :AppColors.white
                    : isDarkMode ? Theme.of(context).cardColor : const Color(0xFFE2E8F0).withOpacity(0.5),
                padding: const EdgeInsets.all(AppSizes.linePadding),
                // height: AppSizes.height * 0.1,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: ImageView(
                        url: categories?[index].icon ?? "",
                        width: AppSizes.width / 6,
                        height: AppSizes.width / 6,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(height: AppSizes.linePadding),
                    Text(
                      categories?[index].name ?? "",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  //======For Right (sub) categories========//
  Widget subcategoryListView() {
    var width = MediaQuery.of(context).size.width -
        MediaQuery.of(context).size.width / 5;

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: width,
            minHeight:
                AppSizes.height - kBottomNavigationBarHeight - kToolbarHeight),
        child: (categories?[_selectedIndex].children ?? []).isNotEmpty
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CategoryTile(
                    subCategories: categories?[_selectedIndex].children,
                  ),
                  const SizedBox(height: AppSizes.sidePadding),
                  categoryProducts()
                ],
              )
            : categoryProducts(),
      ),
    );
  }

  //=========Showing products for selected category=======//
  Widget categoryProducts() {
    return buildCategoryProducts(
        categoryScreenModel?.products ?? [],
        _localizations,
        context,
        isSubCategoryLoading,
        categories?[_selectedIndex].categoryId,
        categories?[_selectedIndex].name ?? "",
        postWishlistClick
    );
  }

  void postWishlistClick(){
    final HiveService hiveService = HiveService();
    Map<String, dynamic> data = {};
    data["cid"] = categories?[_selectedIndex].categoryId ?? 0;
    data["limit"] = 10;
    data["offset"] = 0;
    String body = json.encode(data);
    String categoryBoxName = HiveConstants.getCategoryPageBoxName(body);
    categoryScreenBloc?.repository?.callCategoryApiAndUpdateHiveDB(hiveService, categoryBoxName, body);

  }
}
