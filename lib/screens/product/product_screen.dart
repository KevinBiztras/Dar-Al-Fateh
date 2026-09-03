// // ignore_for_file: must_be_immutable, prefer_const_constructors
// import 'dart:io';

// /**

//  * Webkul Software.

//  * @package Mobikul App

//  * @Category Mobikul

//  * @author Webkul <support@webkul.com>

//  * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

//  * @license https://store.webkul.com/license.html ASL Licence

//  * @link https://store.webkul.com/license.html

//  */

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_project_structure/constants/app_constants.dart';
// import 'package:flutter_project_structure/constants/app_string_constant.dart';
// import 'package:flutter_project_structure/constants/route_constant.dart';
// import 'package:flutter_project_structure/customWidgtes/badge_icon.dart';
// import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
// import 'package:flutter_project_structure/helper/alert_message.dart';
// import 'package:flutter_project_structure/helper/app_localizations.dart';
// import 'package:flutter_project_structure/helper/loader.dart';
// import 'package:flutter_project_structure/models/BaseModel.dart';
// import 'package:flutter_project_structure/models/ProductScreenModel.dart';
// import 'package:flutter_project_structure/screens/product/bloc/product_screen_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_project_structure/screens/product/bloc/product_screen_event.dart';
// import 'package:flutter_project_structure/screens/product/bloc/product_screen_state.dart';
// import 'package:flutter_project_structure/screens/product/views/add_to_cart_button.dart';
// import 'package:flutter_project_structure/screens/product/views/alternate_products.dart';
// import 'package:flutter_project_structure/screens/product/views/product_basic_details.dart';
// import 'package:flutter_project_structure/screens/product/views/product_details.dart';
// import 'package:flutter_project_structure/screens/product/views/product_images.dart';
// import 'package:flutter_project_structure/screens/product/views/product_variants.dart';
// import 'package:flutter_project_structure/screens/product/views/quantity_view.dart';
// import '../../constants/arguments_map.dart';
// import '../../models/HomeScreenModel.dart';
// import '../../helper/app_shared_pref.dart';
// import '../../utils/helper.dart';

// class ProductScreen extends StatefulWidget {
//   Map<String, dynamic> arguments;

//   ProductScreen(this.arguments, {super.key});

//   @override
//   _ProductScreenState createState() => _ProductScreenState();
// }

// class _ProductScreenState extends State<ProductScreen> {
//   final ScrollController _scrollController = ScrollController();
//   ProductScreenBloc? productPageBloc;
//   ProductScreenModel? productPageData;
//   AppLocalizations? _localizations;
//   bool isLoading = false;
//   int? counter = 1;
//   bool? addedToWishlist = false;
//   BaseModel? baseModel;
//   Products? _passedProduct;

//   @override
//   void initState() {
//     productPageBloc = context.read<ProductScreenBloc>();
//     _passedProduct = widget.arguments[productDataKey] as Products?;

//     if (_passedProduct != null) {
//       // Seed local product details without hitting backend
//       productPageData = ProductScreenModel.fromJson({
//         "success": true,
//         "templateId":
//             _passedProduct?.templateId ?? _passedProduct?.productId ?? 0,
//         "name": _passedProduct?.name ?? "",
//         "images": [_passedProduct?.thumbNail ?? ""],
//         "thumbNail": _passedProduct?.thumbNail ?? "",
//         "priceUnit": _passedProduct?.priceUnit ?? "",
//         "priceReduce": _passedProduct?.priceReduce ?? "",
//         "productId": _passedProduct?.productId ?? 0,
//         "productCount": _passedProduct?.productCount ?? 1,
//         "add_to_cart": true,
//         "addedToWishlist": false,
//         "description": _passedProduct?.description ?? "",
//         "attributes": [],
//         "variants": [],
//         "combinations": [],
//         "total_review": 0,
//         "avg_rating": 0.0,
//       });
//     } else {
//       productPageBloc?.add(
//         ProductScreenDataFetchEvent(widget.arguments[productIdKey]),
//       );
//     }
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _localizations = AppLocalizations.of(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductScreenBloc, ProductScreenState>(
//       builder: (context, currentState) {
//         if (_passedProduct != null && productPageData != null) {
//           isLoading = false;
//           addedToWishlist = productPageData?.addedToWishlist ?? false;
//           return _buildUI();
//         }
//         if (currentState is ProductScreenInitial) {
//           isLoading = true;
//         } else if (currentState is ProductScreenSuccess ||
//             currentState is ProductScreenSuccessCache) {
//           if (currentState is ProductScreenSuccessCache) {
//             productPageData = currentState.productPageData;
//           } else if (currentState is ProductScreenSuccess) {
//             productPageData = currentState.productPageData;
//           }
//           isLoading = false;
//           addedToWishlist = productPageData?.addedToWishlist ?? false;
//         } else if (currentState is ProductScreenError) {
//           isLoading = false;
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             AlertMessage.showError(currentState.message ?? '', context);
//           });
//         } else if (currentState is QuantityUpdateState) {
//           isLoading = false;
//           counter = currentState.qty;
//         } else if (currentState is AddToWishlistState) {
//           isLoading = false;
//           baseModel = currentState.baseModel;
//           if (currentState.baseModel?.success ?? false) {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               AlertMessage.showSuccess(
//                 currentState.baseModel?.message ?? '',
//                 context,
//               );
//             });
//             addedToWishlist = true;
//           } else {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               AlertMessage.showError(
//                 currentState.baseModel?.message ?? '',
//                 context,
//               );
//             });
//           }
//         } else if (currentState is RemoveFromWishlist) {
//           isLoading = false;
//           baseModel = currentState.baseModel;
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             AlertMessage.showSuccess(
//               currentState.baseModel?.message ?? '',
//               context,
//             );
//           });
//           addedToWishlist = false;
//         } else if (currentState is AddtoCartState) {
//           isLoading = false;
//           AppSharedPref().setGuestCartCount(currentState.model?.cartCount ?? 0);

//           baseModel = currentState.model;
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             if (currentState.model?.success ?? false) {
//               AlertMessage.showSuccess(
//                 currentState.model?.message ?? '',
//                 context,
//               );
//             } else {
//               AlertMessage.showError(
//                 currentState.model?.message ?? '',
//                 context,
//               );
//             }
//           });
//         } else if (currentState is BuyNowState) {
//           isLoading = false;
//           AppSharedPref().setGuestCartCount(currentState.model?.cartCount ?? 0);
//           baseModel = currentState.model;
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             Navigator.pushNamed(context, cart);
//           });
//         } else if (currentState is AddReview) {
//           isLoading = false;
//           baseModel = currentState.baseModel;
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             AlertMessage.showSuccess(
//               currentState.baseModel?.message ?? '',
//               context,
//             );
//           });
//         }
//         return _buildUI();
//       },
//     );
//   }

//   Widget _buildUI() {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context, true);
//           },
//           icon: Icon(Icons.arrow_back_outlined),
//         ),
//         title: Text(
//           // productPageData?.name ?? widget.arguments[productNameKey] ??
//            "Product details",
//           // style: Theme.of(context).textTheme.displaySmall,
//           overflow: TextOverflow.ellipsis,
//         ),
//         actions: [
//           if (AppSharedPref().getIfLogin() ?? false)
//             IconButton(
//               onPressed: () {
//                 // startArActivity();
//                 Navigator.pushNamed(context, wishlist).then((value) {
//                   productPageBloc?.add(ProductScreenLoadingEvent());
//                   productPageBloc?.add(
//                     ProductScreenDataFetchEvent(widget.arguments[productIdKey]),
//                   );
//                 });
//               },
//               icon: Icon(
//                 Icons.favorite_outline,
//                 // color: Theme.of(context).iconTheme.color,
//               ),
//             ),
//           IconButton(
//             onPressed: () {
//               if ((AppSharedPref().getIfLogin() != null &&
//                       AppSharedPref().getIfLogin() == true) ||
//                   AppSharedPref().getGuestCheckout()) {
//                 Navigator.pushNamed(context, cart);
//               } else {
//                 DialogHelper.confirmationDialog(
//                   "${_localizations?.translate(AppStringConstant.signInToContinue)}",
//                   context,
//                   _localizations,
//                   onConfirm: () async {
//                     Navigator.pushNamed(context, loginSignup, arguments: false);
//                   },
//                 );
//               }
//             },
//             icon: Semantics(
//               identifier: 'product-cart',
//               child: BadgeIcon(icon: Icon(Icons.shopping_cart)),
//             ),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           Visibility(
//             visible: (productPageData?.success ?? false),
//             child: SingleChildScrollView(
//               controller: _scrollController,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     color: Theme.of(context).cardColor,
//                     child: Column(
//                       children: [
//                         Stack(
//                           children: [

//                             Padding(
//                               padding: const EdgeInsets.only(left: 26),
//                               child: ProductImages(productPageData?.images ?? []),
//                             ),
//                             // if (getArStatus())
//                             //   InkWell(
//                             //     child: Icon(
//                             //       Icons.border_clear_rounded,
//                             //       size: 20,
//                             //     ),
//                             //     onTap: () => startArActivity(),
//                             //   ),
//                           ],
//                         ),
//                         ProductPageBasicDetailsView(
//                           addedToWishlist!,
//                           productPageBloc,
//                           product: productPageData,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: AppSizes.normalPadding),
//                   if ((productPageData?.variants ?? []).isNotEmpty)
//                     ProductVariants(productPageData, productPageBloc),
//                   SizedBox(height: AppSizes.normalPadding),
//                   QuantityView(bloc: productPageBloc, counter: counter),
//                   // SizedBox(height: AppSizes.linePadding),
//                   AddToCartButtonView(
//                     productPageBloc,
//                     productPageData?.productId ?? 0,
//                     productPageData?.name ?? '',
//                     counter!,
//                   ),

//                   Visibility(
//                     visible:
//                         productPageData?.description != "" &&
//                         productPageData?.description != null,
//                     child: ProductDetailsView(productPageData?.description),
//                   ),
//                   Visibility(
//                     visible:
//                         (productPageData?.attributes != null &&
//                         (productPageData?.attributes?.isNotEmpty ?? false)),
//                     child: Container(
//                       color: Theme.of(context).cardColor,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: AppSizes.mediumPadding),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 8.0,
//                             ),
//                             child: Text(
//                               _localizations?.translate(
//                                     AppStringConstant.specifications,
//                                   ) ??
//                                   '',
//                               style: Theme.of(context).textTheme.titleSmall,
//                               textAlign: TextAlign.start,
//                             ),
//                           ),
//                           SizedBox(height: AppSizes.normalPadding),
//                           ListView.separated(
//                             padding: EdgeInsets.zero,
//                             shrinkWrap: true,
//                             itemCount: productPageData?.attributes?.length ?? 0,
//                             physics: NeverScrollableScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               var attribute =
//                                   productPageData?.attributes?[index];
//                               return Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 8.0,
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       attribute?.name ?? "",
//                                       style: Theme.of(
//                                         context,
//                                       ).textTheme.bodyMedium,
//                                     ),
//                                     SizedBox(width: AppSizes.mediumPadding),
//                                     Text(
//                                       attribute?.values
//                                               ?.map((v) => v.name)
//                                               .join(", ") ??
//                                           "",
//                                       style: Theme.of(
//                                         context,
//                                       ).textTheme.bodySmall,
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                             separatorBuilder:
//                                 (BuildContext context, int index) {
//                                   return SizedBox(height: 4);
//                                 },
//                           ),
//                           SizedBox(height: AppSizes.normalPadding),

//                           Divider(thickness: 1),
//                         ],
//                       ),
//                     ),
//                   ),

//                   if ((AppSharedPref().getSplashData()?.addons?.review ??
//                           false) &&
//                       (productPageData?.totalReview ?? 0) > 0)
//                     reviewTile(),
//                   if (AppSharedPref().getSplashData()?.isCrossSelling ?? false)
//                     AlternateProductsList(productPageData?.alternativeProducts),
//                   SizedBox(height: AppSizes.normalPadding),
//                 ],
//               ),
//             ),
//           ),
//           Visibility(visible: isLoading, child: Loader()),
//         ],
//       ),
//     );
//   }

//   Widget reviewTile() {
//     return InkWell(
//       onTap: () => Navigator.of(context)
//           .pushNamed(
//             reviewList,
//             arguments: getReviewDataMap(
//               productPageData?.name ?? "",
//               productPageData?.thumbNail ?? "",
//               productPageData?.templateId ?? 0,
//             ),
//           )
//           .then((value) {
//             productPageBloc?.emit(ProductScreenInitial());
//             productPageBloc?.add(
//               ProductScreenDataFetchEvent(widget.arguments[productIdKey]),
//             );
//           }),
//       child: Container(
//         color: Theme.of(context).cardColor,
//         padding: EdgeInsets.symmetric(
//           vertical: AppSizes.sidePadding,
//           horizontal: AppSizes.imageRadius,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               " ${_localizations?.translate(AppStringConstant.reviews)} (${productPageData?.totalReview})",
//               style: Theme.of(context).textTheme.displaySmall,
//             ),
//             const Icon(Icons.arrow_forward_ios),
//           ],
//         ),
//       ),
//     );
//   }

//   var methodChannel = const MethodChannel(AppConstant.channelName);

//   Future startArActivity() async {
//     if (Platform.isIOS) {
//       Helper().downloadPersonalData(context, productPageData?.arIos ?? "");
//     }
//     try {
//       var data = await methodChannel.invokeMethod("showAr", {
//         "name": productPageData?.name,
//         "url": productPageData?.arAndroid,
//       });
//       return data;
//     } on PlatformException catch (e) {
//       return "Failed to Invoke: '${e.message}'.";
//     }
//   }

//   bool getArStatus() {
//     if (Platform.isAndroid && (productPageData?.arAndroid ?? "").isNotEmpty) {
//       return true;
//     } else if (Platform.isIOS && (productPageData?.arIos ?? "").isNotEmpty) {
//       return true;
//     }
//     return false;
//   }
// }

// ignore_for_file: must_be_immutable, prefer_const_constructors

// /**
//  * Webkul Software.
//  * @package Mobikul App
//  * @Category Mobikul
//  * @author Webkul <support@webkul.com>
//  * @Copyright (c) Webkul Software Private Limited (https://webkul.com)
//  * @license https://store.webkul.com/license.html ASL Licence
//  * @link https://store.webkul.com/license.html
//  */
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_project_structure/constants/app_constants.dart';
// import 'package:flutter_project_structure/constants/app_string_constant.dart';
// import 'package:flutter_project_structure/constants/route_constant.dart';
// import 'package:flutter_project_structure/customWidgtes/badge_icon.dart';
// import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
// import 'package:flutter_project_structure/helper/alert_message.dart';
// import 'package:flutter_project_structure/helper/app_localizations.dart';
// import 'package:flutter_project_structure/helper/loader.dart';
// import 'package:flutter_project_structure/models/BaseModel.dart';
// import 'package:flutter_project_structure/models/ProductScreenModel.dart';
// import 'package:flutter_project_structure/screens/product/bloc/product_screen_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_project_structure/screens/product/bloc/product_screen_event.dart';
// import 'package:flutter_project_structure/screens/product/bloc/product_screen_state.dart';
// import 'package:flutter_project_structure/screens/product/views/add_to_cart_button.dart';
// import 'package:flutter_project_structure/screens/product/views/alternate_products.dart';
// import 'package:flutter_project_structure/screens/product/views/product_basic_details.dart';
// import 'package:flutter_project_structure/screens/product/views/product_details.dart';
// import 'package:flutter_project_structure/screens/product/views/product_images.dart';
// import 'package:flutter_project_structure/screens/product/views/product_variants.dart';
// import 'package:flutter_project_structure/screens/product/views/quantity_view.dart';
// import '../../constants/arguments_map.dart';
// import '../../models/HomeScreenModel.dart';
// import '../../helper/app_shared_pref.dart';
// import '../../utils/helper.dart';

// class ProductScreen extends StatefulWidget {
//   Map<String, dynamic> arguments;

//   ProductScreen(this.arguments, {super.key});

//   @override
//   _ProductScreenState createState() => _ProductScreenState();
// }

// class _ProductScreenState extends State<ProductScreen> {
//   final ScrollController _scrollController = ScrollController();
//   ProductScreenBloc? productPageBloc;
//   ProductScreenModel? productPageData;
//   AppLocalizations? _localizations;
//   bool isLoading = false;
//   int? counter = 1;
//   bool? addedToWishlist = false;
//   BaseModel? baseModel;
//   Products? _passedProduct;

//   @override
//   void initState() {
//     productPageBloc = context.read<ProductScreenBloc>();
//     _passedProduct = widget.arguments[productDataKey] as Products?;

//     if (_passedProduct != null) {
//       // Seed local product details without hitting backend
//       productPageData = ProductScreenModel.fromJson({
//         "success": true,
//         "templateId":
//             _passedProduct?.templateId ?? _passedProduct?.productId ?? 0,
//         "name": _passedProduct?.name ?? "",
//         "images": [_passedProduct?.thumbNail ?? ""],
//         "thumbNail": _passedProduct?.thumbNail ?? "",
//         "priceUnit": _passedProduct?.priceUnit ?? "",
//         "priceReduce": _passedProduct?.priceReduce ?? "",
//         "productId": _passedProduct?.productId ?? 0,
//         "productCount": _passedProduct?.productCount ?? 1,
//         "add_to_cart": true,
//         "addedToWishlist": false,
//         "description": _passedProduct?.description ?? "",
//         "attributes": [],
//         "variants": [],
//         "combinations": [],
//         "total_review": 0,
//         "avg_rating": 0.0,
//       });
//     } else {
//       productPageBloc?.add(
//         ProductScreenDataFetchEvent(widget.arguments[productIdKey]),
//       );
//     }
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _localizations = AppLocalizations.of(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductScreenBloc, ProductScreenState>(
//       builder: (context, currentState) {
//         if (_passedProduct != null && productPageData != null) {
//           isLoading = false;
//           addedToWishlist = productPageData?.addedToWishlist ?? false;
//           return _buildUI();
//         }
//         if (currentState is ProductScreenInitial) {
//           isLoading = true;
//         } else if (currentState is ProductScreenSuccess ||
//             currentState is ProductScreenSuccessCache) {
//           if (currentState is ProductScreenSuccessCache) {
//             productPageData = currentState.productPageData;
//           } else if (currentState is ProductScreenSuccess) {
//             productPageData = currentState.productPageData;
//           }
//           isLoading = false;
//           addedToWishlist = productPageData?.addedToWishlist ?? false;
//         } else if (currentState is ProductScreenError) {
//           isLoading = false;
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             AlertMessage.showError(currentState.message ?? '', context);
//           });
//         } else if (currentState is QuantityUpdateState) {
//           isLoading = false;
//           counter = currentState.qty;
//         } else if (currentState is AddToWishlistState) {
//           isLoading = false;
//           baseModel = currentState.baseModel;
//           if (currentState.baseModel?.success ?? false) {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               AlertMessage.showSuccess(
//                 currentState.baseModel?.message ?? '',
//                 context,
//               );
//             });
//             addedToWishlist = true;
//           } else {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               AlertMessage.showError(
//                 currentState.baseModel?.message ?? '',
//                 context,
//               );
//             });
//           }
//         } else if (currentState is RemoveFromWishlist) {
//           isLoading = false;
//           baseModel = currentState.baseModel;
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             AlertMessage.showSuccess(
//               currentState.baseModel?.message ?? '',
//               context,
//             );
//           });
//           addedToWishlist = false;
//         } else if (currentState is AddtoCartState) {
//           isLoading = false;
//           AppSharedPref().setGuestCartCount(currentState.model?.cartCount ?? 0);

//           baseModel = currentState.model;
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             if (currentState.model?.success ?? false) {
//               AlertMessage.showSuccess(
//                 currentState.model?.message ?? '',
//                 context,
//               );
//             } else {
//               AlertMessage.showError(
//                 currentState.model?.message ?? '',
//                 context,
//               );
//             }
//           });
//         } else if (currentState is BuyNowState) {
//           isLoading = false;
//           AppSharedPref().setGuestCartCount(currentState.model?.cartCount ?? 0);
//           baseModel = currentState.model;
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             Navigator.pushNamed(context, cart);
//           });
//         } else if (currentState is AddReview) {
//           isLoading = false;
//           baseModel = currentState.baseModel;
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             AlertMessage.showSuccess(
//               currentState.baseModel?.message ?? '',
//               context,
//             );
//           });
//         }
//         return _buildUI();
//       },
//     );
//   }

//   Widget _buildUI() {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context, true);
//           },
//           icon: Icon(Icons.arrow_back_outlined),
//         ),
//         title: Text("Product details", overflow: TextOverflow.ellipsis),
//         actions: [
//           if (AppSharedPref().getIfLogin() ?? false)
//             IconButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, wishlist).then((value) {
//                   productPageBloc?.add(ProductScreenLoadingEvent());
//                   productPageBloc?.add(
//                     ProductScreenDataFetchEvent(widget.arguments[productIdKey]),
//                   );
//                 });
//               },
//               icon: Icon(Icons.favorite_outline),
//             ),
//           IconButton(
//             onPressed: () {
//               if ((AppSharedPref().getIfLogin() != null &&
//                       AppSharedPref().getIfLogin() == true) ||
//                   AppSharedPref().getGuestCheckout()) {
//                 Navigator.pushNamed(context, cart);
//               } else {
//                 DialogHelper.confirmationDialog(
//                   "${_localizations?.translate(AppStringConstant.signInToContinue)}",
//                   context,
//                   _localizations,
//                   onConfirm: () async {
//                     Navigator.pushNamed(context, loginSignup, arguments: false);
//                   },
//                 );
//               }
//             },
//             icon: Semantics(
//               identifier: 'product-cart',
//               child: BadgeIcon(icon: Icon(Icons.shopping_cart)),
//             ),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           Visibility(
//             visible: (productPageData?.success ?? false),
//             child: Column(
//               children: [
//                 // Scrollable content
//                 Expanded(
//                   child: SingleChildScrollView(
//                     controller: _scrollController,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           color: Theme.of(context).cardColor,
//                           child: Column(
//                             children: [
//                               Stack(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 26),
//                                       child: ProductImages(
//                                         productPageData?.images ?? [],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 ProductPageBasicDetailsView(
//                                   addedToWishlist!,
//                                   productPageBloc,
//                                   product: productPageData,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(12.0),
//                             child: Text('Description', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//                           ),
//                           SizedBox(height: AppSizes.normalPadding),
//                           if ((productPageData?.variants ?? []).isNotEmpty)
//                             ProductVariants(productPageData, productPageBloc),
//                           SizedBox(height: AppSizes.normalPadding),
//                           Visibility(
//                             visible:
//                                 productPageData?.description != "" &&
//                                 productPageData?.description != null,
//                             child: ProductDetailsView(
//                               productPageData?.description,
//                             ),
//                           ),
//                           Visibility(
//                             visible:
//                                 (productPageData?.attributes != null &&
//                                 (productPageData?.attributes?.isNotEmpty ??
//                                     false)),
//                             child: Container(
//                               color: Theme.of(context).cardColor,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(height: AppSizes.mediumPadding),
//                                   Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 8.0,
//                                     ),
//                                     child: Text(
//                                       _localizations?.translate(
//                                             AppStringConstant.specifications,
//                                           ) ??
//                                           '',
//                                       style: Theme.of(
//                                         context,
//                                       ).textTheme.titleSmall,
//                                       textAlign: TextAlign.start,
//                                     ),
//                                   ),
//                                   SizedBox(height: AppSizes.normalPadding),
//                                   ListView.separated(
//                                     padding: EdgeInsets.zero,
//                                     shrinkWrap: true,
//                                     itemCount:
//                                         productPageData?.attributes?.length ?? 0,
//                                     physics: NeverScrollableScrollPhysics(),
//                                     itemBuilder: (context, index) {
//                                       var attribute =
//                                           productPageData?.attributes?[index];
//                                       return Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                           horizontal: 8.0,
//                                         ),
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               attribute?.name ?? "",
//                                               style: Theme.of(
//                                                 context,
//                                               ).textTheme.bodyMedium,
//                                             ),
//                                             SizedBox(
//                                               width: AppSizes.mediumPadding,
//                                             ),
//                                             Text(
//                                               attribute?.values
//                                                       ?.map((v) => v.name)
//                                                       .join(", ") ??
//                                                   "",
//                                               style: Theme.of(
//                                                 context,
//                                               ).textTheme.bodySmall,
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                     separatorBuilder:
//                                         (BuildContext context, int index) {
//                                           return SizedBox(height: 4);
//                                         },
//                                   ),
//                                   SizedBox(height: AppSizes.normalPadding),
//                                   Divider(thickness: 1),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           if ((AppSharedPref().getSplashData()?.addons?.review ??
//                                   false) &&
//                               (productPageData?.totalReview ?? 0) > 0)
//                             reviewTile(),
//                           if (AppSharedPref().getSplashData()?.isCrossSelling ??
//                               false)
//                             AlternateProductsList(
//                               productPageData?.alternativeProducts,
//                             ),
//                           SizedBox(height: 180),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).scaffoldBackgroundColor,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 10,
//                           offset: Offset(0, -2),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         QuantityView(bloc: productPageBloc, counter: counter),
//                       AddToCartButtonView(
//                         productPageBloc,
//                         ApiConstant.baseUrl.contains('example.com')
//                             ? (int.tryParse(
//                                     widget.arguments[productIdKey]?.toString() ??
//                                         '') ??
//                                 productPageData?.templateId ??
//                                 productPageData?.productId ??
//                                 0)
//                             : (productPageData?.productId ?? 0),
//                         productPageData?.name ?? '',
//                         counter ?? 1,
//                       ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Visibility(visible: isLoading, child: Loader()),
//           ],
//         ),
//       );

//   }

//   Widget reviewTile() {
//     return InkWell(
//       onTap: () => Navigator.of(context)
//           .pushNamed(
//             reviewList,
//             arguments: getReviewDataMap(
//               productPageData?.name ?? "",
//               productPageData?.thumbNail ?? "",
//               productPageData?.templateId ?? 0,
//             ),
//           )
//           .then((value) {
//             productPageBloc?.emit(ProductScreenInitial());
//             productPageBloc?.add(
//               ProductScreenDataFetchEvent(widget.arguments[productIdKey]),
//             );
//           }),
//       child: Container(
//         color: Theme.of(context).cardColor,
//         padding: EdgeInsets.symmetric(
//           vertical: AppSizes.sidePadding,
//           horizontal: AppSizes.imageRadius,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               " ${_localizations?.translate(AppStringConstant.reviews)} (${productPageData?.totalReview})",
//               style: Theme.of(context).textTheme.displaySmall,
//             ),
//             const Icon(Icons.arrow_forward_ios),
//           ],
//         ),
//       ),
//     );
//   }

//   var methodChannel = const MethodChannel(AppConstant.channelName);

//   Future startArActivity() async {
//     if (Platform.isIOS) {
//       Helper().downloadPersonalData(context, productPageData?.arIos ?? "");
//     }
//     try {
//       var data = await methodChannel.invokeMethod("showAr", {
//         "name": productPageData?.name,
//         "url": productPageData?.arAndroid,
//       });
//       return data;
//     } on PlatformException catch (e) {
//       return "Failed to Invoke: '${e.message}'.";
//     }
//   }

//   bool getArStatus() {
//     if (Platform.isAndroid && (productPageData?.arAndroid ?? "").isNotEmpty) {
//       return true;
//     } else if (Platform.isIOS && (productPageData?.arIos ?? "").isNotEmpty) {
//       return true;
//     }
//     return false;
//   }
// }

import 'dart:io';

/**
 * Webkul Software.
 * @package Mobikul App
 * @Category Mobikul
 * @author Webkul <support@webkul.com>
 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 * @license https://store.webkul.com/license.html ASL Licence
 * @link https://store.webkul.com/license.html
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/badge_icon.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/models/BaseModel.dart';
import 'package:flutter_project_structure/models/ProductScreenModel.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_event.dart';
import 'package:flutter_project_structure/screens/product/bloc/product_screen_state.dart';
import 'package:flutter_project_structure/screens/product/views/add_to_cart_button.dart';
import 'package:flutter_project_structure/screens/product/views/alternate_products.dart';
import 'package:flutter_project_structure/screens/product/views/product_basic_details.dart';
import 'package:flutter_project_structure/screens/product/views/product_details.dart';
import 'package:flutter_project_structure/screens/product/views/product_images.dart';
import 'package:flutter_project_structure/screens/product/views/product_variants.dart';
import 'package:flutter_project_structure/screens/product/views/quantity_view.dart';
import '../../constants/arguments_map.dart';
import '../../models/HomeScreenModel.dart';
import '../../helper/app_shared_pref.dart';
import '../../utils/helper.dart';

class ProductScreen extends StatefulWidget {
  Map<String, dynamic> arguments;

  ProductScreen(this.arguments, {super.key});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ScrollController _scrollController = ScrollController();
  ProductScreenBloc? productPageBloc;
  ProductScreenModel? productPageData;
  AppLocalizations? _localizations;
  bool isLoading = false;
  int? counter = 1;
  bool? addedToWishlist = false;
  BaseModel? baseModel;
  Products? _passedProduct;

  // Track app bar transparency based on scroll
  double _appBarOpacity = 0.0;

  @override
  void initState() {
    productPageBloc = context.read<ProductScreenBloc>();
    _passedProduct = widget.arguments[productDataKey] as Products?;

    if (_passedProduct != null) {
      productPageData = ProductScreenModel.fromJson({
        "success": true,
        "templateId":
            _passedProduct?.templateId ?? _passedProduct?.productId ?? 0,
        "name": _passedProduct?.name ?? "",
        "images": [_passedProduct?.thumbNail ?? ""],
        "thumbNail": _passedProduct?.thumbNail ?? "",
        "priceUnit": _passedProduct?.priceUnit ?? "",
        "priceReduce": _passedProduct?.priceReduce ?? "",
        "productId": _passedProduct?.productId ?? 0,
        "productCount": _passedProduct?.productCount ?? 1,
        "add_to_cart": true,
        "addedToWishlist": false,
        "description": _passedProduct?.description ?? "",
        "attributes": [],
        "variants": [],
        "combinations": [],
        "total_review": 0,
        "avg_rating": 0.0,
      });
    } else {
      productPageBloc?.add(
        ProductScreenDataFetchEvent(widget.arguments[productIdKey]),
      );
    }

    _scrollController.addListener(() {
      final offset = _scrollController.offset;
      const fadeStart = 0.0;
      const fadeEnd = 200.0;
      final opacity = ((offset - fadeStart) / (fadeEnd - fadeStart)).clamp(
        0.0,
        1.0,
      );
      if ((opacity - _appBarOpacity).abs() > 0.01) {
        setState(() => _appBarOpacity = opacity);
      }
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = AppLocalizations.of(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductScreenBloc, ProductScreenState>(
      builder: (context, currentState) {
        if (_passedProduct != null && productPageData != null) {
          isLoading = false;
          addedToWishlist = productPageData?.addedToWishlist ?? false;
          return _buildUI();
        }
        if (currentState is ProductScreenInitial) {
          isLoading = true;
        } else if (currentState is ProductScreenSuccess ||
            currentState is ProductScreenSuccessCache) {
          if (currentState is ProductScreenSuccessCache) {
            productPageData = currentState.productPageData;
          } else if (currentState is ProductScreenSuccess) {
            productPageData = currentState.productPageData;
          }
          isLoading = false;
          addedToWishlist = productPageData?.addedToWishlist ?? false;
        } else if (currentState is ProductScreenError) {
          isLoading = false;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AlertMessage.showError(currentState.message ?? '', context);
          });
        } else if (currentState is QuantityUpdateState) {
          isLoading = false;
          counter = currentState.qty;
        } else if (currentState is AddToWishlistState) {
          isLoading = false;
          baseModel = currentState.baseModel;
          if (currentState.baseModel?.success ?? false) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                currentState.baseModel?.message ?? '',
                context,
              );
            });
            addedToWishlist = true;
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AlertMessage.showError(
                currentState.baseModel?.message ?? '',
                context,
              );
            });
          }
        } else if (currentState is RemoveFromWishlist) {
          isLoading = false;
          baseModel = currentState.baseModel;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AlertMessage.showSuccess(
              currentState.baseModel?.message ?? '',
              context,
            );
          });
          addedToWishlist = false;
        } else if (currentState is AddtoCartState) {
          isLoading = false;
          AppSharedPref().setGuestCartCount(currentState.model?.cartCount ?? 0);
          baseModel = currentState.model;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (currentState.model?.success ?? false) {
              AlertMessage.showSuccess(
                currentState.model?.message ?? '',
                context,
              );
            } else {
              AlertMessage.showError(
                currentState.model?.message ?? '',
                context,
              );
            }
          });
        } else if (currentState is BuyNowState) {
          isLoading = false;
          AppSharedPref().setGuestCartCount(currentState.model?.cartCount ?? 0);
          baseModel = currentState.model;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamed(context, cart);
          });
        } else if (currentState is AddReview) {
          isLoading = false;
          baseModel = currentState.baseModel;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AlertMessage.showSuccess(
              currentState.baseModel?.message ?? '',
              context,
            );
          });
        }
        return _buildUI();
      },
    );
  }

  Widget _buildUI() {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(theme),
      body: Stack(
        children: [
          Visibility(
            visible: productPageData?.success ?? false,
            child: Column(
              children: [
                // ── Scrollable content ──────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hero image (extends behind app bar)
                        ProductImages(productPageData?.images ?? []),

                        // White content card area
                        Container(
                          decoration: BoxDecoration(
                            color: theme.cardColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Name / price / actions
                              ProductPageBasicDetailsView(
                                addedToWishlist!,
                                productPageBloc,
                                product: productPageData,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 8),

                        // ── Variants ────────────────────────────────────
                        if ((productPageData?.variants ?? []).isNotEmpty) ...[
                          ProductVariants(productPageData, productPageBloc),
                          SizedBox(height: 8),
                        ],

                        // ── Description ─────────────────────────────────
                        if ((productPageData?.description ?? '').isNotEmpty)
                          _sectionCard(
                            context,
                            title: 'Description',
                            child: ProductDetailsView(
                              productPageData?.description,
                            ),
                          ),

                        SizedBox(height: 8),

                        // ── Specifications ──────────────────────────────
                        if ((productPageData?.attributes?.isNotEmpty ?? false))
                          _specificationsCard(context),

                        SizedBox(height: 8),

                        // ── Reviews link ────────────────────────────────
                        if ((AppSharedPref().getSplashData()?.addons?.review ??
                                false) &&
                            (productPageData?.totalReview ?? 0) > 0)
                          _reviewTile(),

                        SizedBox(height: 8),

                        // ── Alternate products ───────────────────────────
                        if (AppSharedPref().getSplashData()?.isCrossSelling ??
                            false)
                          AlternateProductsList(
                            productPageData?.alternativeProducts,
                          ),

                        // Bottom spacer so content clears the bottom bar
                        SizedBox(height: 160),
                      ],
                    ),
                  ),
                ),

                // ── Sticky bottom bar ────────────────────────────────────
                Container(
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 16,
                        offset: Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      QuantityView(bloc: productPageBloc, counter: counter),
                      AddToCartButtonView(
                        productPageBloc,
                        ApiConstant.baseUrl.contains('example.com')
                            ? (int.tryParse(
                                    widget.arguments[productIdKey]
                                            ?.toString() ??
                                        '',
                                  ) ??
                                  productPageData?.templateId ??
                                  productPageData?.productId ??
                                  0)
                            : (productPageData?.productId ?? 0),
                        productPageData?.name ?? '',
                        counter ?? 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(visible: isLoading, child: Loader()),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      backgroundColor:
          theme.appBarTheme.backgroundColor?.withOpacity(_appBarOpacity) ??
          theme.scaffoldBackgroundColor.withOpacity(_appBarOpacity),
      elevation: _appBarOpacity > 0.5 ? 0.5 : 0,
      automaticallyImplyLeading: false,
      leading: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _appBarOpacity < 0.8
              ? Colors.black.withOpacity(0.3)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () => Navigator.pop(context, true),
          icon: Icon(
            Icons.arrow_back_outlined,
            color: _appBarOpacity < 0.8 ? Colors.white : null,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      title: AnimatedOpacity(
        opacity: _appBarOpacity,
        duration: Duration(milliseconds: 100),
        child: Text(
          productPageData?.name ?? 'Product Details',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      actions: [
        if (AppSharedPref().getIfLogin() ?? false)
          Container(
            margin: EdgeInsets.only(right: 4, top: 8, bottom: 8),
            decoration: BoxDecoration(
              color: _appBarOpacity < 0.8
                  ? Colors.black.withOpacity(0.3)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, wishlist).then((value) {
                  productPageBloc?.add(ProductScreenLoadingEvent());
                  productPageBloc?.add(
                    ProductScreenDataFetchEvent(widget.arguments[productIdKey]),
                  );
                });
              },
              icon: Icon(
                Icons.favorite_outline,
                color: _appBarOpacity < 0.8 ? Colors.white : null,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
        Container(
          margin: EdgeInsets.only(right: 8, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: _appBarOpacity < 0.8
                ? Colors.black.withOpacity(0.3)
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              if ((AppSharedPref().getIfLogin() != null &&
                      AppSharedPref().getIfLogin() == true) ||
                  AppSharedPref().getGuestCheckout()) {
                Navigator.pushNamed(context, cart);
              } else {
                DialogHelper.confirmationDialog(
                  "${_localizations?.translate(AppStringConstant.signInToContinue)}",
                  context,
                  _localizations,
                  onConfirm: () async {
                    Navigator.pushNamed(context, loginSignup, arguments: false);
                  },
                );
              }
            },
            icon: Semantics(
              identifier: 'product-cart',
              child: BadgeIcon(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: _appBarOpacity < 0.8 ? Colors.white : null,
                ),
              ),
            ),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  /// Generic section card with a title and child content
  Widget _sectionCard(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _specificationsCard(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.cardColor,
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _localizations?.translate(AppStringConstant.specifications) ??
                'Specifications',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12),
          ...List.generate(productPageData?.attributes?.length ?? 0, (index) {
            final attribute = productPageData?.attributes?[index];
            final isEven = index % 2 == 0;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: isEven
                    ? Colors.grey.withOpacity(0.05)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      attribute?.name ?? '',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      attribute?.values?.map((v) => v.name).join(', ') ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _reviewTile() {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(
            reviewList,
            arguments: getReviewDataMap(
              productPageData?.name ?? "",
              productPageData?.thumbNail ?? "",
              productPageData?.templateId ?? 0,
            ),
          )
          .then((value) {
            productPageBloc?.emit(ProductScreenInitial());
            productPageBloc?.add(
              ProductScreenDataFetchEvent(widget.arguments[productIdKey]),
            );
          }),
      child: Container(
        color: Theme.of(context).cardColor,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                SizedBox(width: 6),
                Text(
                  "${_localizations?.translate(AppStringConstant.reviews) ?? 'Reviews'} (${productPageData?.totalReview})",
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  var methodChannel = const MethodChannel(AppConstant.channelName);

  Future startArActivity() async {
    if (Platform.isIOS) {
      Helper().downloadPersonalData(context, productPageData?.arIos ?? "");
    }
    try {
      var data = await methodChannel.invokeMethod("showAr", {
        "name": productPageData?.name,
        "url": productPageData?.arAndroid,
      });
      return data;
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }

  bool getArStatus() {
    if (Platform.isAndroid && (productPageData?.arAndroid ?? "").isNotEmpty) {
      return true;
    } else if (Platform.isIOS && (productPageData?.arIos ?? "").isNotEmpty) {
      return true;
    }
    return false;
  }
}
