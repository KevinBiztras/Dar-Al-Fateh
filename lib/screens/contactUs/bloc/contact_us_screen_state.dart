/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */
part of 'contact_us_screen_bloc.dart';

@immutable
abstract class ContactUsScreenState {}

class ContactUsInitialState extends ContactUsScreenState {}
class ContactUsLoadingState extends ContactUsScreenState {}


class ContactUsSuccessState extends ContactUsScreenState {
  final ContactUsModel? model;

  ContactUsSuccessState(this.model);
}

class ContactUsErrorState extends ContactUsScreenState {
  final String? message;

  ContactUsErrorState(this.message);
}
