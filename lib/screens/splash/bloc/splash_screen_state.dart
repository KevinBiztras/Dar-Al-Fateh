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

part of 'splash_screen_bloc.dart';


abstract class SplashScreenState extends Equatable{
  const SplashScreenState();

  @override
  List<Object> get props => [];
}

class SplashScreenInitial extends SplashScreenState{

}

class SplashScreenSuccess extends SplashScreenState{
  SplashScreenModel? splashScreenModel;
  SplashScreenSuccess(this.splashScreenModel);

  @override
  List<Object> get props => [];
}

class SplashScreenError extends SplashScreenState {
  SplashScreenError(this._message);

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
class WalkThroughSuccess extends SplashScreenState{
  final WalkThroughModel model;
  const WalkThroughSuccess(this.model);
}

class WalkThroughError extends SplashScreenState{
  final String message;
  const WalkThroughError(this.message);
}