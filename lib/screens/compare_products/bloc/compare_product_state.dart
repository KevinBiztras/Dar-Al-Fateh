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

import '../../../models/BaseModel.dart';
import '../../../models/compare_product_model.dart';


abstract class CompareProductState {
  const CompareProductState();

  @override
  List<Object> get props => [];

}

class CompareProductInitial extends CompareProductState{}

class CompareProductSuccess extends CompareProductState{
  final  CompareProductModel model;

  const CompareProductSuccess(this.model);
}

class CompareProductError extends CompareProductState{
  final String? message;
  const CompareProductError(this.message);
}

class AddProductToWishlistStateSuccess extends CompareProductState {
  final BaseModel wishListModel;
  final String productId;

  const AddProductToWishlistStateSuccess(this.wishListModel,this.productId);

  @override
  List<Object> get props => [];
}

class RemoveFromWishlistStateSuccess extends CompareProductState {
  final BaseModel baseModel;
  final String productId;

  const RemoveFromWishlistStateSuccess(this.baseModel,this.productId,);

  @override
  List<Object> get props => [];
}

class AddToCartState extends CompareProductState{
  BaseModel? model;
  AddToCartState(this.model);

  @override
  List<Object> get props => [];
}

class AddToCartError extends CompareProductState {
  AddToCartError(this.message);
  String? message;

  @override
  List<Object> get props => [];
}