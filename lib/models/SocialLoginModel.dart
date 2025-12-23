/*
 * *
 *
 *  Webkul Software.
 *
 *  @package Mobikul App
 *
 *  @Category Mobikul
 *
 *  @author Webkul <support@webkul.com>
 *
 *  @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *
 *  @license https://store.webkul.com/license.html ASL Licence
 *
 *  @link https://store.webkul.com/license.html
 *
 * /
 */

class SocialLoginModel {
  String? email;
  String? firstName;
  String? lastName;
  String? id;
  String? photoUrl;
  String? serverAuthCode;
  String? authProvider;
  String? token;

  SocialLoginModel({
    this.lastName,
    this.firstName,
    this.id,
    this.email,
    this.photoUrl,
    this.serverAuthCode,
    this.authProvider,
    this.token
  });

  Map<String, dynamic> toJson() {
    var data = {
      "id": id,
      "email": email,
      "firstname": firstName,
      "lastname": lastName,
      "photoUrl":photoUrl,
      "serverAuthCode": serverAuthCode,
      "authProvider": authProvider,
      "token": token
    };

    return data;
  }
}
