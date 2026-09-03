
// ============ cart_main_view.dart ============
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
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/image_view.dart';
import 'package:flutter_project_structure/models/CartViewModel.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_bloc.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_event.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_state.dart';
import 'package:flutter_project_structure/screens/cart/widgets/price_details.dart';

import '../../../constants/arguments_map.dart';
import '../../../helper/LocalDb/floor/database.dart';
import '../../../helper/LocalDb/floor/entities/recent_product.dart';
import '../../../helper/alert_message.dart';
import '../../../helper/app_shared_pref.dart';
import '../../../models/BaseModel.dart';
import '../../../models/HomeScreenModel.dart';
import '../../product/bloc/product_screen_repository.dart';
import 'cart_icon_button.dart';
import 'cart_product_item.dart';

// ---- Brand tokens (kept local so this file is drop-in standalone) ----
const Color _emerald = Color(0xFF1B5E20);
const Color _leafGreen = Color(0xFF2E7D32);
const Color _sage = Color(0xFFB7C9A8);
const Color _sageLight = Color(0xFFEFF4EA);
const Color _gold = Color(0xFFF9A825);

class CartMainView extends StatelessWidget {
  const CartMainView(this.model, this.localizations, this.bloc, {Key? key})
    : super(key: key);

  final CartViewModel? model;
  final AppLocalizations? localizations;
  final CartScreenBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // products list view
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSizes.mediumPadding,
            AppSizes.mediumPadding,
            AppSizes.mediumPadding,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // ---- "N ITEMS" pill header ----
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _sageLight,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _sage.withOpacity(0.6)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.shopping_basket_rounded,
                      size: 16,
                      color: _emerald,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "${model?.cartCount} " +
                          (localizations?.translate(AppStringConstant.items) ??
                                  "")
                              .toUpperCase(),
                      style: const TextStyle(
                        color: _emerald,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.5,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.mediumPadding),

              // Listview of products in cart, now each item wrapped as a card
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) =>
                    CartProductItem(model?.items?[index], localizations, bloc),
                itemCount: (model?.items?.length ?? 0),
              ),

              if (AppSharedPref().getSplashData()?.isUpSelling ?? false)
                Visibility(
                  visible: model?.accessoriesProducts?.isNotEmpty ?? false,
                  child: Container(
                    margin: const EdgeInsets.only(top: AppSizes.linePadding),
                    padding: const EdgeInsets.all(AppSizes.mediumPadding),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.local_florist_rounded,
                                size: 16,
                                color: _gold,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                (localizations?.translate(
                                          AppStringConstant.suggestedItems,
                                        ) ??
                                        "")
                                    .toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.3,
                                  color: _emerald,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSizes.mediumPadding),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: model?.accessoriesProducts?.length ?? 0,
                          itemBuilder: (context, index) {
                            final item = model?.accessoriesProducts?[index];
                            return InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  productPage,
                                  arguments: getProductDataMap(
                                    item?.name ?? '',
                                    item?.templateId.toString() ?? '',
                                  ),
                                ).then((value) {
                                  bloc?.add(const CartScreenDataFetchEvent());
                                  bloc?.emit(CartScreenInitial());
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppSizes.imageRadius,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: ImageView(
                                        url: item?.image,
                                        height: AppSizes.height / 7,
                                        width: AppSizes.width / 4,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: AppSizes.mediumPadding,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item?.name ?? "",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            item?.priceUnit ?? "",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: _leafGreen,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          SizedBox(
                                            height: 34,
                                            child: OutlinedButton(
                                              onPressed: () {
                                                processAddToCartRequest(
                                                  item,
                                                  context,
                                                );
                                              },
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor: _emerald,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                side: BorderSide.none,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                    ),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                    Icons
                                                        .add_shopping_cart_rounded,
                                                    color: Colors.white,
                                                    size: 16,
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    localizations?.translate(
                                                          AppStringConstant
                                                              .addToCart,
                                                        ) ??
                                                        "",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.5,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(color: _sage.withOpacity(0.3));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: AppSizes.mediumPadding),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.mediumPadding,
          ),
          child: Row(
            children: [
              Expanded(
                child: CartIconButton(
                  leadingIcon: Icons.remove_shopping_cart,
                  title:
                      (localizations?.translate(AppStringConstant.emptyCart) ??
                              "")
                          .toUpperCase(),
                  onClick: () {
                    DialogHelper.confirmationDialog(
                      AppStringConstant.emptyCartText,
                      context,
                      localizations,
                      onConfirm: () {
                        bloc?.add(SetCartEmpty());
                        bloc?.emit(CartScreenInitial());
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.linePadding),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.mediumPadding,
          ),
          child: CartIconButton(
            leadingIcon: Icons.arrow_forward,
            title:
                localizations?.translate(AppStringConstant.continueShopping) ??
                "",
            onClick: () {
              Navigator.pushNamed(
                context,
                catalogPage,
                arguments: getCatalogMap(
                  "",
                  false,
                  "Shop Vegitables",
                  customerId: 0,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSizes.mediumPadding),
        // Price Details
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.mediumPadding,
          ),
          child: PriceDetails(
            totalProducts: model?.subtotal?.value,
            grandTotal: model?.grandtotal?.value,
            localizations: localizations,
            totalTax: model?.tax?.value,
          ),
        ),
        const SizedBox(height: AppSizes.mediumPadding),
      ],
    );
  }

  void processAddToCartRequest(
    Accessories? product,
    BuildContext context,
  ) async {
    ProductScreenRepositoryImp? repository = ProductScreenRepositoryImp();
    try {
      bloc?.add(AddToCartEvent(product?.productId ?? 0));
      Navigator.pop(context);
    } catch (error, _) {
      debugPrint(error.toString());
      Navigator.pop(context);
      AlertMessage.showError(error.toString(), context);
    }
  }
}
