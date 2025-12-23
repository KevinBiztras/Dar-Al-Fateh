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
import 'package:flutter_project_structure/constants/arguments_map.dart';
import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/screens/orderDetail/bloc/order_detail_screen_bloc.dart';
import 'package:flutter_project_structure/screens/orderDetail/views/order_delivery_details.dart';
import 'package:flutter_project_structure/screens/orderDetail/views/order_heading_view.dart';
import 'package:flutter_project_structure/screens/orderDetail/views/order_id_date_view.dart';
import 'package:flutter_project_structure/screens/orderDetail/views/order_item_card.dart';
import 'package:flutter_project_structure/screens/orderDetail/views/order_price_details.dart';
import 'package:flutter_project_structure/screens/orderDetail/views/order_shipping_payment_info.dart';
import '../../constants/route_constant.dart';
import '../../customWidgtes/dialog_helper.dart';
import '../../helper/alert_message.dart';
import '../../helper/file_download.dart';
import '../../models/OrderDetailModel.dart';

class OrderDetails extends StatefulWidget {
  Map<String, dynamic>? orderData;

  OrderDetails(this.orderData, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OrderDetailState();
  }
}

class _OrderDetailState extends State<OrderDetails> {
  AppLocalizations? _localizations;
  bool isLoading = false;
  OrderDetailModel? _orderModel;
  OrderDetailsBloc? _orderBloc;

  @override
  void initState() {
    super.initState();
    _orderBloc = context.read<OrderDetailsBloc>();
    _orderBloc?.add(OrderDetailFetchEvent(widget.orderData?[productUrlKey]));
    // DownloadFile().bindIsolates(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = AppLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.orderData?[fromOrderListKey]) {
          return true;
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            navBar,
            (route) => false,
            arguments: 2,
          );
          return true;
        }
      },
      child: Scaffold(
        appBar: commonToolBar(
            _localizations?.translate(AppStringConstant.itemOrdered) ?? "",
            context,
            isElevated: false),
        body: BlocBuilder<OrderDetailsBloc, OrderDetailState>(
          builder: (context, state) {
            if (state is OrderDetailInitial) {
              isLoading = true;
            } else if (state is OrderDetailSuccess) {
              isLoading = false;
              _orderModel = state.model;
            } else if (state is ReorderDetailsStateSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                isLoading = false;
                AlertMessage.showSuccess(state.data.message ?? "", context);
                Navigator.pushNamed(context, cart);
              });
            } else if (state is OrderDetailError) {
              isLoading = false;
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showError(state.message ?? '', context);
              });
            }
            return isLoading ? Loader() : buildUI();
          },
        ),
      ),
    );
  }

  Widget buildUI() {
    return Container(
      width: AppSizes.width,
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSizes.mediumPadding),
              topRight: Radius.circular(AppSizes.mediumPadding)),
          border: Border.all(color: AppColors.background)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          orderIdContainer(context, _orderModel, _localizations),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  orderPlaceDateContainer(context, _orderModel, _localizations),
                  const SizedBox(
                    height: AppSizes.normalPadding,
                  ),
                  orderedItemList(),
                  const SizedBox(
                    height: AppSizes.normalPadding,
                  ),
                  (_orderModel?.pickingDetails ?? []).isNotEmpty
                      ? OrderDeliveryDetails(
                          localization: _localizations,
                          orderDetailModel: _orderModel,
                        )
                      : Container(),
                  (_orderModel?.pickingDetails ?? []).isNotEmpty
                      ? const SizedBox(
                          height: AppSizes.normalPadding,
                        )
                      : Container(),
                  orderPriceDetails(_orderModel ?? OrderDetailModel(), context,
                      _localizations),
                  const SizedBox(
                    height: AppSizes.normalPadding,
                  ),
                  shippingPaymentInfo(context, _localizations, _orderModel),
                  if (_orderModel?.canReOrder ?? false)
                    const SizedBox(
                      height: AppSizes.normalPadding,
                    ),
                  if (_orderModel?.canReOrder ?? false)
                    SizedBox(
                      width: AppSizes.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                          onPressed: () {
                            if (_orderModel?.needCartMerge ?? false) {
                              DialogHelper.reorderDialog(
                                _orderModel?.id.toString() ?? "0",
                                context,
                              );
                            } else {
                              _orderBloc?.add(OrderDetailReorderEvent(
                                  _orderModel?.id.toString() ?? "0", false));
                            }
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              side: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                  width: 1.5)),
                          child: Text(
                              (_localizations?.translate(
                                          AppStringConstant.reorder) ??
                                      "")
                                  .toUpperCase(),
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer,
                                  )),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget orderedItemList() {
    return orderHeaderLayout(
        context,
        '${_orderModel?.items?.length} ${_localizations?.translate(AppStringConstant.itemsOrdered)}',
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.imageRadius),
          child: ListView.builder(
              itemCount: _orderModel?.items?.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return orderItemCard(_orderModel?.items?[index] ?? OrderItems(),
                    context, _localizations);
              }),
        ));
  }
}
