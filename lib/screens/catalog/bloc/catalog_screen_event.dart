
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

abstract class CatalogScreenEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class CatalogScreenDataFetchEvent extends CatalogScreenEvent{
  CatalogScreenDataFetchEvent(this.categoryId,this.limit,this.offset,this.order);

  final int categoryId;
  final int limit;
  final int offset;
  final String order;

  @override
  List<Object> get props => [];
}

class CatalogScreenDataFetchFromHomeEvent extends CatalogScreenEvent{
  CatalogScreenDataFetchFromHomeEvent(this.url,this.limit,this.offset);
 final String url;
  final int limit;
  final int offset;

  @override
  List<Object> get props => [];
}

class CatalogScreenDataFetchFromNotificationEvent extends CatalogScreenEvent{
  CatalogScreenDataFetchFromNotificationEvent(this.limit,this.domain);
  final int limit;
  final String domain;

  @override
  List<Object> get props => [];
}

class FilterFetchDataEvent extends CatalogScreenEvent {

  FilterFetchDataEvent(this.data);

  final Map<String,dynamic >  data;


  @override
  // TODO: implement props
  List<Object> get props => [];
}

// class SellerCatalogDataFetchEvent extends CatalogScreenEvent{
//   final CatalogArgumentModel data;
//   SellerCatalogDataFetchEvent(this.data);
// }

