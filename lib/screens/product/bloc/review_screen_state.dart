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
import 'package:equatable/equatable.dart';import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/ReviewListModel.dart';

abstract class ReviewScreenState extends Equatable {
  const ReviewScreenState();

  @override
  List<Object> get props => [];
}

class ReviewScreenInitial extends ReviewScreenState {}

class ReviewScreenSuccess extends ReviewScreenState {
  ReviewScreenSuccess(this.reviewsData);

  ReviewListModel? reviewsData;

  @override
  List<Object> get props => [];
}

class LikeDislikeReviewSuccess extends ReviewScreenState {
  LikeDislikeReviewSuccess(this.baseModel);

  BaseModel? baseModel;
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class ReviewScreenError extends ReviewScreenState {
  ReviewScreenError(this._message);

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
