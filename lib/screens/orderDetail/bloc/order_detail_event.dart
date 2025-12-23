
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

part of 'order_detail_screen_bloc.dart';

abstract class OrderDetailEvent extends Equatable{
  const OrderDetailEvent();

  @override
  List<Object> get props => [];
}

class OrderDetailFetchEvent extends OrderDetailEvent{
  String orderEndpoint;
OrderDetailFetchEvent(this.orderEndpoint);
}
class OrderDetailReorderEvent extends OrderDetailEvent{
  final String id;
  final bool needCartMerge;
  const OrderDetailReorderEvent(this.id, this.needCartMerge);
}