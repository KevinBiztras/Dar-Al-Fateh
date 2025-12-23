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

// part of 'product_screen_bloc';

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
abstract class ProductScreenEvent extends Equatable {
  const ProductScreenEvent();

  @override
  List<Object> get props => [];
}

class ProductScreenLoadingEvent extends ProductScreenEvent{

}

class ProductScreenDataFetchEvent extends ProductScreenEvent {
  String? productId;

  ProductScreenDataFetchEvent(this.productId);
}

class QuantityUpdateEvent extends ProductScreenEvent {
  int? qty;
  QuantityUpdateEvent(this.qty);
}

class ChangeWishlistEvent extends ProductScreenEvent {
  bool? status;
  String? productId;
  ChangeWishlistEvent(this.status,this.productId);
}

class AddToWishlistEvent extends ProductScreenEvent{
  String productId;
  String productName;
  AddToWishlistEvent(this.productId,this.productName);
}

class RemoveFromWishlistEvent extends ProductScreenEvent{
  String? productId;
  RemoveFromWishlistEvent(this.productId);
}

class ReviewsDataFetchEvent extends ProductScreenEvent{
  String? productId;
  ReviewsDataFetchEvent(this.productId);
}

class ReviewLikeDislikeEvent extends ProductScreenEvent {
  String? reviewId;
  bool? isHelpful;

  ReviewLikeDislikeEvent(this.reviewId, this.isHelpful);
}

class AddtoCartEvent extends ProductScreenEvent{
  String productId;
  int addQty;

  AddtoCartEvent(this.productId,this.addQty);
}

class BuyNowEvent extends ProductScreenEvent{
  String productId;
  int addQty;

  BuyNowEvent(this.productId,this.addQty);
}

class AddReviewEvent extends ProductScreenEvent{
  final int rating;
  final String title;
  final String detail;
  final int templateId;

  const AddReviewEvent(this.rating,this.title,this.detail,this.templateId);
}
