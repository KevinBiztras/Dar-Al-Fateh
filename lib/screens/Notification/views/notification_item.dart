/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/models/NotificationModel.dart';

class NotificationItem extends StatefulWidget {
   NotificationItem(this.data,this.callback, {Key? key}) : super(key: key);
  NotificationList? data;
  Function(int, bool)? callback;
  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  bool isRead = false;
  @override
  void initState() {
    isRead = widget.data?.isRead ?? false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(AppSizes.imageRadius),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.0),
          color: Theme.of(context).cardColor,
          boxShadow: const [
            BoxShadow(
              color: AppColors.lightGray,
              blurRadius: 1.0,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(AppSizes.extraPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(child: Text(widget.data?.title ?? "", style: Theme.of(context).textTheme.labelLarge,)),
                        const SizedBox(height: AppSizes.imageRadius/2,),
                        Flexible(child: Text(widget.data?.body ?? "", style: Theme.of(context).textTheme.bodySmall)),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      if(widget.data?.isRead ?? false){

                      }
                      else {
                        setState(() {
                          widget.data?.isRead = true;
                        });
                        widget.callback!(
                            widget.data?.id ?? 0, widget.data?.isRead ?? false);
                      }
                    },
                    child: Icon(Icons.notifications,
                      color: (widget.data?.isRead ?? false) ? AppColors.blue : AppColors.lightGray,),
                  )
                ],
              ),
            ),
            SizedBox(
              width: AppSizes.width/2.7,
              height: AppSizes.width/2.94,
              child: CachedNetworkImage(imageUrl :widget.data?.banner ?? '' ,
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
    );
  }
}
