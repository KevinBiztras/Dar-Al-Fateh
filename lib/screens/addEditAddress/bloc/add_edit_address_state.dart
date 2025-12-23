/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */
import 'package:equatable/equatable.dart';import 'package:flutter_project_structure/models/AddressDetailModel.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/CountryListModel.dart';

abstract class AddEditAddressState extends Equatable {
  const AddEditAddressState();

  @override
  List<Object> get props => [];
}

class AddEditAddressInitial extends AddEditAddressState {}

class AddEditAddressCountrySuccess extends AddEditAddressState {
  final CountryListModel model;

  const AddEditAddressCountrySuccess(this.model);

  @override
  List<Object> get props => [];
}

class AddressDetailFetchSuccess extends AddEditAddressState {
  final AddressDetailModel model;

  const AddressDetailFetchSuccess(this.model);

  @override
  List<Object> get props => [];
}

class UpdateAddressSuccess extends AddEditAddressState {
  final BaseModel model;

  const UpdateAddressSuccess(this.model);

  @override
  List<Object> get props => [];
}

class AddAddressSuccess extends AddEditAddressState {
  final BaseModel model;

  const AddAddressSuccess(this.model);

  @override
  List<Object> get props => [];
}
class GuestAddAddressSuccess extends AddEditAddressState {
  final BaseModel model;

  const GuestAddAddressSuccess(this.model);

  @override
  List<Object> get props => [];
}

class AddEditAddressError extends AddEditAddressState {
  AddEditAddressError(this._message);

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
