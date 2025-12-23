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

abstract class AccountInfoEvent extends Equatable {
  const AccountInfoEvent();

  @override
  List<Object> get props => [];
}

class DownloadInformationEvent extends AccountInfoEvent {
  const DownloadInformationEvent();
}

class SaveAccountInfoEvent extends AccountInfoEvent {
  final String? name, password;

  const SaveAccountInfoEvent(this.name, this.password);
}

class DeactivateAccount extends AccountInfoEvent {
  final String type;

  const DeactivateAccount(this.type);
}

class ReSendVerificationEvent extends AccountInfoEvent {
  const ReSendVerificationEvent();
}

class DeleteAccountLoginEvent extends AccountInfoEvent {
  final String? email, password;

  const DeleteAccountLoginEvent(this.email, this.password);
}

class LoginOnWatchEvent extends AccountInfoEvent {
  final String? fcmToken, fcmDeviceId;
  final bool? watchLogin;

  const LoginOnWatchEvent(this.fcmToken,
      this.fcmDeviceId, this.watchLogin);
}

class DeleteAccountEvent extends AccountInfoEvent {
  const DeleteAccountEvent();
}
