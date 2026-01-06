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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/customWidgtes/badge_icon.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/customWidgtes/lottie_animation.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/models/WishlistModel.dart';
import 'package:flutter_project_structure/screens/wishlist/bloc/wishlist_bloc.dart';
import 'package:flutter_project_structure/screens/wishlist/bloc/wishlist_event.dart';
import 'package:flutter_project_structure/screens/wishlist/bloc/wishlist_state.dart';
import '../../constants/app_constants.dart';
import '../../constants/route_constant.dart';
import '../../helper/alert_message.dart';
import '../../helper/image_view.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  AppLocalizations? _localizations;
  WishlistModel? wishlistModel;
  bool isLoading = true;
  bool isAction = false;
  WishlistScreenBloc? wishlistScreenBloc;

  @override
  void initState() {
    wishlistScreenBloc = context.read<WishlistScreenBloc>();
    wishlistScreenBloc?.add(WishlistDataFetchEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(
            _localizations?.translate(AppStringConstant.wishList) ?? "",
            context,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, cart);
                  },
                  icon: BadgeIcon(
                    icon: const Icon(Icons.shopping_cart),
                  )),
            ]),
        body: BlocBuilder<WishlistScreenBloc, WishlistState>(
            builder: (context, currentState) {
              if (currentState is WishlistInitialState) {
                isLoading = true;
              } else if (currentState is WishlistScreenSuccess) {
                isLoading = false;
                isAction = false;
                wishlistModel = currentState.wishlistModel;
              } else if (currentState is WishlistActionState) {
                isAction = true;
              } else if (currentState is MoveToCartSuccess) {
                isLoading = false;
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  AlertMessage.showSuccess(
                      currentState.baseModel?.message ?? '', context);
                });
                wishlistScreenBloc?.add(WishlistDataFetchEvent());
              } else if (currentState is RemoveItemSuccess) {
                isLoading = false;
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  AlertMessage.showSuccess(
                      currentState.baseModel?.message ?? '', context);
                });
                wishlistScreenBloc?.add(WishlistDataFetchEvent());
              } else if (currentState is WishlistScreenError) {
                isLoading = false;
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  AlertMessage.showError(currentState.message ?? '', context);
                });
              }
              return buildUI(wishlistModel?.wishLists, context);
            }));
  }

  Widget buildUI(List<WishListItems>? items, BuildContext context) {
    return isLoading
        ? Loader()
        : Visibility(
        visible: wishlistModel != null,
        child: (wishlistModel?.wishLists ?? []).isEmpty ||
            wishlistModel?.wishlistCount == 0
            ? lottieAnimation(
            context, _localizations?.translate(AppStringConstant.noItems) ?? "",
            _localizations
                ?.translate(AppStringConstant.noItemsInWishlist) ??
                "",
            _localizations
                ?.translate(AppStringConstant.continueShopping) ??
                "", () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(navBar, (route) => false,arguments: 0);
        },
          lottiePath:(Theme.of(context).brightness == Brightness.light) ? "lib/assets/lottie/empty_wishlist.json" :"lib/assets/lottie/empty_wishlist_dark.json",

        )
            : Padding(
            padding: const EdgeInsets.all(AppSizes.imageRadius),
            child: buildWishlistView(items, context)));
  }

  Widget buildWishlistView(List<WishListItems>? items, BuildContext context) {
    return Stack(children: [
      GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (1 - (110 / (AppSizes.width + 50))),
          ),
          itemCount: items?.length,
          itemBuilder: (BuildContext context, int index) {
            var imageSize = (AppSizes.width / 2.8) - AppSizes.linePadding;
            return Stack(children: [
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border:
                      Border.all(color: Theme.of(context).dividerColor),
                      borderRadius: BorderRadius.all(Radius.circular(AppSizes.linePadding))
                  ),
                  margin: EdgeInsets.symmetric(horizontal: AppSizes.linePadding/2, vertical: AppSizes.linePadding/2),
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(AppSizes.extraPadding,AppSizes.normalPadding,AppSizes.extraPadding,AppSizes.normalPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ImageView(
                                url: items?[index].thumbNail,
                                height: imageSize,
                                width: imageSize+AppSizes.mediumPadding ,
                                fit: BoxFit.fill,
                              ),
                               SizedBox(height: AppSizes.linePadding,),
                              Text(
                                items?[index].name ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontSize: 13),
                              ),
                               SizedBox(height: AppSizes.linePadding,),
                              Text(
                                items?[index].priceUnit ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              // Padding(
                              //     padding: const EdgeInsets.symmetric(
                              //       horizontal: AppSizes.linePadding,
                              //     ),
                              //     child: Text(
                              //       items?[index].name ?? "",
                              //       maxLines: 2,
                              //       style: Theme.of(context)
                              //           .textTheme
                              //           .bodyMedium
                              //           ?.copyWith(fontSize: 13),
                              //     )),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: AppSizes.linePadding),
                              //   child: Text(
                              //     items?[index].priceUnit ?? "",
                              //     style: Theme.of(context)
                              //         .textTheme
                              //         .bodyLarge
                              //         ?.copyWith(fontWeight: FontWeight.bold),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: AppSizes.width/2.5,
                            child: TextButton(
                                onPressed: () {
                                  wishlistScreenBloc
                                      ?.emit(WishlistActionState());
                                  wishlistScreenBloc?.add(MoveToCartEvent(
                                      items?[index].name ?? "",
                                      items?[index].id ?? 0,
                                      items?[index].productId ?? 0,
                                      templateId: items?[index].templateId));
                                },
                                style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary),
                                child: Text(
                                  _localizations?.translate(
                                      AppStringConstant.moveToCart) ??
                                      '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                      fontWeight: FontWeight.w500,color: Theme.of(context).colorScheme.secondaryContainer),

                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, productPage,
                      arguments: getProductDataMap(items?[index].name ?? "",
                          items?[index].templateId.toString() ?? ''));
                },
              ),
              Positioned(
                  top: 16.0,
                  right: 22.0,
                  child: GestureDetector(
                    onTap: () {
                      DialogHelper.confirmationDialog(
                          AppStringConstant.removeItemFromWishlist,
                          context,
                          _localizations, onConfirm: () {
                        wishlistScreenBloc?.emit(WishlistActionState());
                        wishlistScreenBloc?.add(
                            RemoveItemEvent(items?[index].productId ?? 0));
                      });
                    },
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        color: AppColors.gray.withOpacity(0.5)
                          ),
                      child: Semantics(
                        identifier: 'wishlist_delete_icon',
                        child: const Icon(
                          Icons.close,
                          size: 17,
                        ),
                      ),
                    ),
                  ))
            ]);
          }),
      Center(
          child: Visibility(
            visible: isAction,
            child: Loader(),
          )),
    ]);
  }

}
