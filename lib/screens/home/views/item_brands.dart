// /*
//  * *
//  *
//  *  Webkul Software.
//  *
//  *  @package Mobikul App
//  *
//  *  @Category Mobikul
//  *
//  *  @author Webkul <support@webkul.com>
//  *
//  *  @Copyright (c) Webkul Software Private Limited (https://webkul.com)
//  *
//  *  @license https://store.webkul.com/license.html ASL Licence
//  *
//  *  @link https://store.webkul.com/license.html
//  *
//  * /
//  */
//
// import 'package:flutter/cupertino.dart';
// /**
//
//  * Webkul Software.
//
//  * @package Mobikul App
//
//  * @Category Mobikul
//
//  * @author Webkul <support@webkul.com>
//
//  * @Copyright (c) Webkul Software Private Limited (https://webkul.com)
//
//  * @license https://store.webkul.com/license.html ASL Licence
//
//  * @link https://store.webkul.com/license.html
//
//  */
//
// import 'package:flutter/material.dart';
// import 'package:flutter_project_structure/constants/app_constants.dart';
//
// import '../../../helper/image_view.dart';
// import '../../../models/HomeScreenModel.dart';
//
// class BrandView extends StatelessWidget {
//   BannerImages brand;
//   BrandView(this.brand,{Key? key}) : super(key: key);
//   double imageSize = 0.0;
//   @override
//   Widget build(BuildContext context) {
//     imageSize = (AppSizes.width / 4);
//     return Card(
//       elevation: 1.0,
//       child: ImageView(
//         url:brand.url,
//         height: imageSize,
//         width: imageSize-3),
//     );
//   }
// }