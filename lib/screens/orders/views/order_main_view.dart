/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/models/OrderModel.dart';
import 'package:flutter_project_structure/screens/addressBook/views/address_item_card.dart';

import '../../../constants/arguments_map.dart';
import '../../../customWidgtes/dialog_helper.dart';
import '../../../helper/app_shared_pref.dart';
import '../bloc/order_screen_bloc.dart';
import '../bloc/order_screen_events.dart';

class OrderMainView extends StatefulWidget {
  final List<RecentOrders>? orders;
  final AppLocalizations? localizations;
  final Function(String url) callback;
  final ScrollController controller;
  final ScrollPhysics? scrollPhysics;

  const OrderMainView({
    Key? key,
    this.orders,
    this.localizations,
    this.scrollPhysics,
    required this.callback,
    required this.controller,
  }) : super(key: key);

  @override
  State<OrderMainView> createState() => _OrderMainViewState();
}

class _OrderMainViewState extends State<OrderMainView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: widget.controller,
      shrinkWrap: true,
      physics: widget.scrollPhysics,
      itemBuilder: (context, index) => orderItem(context, widget.orders?[index],
          widget.localizations, widget.callback),
      separatorBuilder: (ctx, index) => const SizedBox(
        height: AppSizes.linePadding,
        child: Divider(),
      ),
      itemCount: (widget.orders?.length ?? 0),
    );
  }

  Widget orderItem(BuildContext context, RecentOrders? item,
      AppLocalizations? localizations, Function(String) callback) {
    int ? _selectedValue;

    return Container(
      padding: const EdgeInsets.only(
          top: AppSizes.imageRadius,
          left: AppSizes.imageRadius,
          right: AppSizes.imageRadius),
      margin: const EdgeInsets.only(bottom: AppSizes.imageRadius),
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "#${item?.name.toString() ?? " "}",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSizes.imageRadius),
                    statusContainer(context, item?.status ?? ''),
                    const SizedBox(height: AppSizes.imageRadius),
                    Text(
                      item?.createDate ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: AppSizes.imageRadius),
                    Text(item?.amountTotal ?? "0.00",
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: AppSizes.imageRadius),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
              ),

              // Edit button
            ],
          ),
          const Divider(
            thickness: 1,
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, orderDetails,
                        arguments: getOrderDetailDataMap(item?.url ?? ''));
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimary,
                          width: 1.5)),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.imageRadius),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.navigate_next,
                          size: AppSizes.widgetSidePadding,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        const SizedBox(width: AppSizes.linePadding),
                        Flexible(
                            child: Text(
                                (localizations?.translate(
                                            AppStringConstant.details) ??
                                        '')
                                    .toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.onPrimary))),
                      ],
                    ),
                  ),
                ),
              ),
              if (item?.canReOrder ?? false)
                const SizedBox(
                  width: AppSizes.normalPadding,
                ),
              if (item?.canReOrder ?? false)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      if (item?.needCartMerge ?? false) {
                        DialogHelper.reorderDialog(
                            item?.id.toString() ?? "",

                            context,);
                      }
                      else {
                        context.read<OrderScreenBloc>()?.add(ReorderEvent(item?.id.toString() ?? "0", false));
                      }
                    },
                    style: OutlinedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.onPrimary,
                            width: 1.5)),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.imageRadius),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.swap_horiz,
                            size: AppSizes.widgetSidePadding,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          const SizedBox(width: AppSizes.linePadding),
                          Flexible(
                              child: Text(
                                  (localizations?.translate(
                                              AppStringConstant.reorder) ??
                                          "")
                                      .toUpperCase(),
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.onPrimary))),
                        ],
                      ),
                    ),
                  ),
                ),
              if (AppSharedPref().getSplashData()?.addons?.review ?? false)
                const SizedBox(
                  width: AppSizes.normalPadding,
                ),
              if (AppSharedPref().getSplashData()?.addons?.review ??  false)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      callback(item?.url ?? '');
                    },
                    style: OutlinedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.onPrimary,
                            width: 1.5)),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.imageRadius),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.rate_review_outlined,
                            size: AppSizes.widgetSidePadding,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          const SizedBox(width: AppSizes.linePadding),
                          Flexible(
                              child: Text(
                                  (localizations?.translate(
                                              AppStringConstant.reviews) ??
                                          "")
                                      .toUpperCase(),
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.onPrimary))),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }

  Widget statusContainer(BuildContext context, String status) {
    return Container(
      color: containerColor(status),
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.imageRadius / 2, horizontal: AppSizes.imageRadius),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
              child: Text(
            status,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: AppColors.white),
          )),
        ],
      ),
    );
  }

  Color containerColor(String status) {
    switch (status.toUpperCase()) {
      case 'COMPLETE':
        return AppColors.green;
      default:
        return AppColors.yellow;
    }
  }
}
