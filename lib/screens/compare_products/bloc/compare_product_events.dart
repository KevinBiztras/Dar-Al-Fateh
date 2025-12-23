/*
 *
 *  Webkul Software.
 * @package Mobikul Application Code.
 *  @Category Mobikul
 *  @author Webkul <support@webkul.com>
 *  @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *  @license https://store.webkul.com/license.html
 *  @link https://store.webkul.com/license.html
 *
 * /
 */

import 'package:equatable/equatable.dart';

abstract class CompareProductEvent extends Equatable{
  const CompareProductEvent();

  @override
  List<Object> get props => [];
}

class CompareProductDataFetchEvent extends CompareProductEvent {
  const CompareProductDataFetchEvent();

  @override
  List<Object> get props => [];
}


//add to wishlist
class AddToWishlistEvent extends CompareProductEvent{
 final  String? productId;
 final  String? productName;
  const AddToWishlistEvent(this.productId,this.productName);

}

//remove from wishlist
class RemoveFromWishlistEvent extends CompareProductEvent{
  final String? productId;
  const RemoveFromWishlistEvent(this.productId);

}

class AddToCartEvent extends CompareProductEvent{
  final String productId;
  final String addQty;

  const AddToCartEvent(this.productId,this.addQty);
}