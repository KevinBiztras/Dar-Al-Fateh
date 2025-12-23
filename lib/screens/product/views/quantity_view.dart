// // ignore_for_file: prefer_const_constructors

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
// import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
// import 'package:flutter_project_structure/helper/app_localizations.dart';

// import '../bloc/product_screen_bloc.dart';
// import '../bloc/product_screen_event.dart';
// import '../bloc/product_screen_state.dart';

// class QuantityView extends StatefulWidget {
//   ValueChanged<int>? callBack;
//   ProductScreenBloc? bloc;
//   int? counter;

//   QuantityView({this.callBack, this.bloc, this.counter});

//   @override
//   State<StatefulWidget> createState() {
//     return _QuantityViewState();
//   }
// }

// class _QuantityViewState extends State<QuantityView> {
//   TextEditingController controller = TextEditingController();
//   ProductScreenBloc? bloc;
//   AppLocalizations? _localizations;

//   @override
//   void initState() {
//     controller.text =
//         "${widget.counter} ${_localizations?.translate(AppStringConstant.unit) ?? 'Unit'}";
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     _localizations = AppLocalizations.of(context);
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // margin: EdgeInsets.zero,
//       // padding: const EdgeInsets.all(AppSizes.normalPadding),
//       margin: const EdgeInsets.symmetric(vertical: AppSizes.linePadding),
//       padding: const EdgeInsets.symmetric(
//         // vertical: AppSizes.linePadding,
//         horizontal: AppSizes.normalPadding,
//       ),
//       color: Theme.of(context).cardColor,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             _localizations?.translate(AppStringConstant.quantity) ?? '',
//             style: Theme.of(context).textTheme.titleSmall,
//           ),
//           SizedBox(height: AppSizes.linePadding),
//           // Divider(),
//           SizedBox(height: AppSizes.linePadding),
//           SizedBox(
//             height: AppSizes.width / 10,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 commonButton(
//                   context,
//                   () {
//                     if (widget.counter! > 1) {
//                       widget.counter = (widget.counter ?? 1) - 1;
//                       changeQty();
//                     }
//                   },
//                   '',
//                   widget: Icon(Icons.remove, size: 16, color: AppColors.white),
//                   width: AppSizes.width / 26,
//                   height: AppSizes.width / 36,
//                   backgroundColor: AppColors.black,
//                   textColor: Theme.of(context).colorScheme.secondaryContainer,
//                 ),

//                 SizedBox(width: 10),
//                 // Container(
//                 //   width: AppSizes.width / 6,
//                 //   color: Colors.black,
//                 //   child: InkWell(
//                 //       onTap: () {
//                 //         // setState(() {
//                 //         widget.counter = (widget.counter ?? 1) + 1;
//                 //         changeQty();
//                 //         // });
//                 //       },
//                 //       child: Icon(
//                 //         Icons.add,
//                 //         size: 30,
//                 //         color: AppColors.white,
//                 //       )),
//                 // ),
//                 commonButton(
//                   context,
//                   () {
//                     widget.counter = (widget.counter ?? 1) + 1;
//                     changeQty();
//                   },
//                   '',
//                   widget: Icon(Icons.add, size: 16, color: AppColors.white),
//                   width: AppSizes.width / 26,
//                   height: AppSizes.width / 36,
//                   backgroundColor: AppColors.black,
//                   textColor: Theme.of(context).colorScheme.secondaryContainer,
//                 ),
//                 Spacer(),
//                 SizedBox(
//                   width: AppSizes.width / 6,
//                   child: TextField(
//                     enabled: false,
//                     controller: controller,
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.bodyLarge,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(border: InputBorder.none),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void changeQty() {
//     print("qadsqds--${widget.counter}");
//     widget.bloc?.add(QuantityUpdateEvent(widget.counter));
//     widget.bloc?.emit(ProductScreenInitial());
//     controller.text =
//         ("${widget.counter}" +
//         ((widget.counter! > 1)
//             ? " ${_localizations?.translate(AppStringConstant.units)}"
//             : " ${_localizations?.translate(AppStringConstant.unit)}"));
//   }
// }














// ignore_for_file: prefer_const_constructors

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
import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

import '../bloc/product_screen_bloc.dart';
import '../bloc/product_screen_event.dart';
import '../bloc/product_screen_state.dart';

class QuantityView extends StatefulWidget {
  ValueChanged<int>? callBack;
  ProductScreenBloc? bloc;
  int? counter;

  QuantityView({this.callBack, this.bloc, this.counter});

  @override
  State<StatefulWidget> createState() {
    return _QuantityViewState();
  }
}

class _QuantityViewState extends State<QuantityView> {
  TextEditingController controller = TextEditingController();
  ProductScreenBloc? bloc;
  AppLocalizations? _localizations;
  late int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.counter ?? 1;
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
    _syncControllerText();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.symmetric(
        // vertical: AppSizes.normalPadding,
        horizontal: AppSizes.normalPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _localizations?.translate(AppStringConstant.quantity) ?? 'Quantity',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          
          // Quantity controls
          Row(
            children: [
              commonButton(
                context,
                () {
                  if (_counter > 1) {
                    setState(() {
                      _counter -= 1;
                    });
                    changeQty(_counter);
                  }
                },
                '',
                widget: Icon(Icons.remove, size: 17, color: AppColors.white),
                width: AppSizes.width / 20,
                height: AppSizes.width / 30,
                backgroundColor: AppColors.black,
                textColor: Theme.of(context).colorScheme.secondaryContainer,
              ),
              
              SizedBox(
                width: AppSizes.width / 6,
                child: TextField(
                  enabled: false,
                  controller: controller,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              
              commonButton(
                context,
                () {
                  setState(() {
                    _counter += 1;
                  });
                  changeQty(_counter);
                },
                '',
                widget: Icon(Icons.add, size: 17, color: AppColors.white),
                width: AppSizes.width / 26,
                height: AppSizes.width / 36,
                backgroundColor: AppColors.black,
                textColor: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void changeQty(int counter) {
    widget.bloc?.add(QuantityUpdateEvent(counter));
    widget.bloc?.emit(ProductScreenInitial());
    widget.callBack?.call(counter);
    _syncControllerText();
  }

  void _syncControllerText() {
    final unitText = _counter > 1
        ? _localizations?.translate(AppStringConstant.units)
        : _localizations?.translate(AppStringConstant.unit);
    controller.text = "$_counter ${unitText ?? 'Unit'}";
  }
}
