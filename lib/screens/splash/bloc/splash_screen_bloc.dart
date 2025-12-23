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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/models/SplashScreenModel.dart';
import 'package:flutter_project_structure/screens/splash/bloc/splash_screen_repository.dart';

import '../../../models/walkThroughModel.dart';


part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent,SplashScreenState>{
  SplashScreenRepository? splashScreenRepository;

  SplashScreenBloc({this.splashScreenRepository}) : super(SplashScreenInitial()){
    on<SplashScreenEvent>(mapEventToState);
  }

  @override
  void mapEventToState(
      SplashScreenEvent event, Emitter<SplashScreenState> emit) async {
    if (event is SplashScreenDataFetchEvent) {
      try {
        var model = await splashScreenRepository?.getSplashData();
        if (model != null) {
          emit( SplashScreenSuccess(model));
        } else {
          emit(SplashScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(SplashScreenError(error.toString()));
      }
    }
    if (event is WalkThroughFetchEvent) {
      emit(SplashScreenInitial());
      try {
        var model = await splashScreenRepository?.getWalkThroughData();
        if (model != null) {
          emit(WalkThroughSuccess(model));
        } else {
          emit(const WalkThroughError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(WalkThroughError(error.toString()));
      }
    }
  }



}