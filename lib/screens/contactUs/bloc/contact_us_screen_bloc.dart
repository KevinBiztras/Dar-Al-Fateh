/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_project_structure/models/ContactUsModel.dart';
import 'package:flutter_project_structure/screens/contactUs/bloc/contactUs_repository/contact_us_repository_impl.dart';
import 'package:meta/meta.dart';

part 'contact_us_screen_event.dart';
part 'contact_us_screen_state.dart';

class ContactUsScreenBloc
    extends Bloc<ContactUsScreenEvent, ContactUsScreenState> {
  ContactUsRepositoryImpl? repository;

  ContactUsScreenBloc({required this.repository})
      : super(ContactUsInitialState()) {
    on<ContactUsScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      ContactUsScreenEvent event, Emitter<ContactUsScreenState> emit) async {
    if (event is ContactUsScreenEventInitial) {
      emit(ContactUsLoadingState());
      try {
        var model = await repository?.getContactUsDetails();
        if (model != null) {
          emit(ContactUsSuccessState(model));
        } else {
          emit(ContactUsErrorState(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(ContactUsErrorState(error.toString()));
      }
    }
  }
}
