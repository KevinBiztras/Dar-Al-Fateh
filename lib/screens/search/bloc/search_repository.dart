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

import 'dart:convert';

import 'package:flutter_project_structure/models/SearchScreenModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

abstract class SearchRepository {
  Future<SearchScreenModel> getSearchSuggestion(String text, int offset);

  Future<SearchScreenModel> getBarCodeData(String barcode, int offset);
}

class SearchRepositoryImp implements SearchRepository {
  @override
  Future<SearchScreenModel> getSearchSuggestion(String text, int offset) async {
    SearchScreenModel? model;
    Map<String, dynamic> data = {};
    data["offset"] = offset;
    data['limit'] = text.trim() != "" ? 10 : 5;
    data["search"] = text;
    String body = json.encode(data);
    model = await ApiClient().getSearchList(body);
    return model;
  }

  @override
  Future<SearchScreenModel> getBarCodeData(String barcode, int offset) async {
    SearchScreenModel? model;
    Map<String, dynamic> data = {};
    data["offset"] = offset;
    data['limit'] = 10;
    data["barcode"] = barcode;
    String body = json.encode(data);
    model = await ApiClient().getSearchList(body);
    return model;
  }
}
