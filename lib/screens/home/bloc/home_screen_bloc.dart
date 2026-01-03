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
import 'package:flutter_project_structure/models/HomeScreenModel.dart';
import 'package:flutter_project_structure/screens/home/bloc/home_screen_repository.dart';
import '../../../constants/app_constants.dart';
import '../../../local_database/hive_constants.dart';
import '../../../local_database/hive_service.dart';

part 'home_screen_event.dart';

part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenRepository? repository;

  HomeScreenBloc({this.repository}) : super(HomeScreenInitial()) {
    on<HomeScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      HomeScreenEvent event, Emitter<HomeScreenState> emit) async {
    if (event is HomeScreenDataFetchEvent) {
      emit(HomeScreenInitial());
      try {
        HomePageData? cacheModel = await getHomeDataFromHiveDB();
        if (cacheModel != null) {
          emit(HomeScreenSuccessCache(cacheModel));
        }
        var model = await repository?.getHomeData(event.offset);
        if (model != null) {
          emit( HomeScreenSuccess(model));
        } else {
          emit(HomeScreenError(''));
        }
      } catch (error, str) {
        print(error.toString());
        print(str.toString());
        emit(HomeScreenError(error.toString()));
      }
    }
  }
}
Future<HomePageData?> getHomeDataFromHiveDB() async {
  if (ApiConstant.baseUrl.contains('example.com')) {
    return null;
  }
  HomePageData? model;

  final HiveService hiveService = HiveService();
  String hiveBoxName = HiveConstants.getHomePageModelBoxName();

  bool isCacheAvailable = await hiveService.isExists(boxName: hiveBoxName);
  if (isCacheAvailable) {
    model = await hiveService.getHomeDataBox(hiveBoxName);
  }

  return model;
}
