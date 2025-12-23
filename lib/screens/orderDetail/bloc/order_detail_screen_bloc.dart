/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */
import 'package:equatable/equatable.dart';import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/BaseModel.dart';
import '../../../models/OrderDetailModel.dart';
import 'order_detail_screen_repository.dart';

part 'order_detail_event.dart';

part 'order_detail_screen_state.dart';

class OrderDetailsBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  OrderDetailRepository? repository;

  OrderDetailsBloc({this.repository}) : super(OrderDetailInitial()) {
    on<OrderDetailEvent>(mapEventToState);
  }

  @override
  void mapEventToState(
      OrderDetailEvent event, Emitter<OrderDetailState> emit) async {
    if (event is OrderDetailFetchEvent) {
      try {
        var model = await repository?.getOrderDetails(event.orderEndpoint);
        if (model != null) {
          emit(OrderDetailSuccess(model));
        } else {
          emit(OrderDetailError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(OrderDetailError(error.toString()));
      }
    }else if(event is OrderDetailReorderEvent){
      try {
        var model = await repository?.reOrderData(event.id,event.needCartMerge);
        if (model != null) {
          emit( ReorderDetailsStateSuccess(model));
        } else {
          emit( OrderDetailError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(OrderDetailError(error.toString()));
      }
    }
  }
}
