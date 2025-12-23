/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */
import 'package:equatable/equatable.dart';
abstract class OrderScreenEvent extends Equatable{
  const OrderScreenEvent();

  @override
  List<Object> get props => [];
}

class OrderScreenDataFetchEvent extends OrderScreenEvent{
  final int offset;
  final int limit;
  const OrderScreenDataFetchEvent(this.offset, this.limit);
}

class OrderDetailsFetchEvent extends OrderScreenEvent{
  final String url;
  const OrderDetailsFetchEvent(this.url);
}
class ReorderEvent extends OrderScreenEvent{
  final String id;
  final bool needCartMerge;
  const ReorderEvent(this.id, this.needCartMerge);
}
