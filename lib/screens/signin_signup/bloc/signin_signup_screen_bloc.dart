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

import 'dart:io';

import 'package:bloc/bloc.dart';
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
import 'package:flutter/cupertino.dart';import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/CountryListModel.dart';
import 'package:flutter_project_structure/models/LoginResponseModel.dart';
import 'package:flutter_project_structure/models/SignUpScreenModel.dart';
import 'package:flutter_project_structure/models/SignUpTermsModel.dart';
import 'package:flutter_project_structure/models/SocialLoginModel.dart';
import 'package:flutter_project_structure/screens/signin_signup/bloc/signin_signup_screen_repository.dart';

import '../../../constants/app_string_constant.dart';
import '../../../helper/app_localizations.dart';

// import '../../../marketplace/marketplaceModel/SignUpDetailsModel.dart';

part 'signin_signup_screen_event.dart';

part 'signin_signup_screen_state.dart';
class SigninSignupScreenBloc
    extends Bloc<SigninSignupScreenEvent, SigninSignupScreenState> {
  final SigninSignupScreenRepository? repository;
  final AppLocalizations _localizations; // ✅ Declare this

  SigninSignupScreenBloc({this.repository, required AppLocalizations localizations})
      : _localizations = localizations, // ✅ Proper initializer
        super(SignupScreenInitial()) {
    on<SigninSignupScreenEvent>(mapEventToState);
  }

  void mapEventToState(
    SigninSignupScreenEvent event,
    Emitter<SigninSignupScreenState> emit,
  ) async {
    if(event is SignUpInitialEvent){
      emit(LoadingState());
      try {
        var model =
        await repository?.getCountryList();
        if (model != null) {
          if (model.success ?? false) {
            emit(SignUpInitialDataState(model));
          } else {
            emit(SigninSignupScreenError(model.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    }
    else if (event is SignUpEvent) {
      try {
        var model =
        await repository?.signUp(event.email, event.password, event.name);
        if (model != null) {
          if (model.success ?? false) {
            emit(SignupScreenFormSuccess(model));
          } else {
            emit(SigninSignupScreenError(model.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    } else if (event is LoginEvent) {
      final connected = await _isConnected();
      if (!connected) {
        emit(SigninSignupScreenError(
            _localizations?.translate(AppStringConstant.noInternetConnection) ??
                "No Internet Connection"));

        return;
      }
      try {
        var model = await repository?.login(event.email, event.password);
        if (model != null) {
          if (model.success ?? false) {
            emit(LoginState(model));
          } else {
            emit(SigninSignupScreenError(model?.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    }else if (event is FingerprintLoginEvent) {
      try {
        var model = await repository?.fingerPrintLogin(event.loginKey);
        if (model != null) {
          if (model.success ?? false) {
            emit(FingerprintLoginState(model));
          } else {
            emit(SigninSignupScreenError(model.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    } else if (event is ForgotPasswordEvent) {
      try {
        var model = await repository?.forgotPassword(event.email);
        if (model != null) {
          if (model.success ?? false) {
            emit(ForgotPasswordState(model));
          } else {
            emit(SigninSignupScreenError(model.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    } else if (event is SocialLoginEvent) {
      emit(LoadingState());
      try {
        var model = await repository?.socialLogin(event.request);
        if (model != null) {
          if (model.success ?? false) {
            emit(SignupScreenFormSuccess(model));
          } else {
            emit(SigninSignupScreenError(model.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    }
    else if(event is SignUpTermsEvent){
      emit(LoadingState());
      try {
        var model = await repository?.getSignUpTerms();
        if (model != null) {
          if (model.success ?? false) {
            emit(SignUpTermSuccessState(model));
          } else {
            emit(SigninSignupScreenError(model.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    }
    else if(event is SellerSignUpTermsEvent){
      print('===================');
      emit(LoadingState());
      try {
        var model = await repository?.getSellerSignUpTerms();
        if (model != null) {
          if (model.success ?? false) {
            emit(SignUpTermSuccessState(model));
          } else {
            emit(SigninSignupScreenError(model.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    }else if (event is GetMergeCartEvent){
      var model = await repository?.getMergeCart();
      if (model?.success ?? false) {
       debugPrint("${model?.message}");
      }
    }
  }
  Future<bool> _isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
