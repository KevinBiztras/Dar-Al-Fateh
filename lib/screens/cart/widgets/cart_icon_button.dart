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
import 'package:flutter_project_structure/constants/app_constants.dart';

class CartIconButton extends StatelessWidget {
  const CartIconButton({
    required this.leadingIcon,
    required this.title,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  final IconData leadingIcon;
  final String title;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
         width: AppSizes.width/1.07,
          height: AppSizes.itemHeight,
          child: OutlinedButton(onPressed: onClick,

            style: OutlinedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              side: BorderSide(color: Theme.of(context).colorScheme.onPrimary,width: 1.5)
            ),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.imageRadius),
                child: Icon(leadingIcon,color: Theme.of(context).colorScheme.onPrimary,size: 22,),
              ),
              Text(
                  title,
                  textAlign: TextAlign.center,
                  style:Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13, fontWeight: FontWeight.bold,color:Theme.of(context).colorScheme.onPrimary))
            ],

          ),),
        ),
      ],
    );
  }
}