
/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */
import 'package:equatable/equatable.dart';
abstract class CheckoutScreenEvent extends Equatable{
  const CheckoutScreenEvent();

  @override
  List<Object> get props => [];
}


class ShippingAddressFetchEvent extends CheckoutScreenEvent {
  const ShippingAddressFetchEvent();

  @override
  List<Object> get props => [];
}

class ChangeAddressEvent extends CheckoutScreenEvent {
  const ChangeAddressEvent();

  @override
  List<Object> get props => [];
}

class ShippingMethodsFetchEvent extends CheckoutScreenEvent {
  const ShippingMethodsFetchEvent();

  @override
  List<Object> get props => [];
}
