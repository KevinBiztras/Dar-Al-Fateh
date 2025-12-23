


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

part of 'catalog_screen_bloc.dart';



abstract class CatalogScreenState extends Equatable{
  const CatalogScreenState();
  @override
  List<Object> get props => [];
}

class CatalogScreenInitialState extends CatalogScreenState{}

class CatalogScreenSuccessState extends CatalogScreenState{
  GetFilterAttribute? categoryScreenModel;
  CatalogScreenSuccessState(this.categoryScreenModel);
}

class CatalogDataFromNotificationSuccessState extends CatalogScreenState{
  GetFilterAttribute? categoryScreenModel;
  CatalogDataFromNotificationSuccessState(this.categoryScreenModel);
}


class CatalogScreenErrorState extends CatalogScreenState{
  CatalogScreenErrorState(this._message);

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

class CatalogScreenCompleteState extends CatalogScreenState{}


class FilterFetchState extends CatalogScreenState {
  GetFilterAttribute? filterModel;
  FilterFetchState(this.filterModel);

  @override
  // TODO: implement props
  List<Object> get props => [if (filterModel != null) filterModel! else ""];
}
