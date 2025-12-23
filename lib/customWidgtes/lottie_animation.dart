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
import 'package:lottie/lottie.dart';

Widget lottieAnimation( BuildContext context,String title,String subtitle,
    String buttonTitle, VoidCallback? callback,{String ? lottiePath,IconData? icon}
    ) {
  return Center(
    child: SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: SizedBox(
        width: AppSizes.width - 50,

        child: Column(children: [
          icon != null
              ? Icon(
            icon,
            size: AppSizes.height / 5.3,
            color: Colors.grey[400],
          )
              : Container(),
          icon != null
              ? const SizedBox(
            height: AppSizes.mediumPadding,
          )
              : Container(),
           if(lottiePath!=null)
          Lottie.asset(lottiePath ?? "",
              width: AppSizes.width / 2,
              height: AppSizes.width / 2,
              fit: BoxFit.fill,
              repeat: false
          ),
          Text(title,
              style: Theme.of(context).textTheme.displaySmall),
          const Padding(padding: EdgeInsets.all(AppSizes.linePadding)),
          Text(subtitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.normal),
          ),
          const Padding(padding: EdgeInsets.all(AppSizes.imageRadius)),
          if (buttonTitle != '')
            ElevatedButton(
                onPressed: callback,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.black),
                child: Text(
                  buttonTitle,
                  style: const TextStyle(color: AppColors.white),
                ))
        ]),
      ),
    ),
  );
}
