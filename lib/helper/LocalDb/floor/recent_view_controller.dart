


/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */


import 'dart:async';

class RecentViewController {
  RecentViewController._();

  static StreamController<String?> controller = StreamController.broadcast();

  static final RecentViewController _instance = RecentViewController._();

  factory RecentViewController() {
    return _instance;
  }
}
