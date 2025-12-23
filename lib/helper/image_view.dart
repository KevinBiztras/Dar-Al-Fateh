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

class ImageView extends StatelessWidget {
  final String? url;
  double height;
  double width;
  BoxFit fit;
  bool isBanner;
  ImageView({
    this.url,
    this.width = 0.0,
    this.height = 0.0,
    this.fit = BoxFit.scaleDown,
    this.isBanner = false,
  });

  @override
  Widget build(BuildContext context) {
    final String resolvedUrl = url ?? '';
    final bool isAsset =
        resolvedUrl.startsWith('assets/') ||
        resolvedUrl.startsWith('lib/assets/');

    if (isAsset) {
      return Image.asset(
        resolvedUrl,
        width: width != 0.0 ? width : null,
        height: height != 0.0 ? height : null,
        fit: fit,
      );
    }

    return FadeInImage(
      placeholder: AssetImage(
        (!isBanner)
            ? 'lib/assets/images/placeholder.png'
            : 'lib/assets/images/bannerPlaceholder.png',
      ),
      image: CachedNetworkImageProvider(url ?? ''),
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(
          (!isBanner)
              ? 'lib/assets/images/placeholder.png'
              : 'lib/assets/images/bannerPlaceholder.png',
          width: width != 0.0 ? width : null,
          height: height != 0.0 ? height : null,
        );
      },
      fit: fit,
      width: width != 0.0 ? width : null,
      height: height != 0.0 ? height : null,
    );
  }
}
