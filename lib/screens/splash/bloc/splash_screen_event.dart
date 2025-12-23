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

abstract class SplashScreenEvent extends Equatable{
  const SplashScreenEvent();

  @override
  List<Object> get props => [];
}

class SplashScreenDataFetchEvent extends SplashScreenEvent{

}
class WalkThroughFetchEvent extends SplashScreenEvent{
  const WalkThroughFetchEvent();
}