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

import 'package:floor/floor.dart';

@entity
class RecentProduct {
  @primaryKey
  String? productId;
  String? name;
  String? image;
  String? price;

  RecentProduct({
    this.productId,
    this.image,
    this.name,
    this.price,
  });

  // factory RecentProduct.fromJson(Map<String, dynamic> json) {
  //   return RecentProduct(
  //     productId: json['productId'],
  //     name: json['name'],
  //     image: json['image'],
  //     price: json['price'],
  //   );
  // }

  @override
  String toString() {
    return "$productId\n$name\n$price";
  }
}
