/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */
import 'package:equatable/equatable.dart';import 'package:flutter_project_structure/models/SearchScreenModel.dart';

abstract class SearchState extends Equatable{
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitialState extends SearchState{}

class SearchScreenSuccess extends SearchState{
  final SearchScreenModel? searchSuggestionModel;

  const SearchScreenSuccess(this.searchSuggestionModel);
}
class BarCodeScannerSuccess extends SearchState{
  final SearchScreenModel? searchSuggestionModel;

  const BarCodeScannerSuccess(this.searchSuggestionModel);
}


class SearchEmptyState extends SearchState{
}

class SearchScreenError extends SearchState {
  const SearchScreenError(this.message);

 final String message;
}