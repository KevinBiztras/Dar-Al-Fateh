/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */




// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
//
// import '../../../constants/app_constants.dart';
// import '../../../constants/app_string_constant.dart';
// import '../../../constants/route_constant.dart';
// import '../../../helper/app_localizations.dart';
//
// Widget emptyWishlistView(AppLocalizations? _localizations, BuildContext context) {
//   return Center(
//     child: Container(
//       height: AppSizes.height / 2,
//       width: AppSizes.width - 50,
//       decoration: BoxDecoration(
//         border: Border.all(width: 1.0, color: AppColors.background),
//       ),
//       child: Column(children: [
//         Lottie.asset("lib/assets/lottie/empty_wishlist.json",
//             width: AppSizes.width / 2,
//             height: AppSizes.height / 3.5,
//             fit: BoxFit.fill,
//             repeat: false
//         ),
//         Text(_localizations?.translate(AppStringConstant.noItems) ?? "",
//             style: Theme.of(context).textTheme.displaySmall),
//         const Padding(padding: EdgeInsets.all(AppSizes.linePadding)),
//         Text(
//           _localizations?.translate(AppStringConstant.noItemsInWishlist) ?? "",
//           style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.normal),
//         ),
//         const Padding(padding: EdgeInsets.all(AppSizes.imageRadius)),
//         ElevatedButton(
//             onPressed: () {
//               Navigator.of(context)
//                   .pushNamedAndRemoveUntil(navBar, (route) => false,arguments: 0);
//             },
//             style: ElevatedButton.styleFrom(primary: AppColors.black),
//             child: Text(
//               _localizations?.translate(AppStringConstant.continueShopping) ??
//                   "",
//               style: const TextStyle(color: AppColors.white),
//             ))
//       ]),
//     ),
//   );
// }
