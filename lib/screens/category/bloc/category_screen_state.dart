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

part of 'category_screen_bloc.dart';

abstract class CategoryScreenState {
  const CategoryScreenState();

  @override
  List<Object> get props => [];
}

class CategoryScreenInitial extends CategoryScreenState {}

class CategoryScreenSuccess extends CategoryScreenState {
  GetFilterAttribute? category;

  CategoryScreenSuccess(this.category);
}

class CategoryHomeApiSuccess extends CategoryScreenState {
  CategoryHomeApiSuccess(this.homePageData);

  HomePageData? homePageData;

  @override
  List<Object> get props => [];
}

class CategoryScreenError extends CategoryScreenState {
  CategoryScreenError(this._message);

  String? _message;

  // ignore: unnecessary_getters_setters
  String? get message => _message;

  // ignore: unnecessary_getters_setters
  set message(String? message) {
    _message = message;
  }

  @override
  List<Object> get props => [];
}
