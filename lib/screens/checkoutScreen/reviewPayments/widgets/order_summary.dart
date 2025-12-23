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

import 'package:flutter/cupertino.dart';
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
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/models/OrderReviewModel.dart';

import '../../../../constants/app_constants.dart';
import '../../../../helper/app_shared_pref.dart';
import '../../../../helper/image_view.dart';
import '../bloc/review_screen_bloc.dart';
import '../bloc/review_screen_event.dart';
import '../bloc/review_screen_state.dart';

Widget orderSummary(
    BuildContext context,
    AppLocalizations? _localization,
    List<OrderReviewItems> items,
    PaymentReviewScreenBloc? paymentReviewScreenBloc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSizes.mediumPadding),
    child: Container(
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.imageRadius),
            child: Text(
              _localization?.translate(AppStringConstant.orderSummary) ?? "",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: AppColors.lightGray),
            ),
          ),
          const Divider(
            thickness: 1,
            height: 1,
          ),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var data = items[index];
                return buildItems(
                    data, context, _localization, paymentReviewScreenBloc);
              }),
        ],
      ),
    ),
  );
}

Widget buildItems(
    OrderReviewItems item,
    BuildContext context,
    AppLocalizations? _localization,
    PaymentReviewScreenBloc? paymentReviewScreenBloc) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(
      color: Theme.of(context).dividerColor,
    )),
    child: Stack(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Stack(children: <Widget>[
                ImageView(
                  url: item.thumbNail,
                  height: (AppSizes.width / 2.5),
                ),
              ]),
            ),
            const SizedBox(
              width: AppSizes.imageRadius,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 2.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.linePadding),
                    child: Text(item.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.normal)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.linePadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          (_localization?.translate(AppStringConstant.price_) ??
                                  "") +
                              " ",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontSize: 15),
                        ),
                        Text(
                            (item.priceReduce ?? '').isNotEmpty
                                ? item.priceReduce ?? ''
                                : item.priceUnit ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        Visibility(
                            visible: (item.priceReduce ?? '').isNotEmpty,
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: AppSizes.linePadding,
                                ),
                                Text(item.priceUnit ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold)),
                              ],
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.linePadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          (_localization?.translate(AppStringConstant.qty) ??
                                  "") +
                              " ",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontSize: 15),
                        ),
                        Text((item.qty?.toInt()).toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.linePadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          (_localization
                                      ?.translate(AppStringConstant.subtotal) ??
                                  "") +
                              ": ",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontSize: 15),
                        ),
                        Text(item.total ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        if ((AppSharedPref().getSplashData()?.couponsProgram ?? false) &&
            !(item.isEditable ?? false))
          Positioned(
              right: 8,
              top: 8,
              child: IconButton(
                onPressed: () {
                  paymentReviewScreenBloc
                      ?.add(RemoveCouponCodeEvent(item.lineId ?? 0));
                  paymentReviewScreenBloc?.emit(PaymentReviewScreenInitial());
                },
                icon: Icon(
                  Icons.cancel_outlined,
                  size: 28,
                ),
              ))
      ],
    ),
  );
}
