/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';

import '../../../constants/app_constants.dart';

Widget addressItemWithHeading(
    BuildContext context, String title, String address,
    {Widget? addressList,
    Widget? actions,
    bool? showDivider,
    bool? isElevated,
    VoidCallback? callback}) {
  return Container(
    color: Theme.of(context).cardColor,
    margin: const EdgeInsets.only(top: AppSizes.imageRadius),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.imageRadius),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        if (showDivider ?? false)
          const Divider(
            thickness: 1,
            height: 1,
          ),
        addressList ??
            addressItemCard(address, context,
                actions: actions, isElevated: isElevated, callback: callback)
      ],
    ),
  );
}

Widget addressItemCard(String address, BuildContext context,
    {Widget? actions,
    bool? isElevated,
    VoidCallback? callback,
    bool? isSelected,
    bool? showSelected}) {
  return Container(
    // elevation: (isElevated ?? true) ? AppSizes.linePadding : 0,
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
    ),
    margin: const EdgeInsets.fromLTRB(0, AppSizes.imageRadius, 0, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.imageRadius),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: (callback != null) ? callback : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    fit: FlexFit.loose,
                    child: Text(
                      address.replaceFirst("\n\n", "\n"),
                      style: (isSelected ?? false)
                          ? const TextStyle(fontWeight: FontWeight.bold)
                          : const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                    )),
                if (callback != null)
                  const Icon(
                    Icons.navigate_next,
                    color: AppColors.lightGray,
                  ),
                if ((showSelected ?? false) && (isSelected ?? false))
                  const Icon(
                    Icons.check,
                    color: Colors.green,
                  )
              ],
            ),
          ),
        ),
        const Divider(
          thickness: 1,
          height: 1,
        ),
        if (actions != null) actions,
      ],
    ),
  );
}

Widget actionContainer(
    BuildContext context, VoidCallback leftCallback, VoidCallback rightCallback,
    {IconData? iconLeft,
    IconData? iconRight,
    String? titleLeft,
    String? titleRight,
    bool? isForDefaultAddress}) {
  return IntrinsicHeight(
    child: Padding(
      padding: const EdgeInsets.all( AppSizes.linePadding),
      child: (isForDefaultAddress ?? false)
          ? SizedBox(
        width: AppSizes.width,
        child: OutlinedButton(
          onPressed: leftCallback,
          style: OutlinedButton.styleFrom(
              backgroundColor:
              Theme.of(context).colorScheme.secondaryContainer,
              side: BorderSide(
                  color: Theme.of(context).colorScheme.onPrimary,
                  width: 1.5)),
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.imageRadius),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  iconLeft ?? Icons.edit,
                  size: AppSizes.widgetSidePadding,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                const SizedBox(width: AppSizes.linePadding),
                Flexible(
                    child: Text((titleLeft ?? '').toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.onPrimary))),
              ],
            ),
          ),
        ),
      )
         : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  // width: AppSizes.width / 2.2,
                  child: OutlinedButton(
                    onPressed: leftCallback,
                    style: OutlinedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.onPrimary,
                            width: 1.5)),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.imageRadius),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            iconLeft ?? Icons.edit,
                            size: AppSizes.widgetSidePadding,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          const SizedBox(width: AppSizes.linePadding),
                          Flexible(
                              child: Text((titleLeft ?? '').toUpperCase(),
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.onPrimary))),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.normalPadding,),
                if ((iconRight != Icons.rate_review_outlined) ||
                    ((iconRight == Icons.rate_review_outlined) &&
                        (AppSharedPref().getSplashData()?.addons?.review ??
                            false)))
                  Expanded(
                    // width: AppSizes.width / 2.2,
                    child: OutlinedButton(
                      onPressed: rightCallback,
                      style: OutlinedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.onPrimary,
                              width: 1.5)),
                      child: Padding(
                        padding: const EdgeInsets.all(AppSizes.imageRadius),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              iconRight ?? Icons.add,
                              size: AppSizes.widgetSidePadding,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            const SizedBox(width: AppSizes.linePadding),
                            Flexible(
                                child: Text((titleRight ?? "").toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.onPrimary))),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    ),
  );
}
