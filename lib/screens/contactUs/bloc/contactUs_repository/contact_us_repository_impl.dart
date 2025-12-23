/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */
import 'package:flutter_project_structure/models/ContactUsModel.dart';
import 'package:flutter_project_structure/networkManager/api_client.dart';

import 'contact_us_repository.dart';

class ContactUsRepositoryImpl implements ContactUsRepository {

  @override
  Future<ContactUsModel> getContactUsDetails() async {
    ContactUsModel? model;
    model = await ApiClient().getContactUsDetails();
    return model;
  }

}
