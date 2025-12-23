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
import 'package:flutter_project_structure/screens/product/bloc/product_screen_repository.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_state.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_event.dart';

import '../../../local_database/hive_constants.dart';
import '../../../local_database/hive_service.dart';
import '../../../models/ProductScreenModel.dart';

class ProductScreenBloc extends Bloc<ProductScreenEvent, ProductScreenState> {
  ProductScreenRepositoryImp? repository;

  ProductScreenBloc({this.repository}) : super(ProductScreenInitial()) {
    on<ProductScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      ProductScreenEvent event, Emitter<ProductScreenState> emit) async {
    if (event is ProductScreenDataFetchEvent) {
      try {
        ProductScreenModel? cacheModel = await getProductDataFromHiveDB(event.productId ?? "");
        if (cacheModel != null) {
          emit(ProductScreenSuccessCache(cacheModel));
        }

        ProductScreenModel? model = await repository?.getProductData(event.productId ?? '');
        if (model != null) {
          emit(ProductScreenSuccess(model));
        } else {
          emit(ProductScreenError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(ProductScreenError(error.toString()));
      }
    } else if (event is QuantityUpdateEvent) {
      try {
        emit(QuantityUpdateState(event.qty!));
      } catch (error, _) {
        print(error.toString());
        emit(ProductScreenError(error.toString()));
      }
    } else if (event is AddToWishlistEvent) {
      try {
        var model = await repository?.addToWishlist(event.productId, event.productName);
        emit(AddToWishlistState(model));
      } catch (error, _) {
        print(error.toString());
        emit(ProductScreenError(error.toString()));
      }
    }else if(event is RemoveFromWishlistEvent){
      try {
        var model = await repository?.removeFromWishlist(event.productId.toString());
        emit(RemoveFromWishlist(model));
      } catch (error, _) {
        print(error.toString());
        emit(ProductScreenError(error.toString()));
      }
    }else if(event is AddtoCartEvent){
      try {
        var model = await repository?.addTocart(event.productId, event.addQty);
        emit(AddtoCartState(model));
      } catch (error, _) {
        print(error.toString());
        emit(ProductScreenError(error.toString()));
      }
    }else if(event is BuyNowEvent){
      try {
        var model = await repository?.addTocart(event.productId, event.addQty);
        emit(BuyNowState(model));
      } catch (error, _) {
        print(error.toString());
        emit(ProductScreenError(error.toString()));
      }
    }else if(event is AddReviewEvent) {
      try {
        var model = await repository?.addReview(event.rating, event.title, event.detail, event.templateId);
        emit(AddReview(model));
      } catch (error, _) {
        print(error.toString());
        emit(ProductScreenError(error.toString()));
      }
    }
    else if(event is ProductScreenLoadingEvent){
      emit(ProductScreenInitial());
    }
  }

}

Future<ProductScreenModel?> getProductDataFromHiveDB(String productId) async {
  ProductScreenModel? model;


  final HiveService hiveService = HiveService();
  String hiveBoxName = HiveConstants.getProductDataBoxName(productId);

  bool isCacheAvailable = await hiveService.isExists(boxName: hiveBoxName);

  if (isCacheAvailable) {
    model = await hiveService.getProductPageBox(hiveBoxName);
  }

  return model;
}