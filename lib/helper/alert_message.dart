/*

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */

import 'package:flutter/material.dart';
import 'package:flutter_project_structure/helper/extension.dart';
import 'package:simple_animations/simple_animations.dart';
import 'dart:async';

import '../constants/app_constants.dart';

class AlertMessage {
  // static showError(String message, BuildContext context) {
  //   ToastUtils.showCustomToast(
  //       context,
  //       message,
  //       const Icon(
  //         Icons.error,
  //         color: Colors.white,
  //         size: 40,
  //       ),
  //       HexColor.fromHex("BB2124"));
  // }

  // static showSuccess(String message, BuildContext context) {
  //   ToastUtils.showCustomToast(
  //       context,
  //       message,
  //       const Icon(Icons.check_circle_outline, color: Colors.white, size: 40),
  //       HexColor.fromHex("22bb33"));
  // }

  static void showError(String message, BuildContext context) {
    // COMMENTED OUT — NO MORE POPUPS DURING DEMO
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     backgroundColor: Colors.red,
    //     content: Text(message),
    //     duration: Duration(seconds: 3),
    //   ),
    // );

    // Optional: just print to console instead
    debugPrint("API Error (ignored for demo): $message");
  }

  static void showSuccess(String message, BuildContext context) {
    // Also silence success messages if you want
    debugPrint("Success: $message");
  }

  static showWarning(String message, BuildContext context) {
    ToastUtils.showCustomToast(
        context,
        message,
        const Icon(Icons.error, color: Colors.white, size: 40),
        HexColor.fromHex("f0ad4e"));
  }
}

class ToastUtils {
  static Timer? toastTimer;
  static OverlayEntry? _overlayEntry;

  static void showCustomToast(
      BuildContext context, String message, Icon icon, Color color) {
    if (!(toastTimer?.isActive ?? false)) {
      toastTimer = null;
    }
    if (toastTimer == null) {
      if (!(toastTimer?.isActive ?? false)) {
        _overlayEntry = createOverlayEntry(context, message, icon, color);
        Overlay.of(context).insert(_overlayEntry!);
        toastTimer = Timer(const Duration(seconds: 2), () {
          if (_overlayEntry != null) {
            _overlayEntry?.remove();
          }
        });
      }
    }
  }

  static OverlayEntry createOverlayEntry(
      BuildContext context, String message, Icon icon, Color color) {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: AppSizes.width.toDouble(),
        child: SlideInToastMessageAnimation(Material(
          child: Container(
            padding:
                const EdgeInsets.only(top: 30, bottom: 8, left: 16, right: 8),
            decoration: BoxDecoration(color: color),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  icon,
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                      width: AppSizes.width * 0.8,
                      child: Text(
                        message,
                        softWrap: true,
                        style: Theme.of(context)
                            .textTheme.bodyLarge
                            ?.copyWith(color: AppColors.white),
                      ))
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}

class SlideInToastMessageAnimation extends StatelessWidget {
  final Widget child;

  const SlideInToastMessageAnimation(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween(
        AnimationType.translateX,
        Tween(begin: -100.0, end: 0.0),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      )
      ..tween(
        AnimationType.translateX,
        Tween(begin: 0.0, end: 0.0),
        duration: const Duration(seconds: 1, milliseconds: 250),
      )
      ..tween(
        AnimationType.translateX,
        Tween(begin: 0.0, end: -100.0),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
      )
      ..tween(
        AnimationType.opacity,
        Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 500),
      )
      ..tween(
        AnimationType.opacity,
        Tween(begin: 1.0, end: 1.0),
        duration: const Duration(seconds: 1),
      )
      ..tween(
        AnimationType.opacity,
        Tween(begin: 1.0, end: 0.0),
        duration: const Duration(milliseconds: 500),
      );

    return PlayAnimationBuilder<Movie>(
      tween: tween,
      duration: tween.duration,
      child: child,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.get(AnimationType.opacity),
          child: Transform.translate(
            offset: Offset(value.get(AnimationType.translateX), 0),
            child: child,
          ),
        );
      },
    );
  }
}

enum AnimationType { opacity, translateX }
