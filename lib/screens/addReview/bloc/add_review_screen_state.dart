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

abstract class AddReviewScreenState extends Equatable {
  const AddReviewScreenState();

  @override
  List<Object> get props => [];
}

class AddReviewInitialState extends AddReviewScreenState{}

class AddReviewLoadingState extends AddReviewScreenState{}

class AddReviewSuccessState extends AddReviewScreenState{
  final BaseModel data;
  const AddReviewSuccessState(this.data);
}

class AddReviewErrorState extends AddReviewScreenState{
  final String message;
  const AddReviewErrorState(this.message);
}


