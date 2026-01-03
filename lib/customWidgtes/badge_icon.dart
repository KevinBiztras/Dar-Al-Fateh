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
import 'package:flutter_project_structure/helper/app_shared_pref.dart';

class BadgeIcon extends StatefulWidget {
  BadgeIcon(
      {Key? key,
      this.icon,
      this.showIfZero = false,
      this.badgeColor = Colors.red,
      TextStyle? badgeTextStyle})
      : badgeTextStyle = badgeTextStyle ??
            const TextStyle(
              color: Colors.white,
              fontSize: 8,
            ),
        super(key: key);
  final Widget? icon;
  final bool showIfZero;
  final Color badgeColor;
  final TextStyle badgeTextStyle;

  @override
  State<BadgeIcon> createState() => _BadgeIconState();
}

class _BadgeIconState extends State<BadgeIcon> {
  int badgeCount = 0;

  @override
  Widget build(BuildContext context) {
    registerBadgeCountListener();
    return Stack(children: <Widget>[
      widget.icon!,
      if (badgeCount > 0 || widget.showIfZero) badge(badgeCount),
    ]);
  }

  Widget badge(int count) => Positioned(
        right: 0,
        top: 0,
        child: Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: widget.badgeColor,
            borderRadius: BorderRadius.circular(8.5),
          ),
          constraints: const BoxConstraints(
            minWidth: 15,
            minHeight: 15,
          ),
          child: Center(
            child: Text(
              (count > 99) ? "99+" :
              count.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );

  //=============================User to handle badge count=======/
  void registerBadgeCountListener() {
   if(AppSharedPref()
       .getUserData() != null) {
     AppSharedPref().userStorage.listenKey(AppSharedPref().userdata, (val) {
       if ((badgeCount != (AppSharedPref()
           .getUserData()
           ?.cartCount ?? 0))) {
         Future.delayed(Duration.zero).then((value) {
           try {
             if (mounted) {
               setState(() {
                 badgeCount = AppSharedPref()
                     .getUserData()
                     ?.cartCount ?? 0;
               });
             }
           } catch (e) {
             print("Badge Error--$e");
           }
         });
       }
     });
   } else if (AppSharedPref().getGuestCartCount() != null) {
     Future.delayed(Duration.zero).then((value) {
       try {
         if (mounted) {
           final guestItems = AppSharedPref().getGuestCartItems();
           setState(() {
             badgeCount =
                 guestItems.isNotEmpty ? guestItems.length : (AppSharedPref().getGuestCartCount() ?? 0);
           });
         }
       } catch (e) {
         print("Badge Error--$e");
       }
     });
   }
  }
}
