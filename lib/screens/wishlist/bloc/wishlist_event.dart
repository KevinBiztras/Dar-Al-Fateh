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
abstract class WishlistEvent extends Equatable{
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class WishlistDataFetchEvent extends WishlistEvent{

}

class MoveToCartEvent extends WishlistEvent{
  final String productName;
  final int wishlistId;
  final int productId;
  final int? templateId;

  const MoveToCartEvent(this.productName,this.wishlistId,this.productId,
      {this.templateId});

  @override
  List<Object> get props => [];

}

class RemoveItemEvent extends WishlistEvent{
  final int wishlistId;

  const RemoveItemEvent(this.wishlistId);

  @override
  List<Object> get props => [];
}
