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
abstract class AddressBookEvent extends Equatable {
  const AddressBookEvent();

  @override
  List<Object> get props => [];
}

class AddressBookDataFetchEvent extends AddressBookEvent {
  const AddressBookDataFetchEvent();

  @override
  List<Object> get props => [];
}

class DeleteAddressEvent extends AddressBookEvent{
  const DeleteAddressEvent(this.addressId);
  final String addressId;
}
