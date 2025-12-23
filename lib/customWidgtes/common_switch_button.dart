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

class CommonSwitchButton extends StatefulWidget {
  bool isOn;
  final String title;
  final ValueChanged<bool> callback;
  Color? colors;

  CommonSwitchButton(this.title, this.callback, this.isOn,
      {Key? key, this.colors})
      : super(key: key);

  @override
  State<CommonSwitchButton> createState() => _CommonSwitchButtonState();
}

class _CommonSwitchButtonState extends State<CommonSwitchButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.colors,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Switch(
            activeColor: (Theme.of(context).brightness == Brightness.light)
                ? AppColors.black
                : AppColors.white,
            value: widget.isOn,
            onChanged: (value) {
              setState(() {
                widget.isOn = value;
                widget.callback(widget.isOn);
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.imageRadius),
            child: Text(widget.title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.normal)),
          ),
        ],
      ),
    );
  }
}

