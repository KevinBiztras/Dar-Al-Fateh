/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */
import 'package:equatable/equatable.dart';abstract class AddReviewEvent extends Equatable{
  const AddReviewEvent();
  @override
  List<Object> get props => [];
}


class AddReviewSaveEvent extends AddReviewEvent{
  final int rating;
  final String title;
  final String detail;
  final int templateId;

  const AddReviewSaveEvent(this.rating,this.title,this.detail,this.templateId);
}