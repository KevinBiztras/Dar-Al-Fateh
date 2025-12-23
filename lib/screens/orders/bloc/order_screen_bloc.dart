

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

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/screens/orders/bloc/order_screen_events.dart';
import 'package:flutter_project_structure/screens/orders/bloc/order_screen_repository.dart';
import 'package:flutter_project_structure/screens/orders/bloc/order_screen_state.dart';

class OrderScreenBloc
extends Bloc<OrderScreenEvent, OrderScreenState> {
OrderScreenRepositoryImp? repository;

OrderScreenBloc({this.repository}) : super(OrderScreenInitial()) {
on<OrderScreenEvent>(mapEventToState);
}

void mapEventToState(
    OrderScreenEvent event, Emitter<OrderScreenState> emit) async {
  if (event is OrderScreenDataFetchEvent) {
    emit(OrderScreenInitial());
    try {
      var model = await repository?.getOrderList(event.offset, event.limit);
      if (model != null) {
        emit( OrderScreenSuccess(model));
      } else {
        emit(const OrderScreenError(''));
      }
    } catch (error, _) {
      print(error.toString());
      emit(OrderScreenError(error.toString()));
    }
  } else if(event is OrderDetailsFetchEvent){
    emit(OrderScreenInitial());
    try {
      var model = await repository?.getOrderDetails(event.url);
      if (model != null) {
        emit( OrderDetailsSuccess(model));
      } else {
        emit(const OrderScreenError(''));
      }
    } catch (error, _) {
      print(error.toString());
      emit(OrderScreenError(error.toString()));
    }
  }else if(event is ReorderEvent){
    try {
      var model = await repository?.reOrderData(event.id,event.needCartMerge);
      if (model != null) {
        emit( ReorderStateSuccess(model));
      } else {
        emit(const OrderScreenError(''));
      }
    } catch (error, _) {
      print(error.toString());
      emit(OrderScreenError(error.toString()));
    }
  }
}
}
