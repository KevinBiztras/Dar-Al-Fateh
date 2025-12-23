
/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */
import 'package:floor/floor.dart';


@entity
class RecentProduct {
  @primaryKey
  String? templateId;
  String? name;
  String? image;
  String? priceUnit;
  String? priceReduce;
  int? productId;
  int? productCount;
  String? ribbonMessage;
  String? position;
  String? textColor;
  String? bgColor;


  RecentProduct({
    this.templateId,
    this.image,
    this.name,
    this.priceUnit,
    this.priceReduce,
    this.productId,
    this.productCount,
    this.ribbonMessage,
    this.position,
    this.textColor,
    this.bgColor,
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
    return "$templateId\n$name\n$priceUnit";
  }
}
