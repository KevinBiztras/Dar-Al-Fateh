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
abstract class SearchEvent extends Equatable{
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchSuggestionEvent extends SearchEvent{
  final String searchKey;

  final int offset;
  const SearchSuggestionEvent(this.searchKey,  this.offset);

}

class BarCodeScannerEvent extends SearchEvent{
  final String barcode;
  final int offset;
  const BarCodeScannerEvent(this.barcode,  this.offset);
}

class InitialSearchSuggestionEvent extends SearchEvent{}

