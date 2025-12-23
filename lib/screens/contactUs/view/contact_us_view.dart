/*
 *  Webkul Software.
 *
 *  @package  Mobikul Application Code.
 *  @Category Mobikul
 *  @author Webkul <support@webkul.com>
 *  @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *  @license https://store.webkul.com/license.html 
 *  @link https://store.webkul.com/license.html
 *
 */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/models/ContactUsModel.dart';
import 'package:flutter_project_structure/screens/contactUs/bloc/contact_us_screen_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ContactUsViewState();
  }
}

class ContactUsViewState extends State<ContactUsView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  AppLocalizations? _localizations;
  ContactUsScreenBloc? bloc;
  ContactUsModel? model;

  @override
  void initState() {
    bloc = context.read<ContactUsScreenBloc>();
    bloc?.add(ContactUsScreenEventInitial());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactUsScreenBloc, ContactUsScreenState>(
        builder: (BuildContext context, state) {
      if (state is ContactUsLoadingState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          DialogHelper.loaderDialog(
              AppStringConstant.loadingMessage, '', context, _localizations);
        });
      } else if (state is ContactUsSuccessState) {
        model = state.model;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pop();
        });
      } else if (state is ContactUsErrorState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          AlertMessage.showError(state.message ?? '', context);
        });
      }
      return buildUI(context);
    });
  }

  Widget buildUI(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: commonAppBar(
            _localizations!.translate(AppStringConstant.contactUs), context,
            isLeadingEnable: true, onPressed: () {
          Navigator.pop(context);
        }),
        body: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Image.asset(
                'lib/assets/images/appIconLarge.png',
                height: AppSizes.height / 3,
                width: AppSizes.width,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: AppSizes.widgetSidePadding,
              ),
              Center(
                child: Text(model?.companyName ?? '',
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
              const SizedBox(
                height: AppSizes.widgetSidePadding,
                child: Divider(
                  height: 1,
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    launchAddress(model?.address);
                  },
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.pinkAccent,
                        ),
                        const SizedBox(
                          width: AppSizes.mediumPadding,
                          height: AppSizes.mediumPadding,
                        ),
                        Text(
                          model?.address ?? '',
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSizes.widgetSidePadding,
                child: Divider(
                  height: 1,
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    launchPhone(model?.phone);
                  },
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.phone,
                          color: Colors.pinkAccent,
                        ),
                        const SizedBox(
                          width: AppSizes.mediumPadding,
                          height: AppSizes.mediumPadding,
                        ),
                        Text(model?.phone ?? '')
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSizes.widgetSidePadding,
                child: Divider(
                  height: 1,
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    launchEmail(model?.email);
                  },
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.mail,
                          color: Colors.pinkAccent,
                        ),
                        const SizedBox(
                          width: AppSizes.mediumPadding,
                          height: AppSizes.mediumPadding,
                        ),
                        Text(model?.email ?? '')
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void launchAddress(String? address) async {
    if (address != null && address.isNotEmpty) {
      String query = Uri.encodeComponent(address);
      String googleUrl =
          "https://www.google.com/maps/search/?api=1&query=$query";

      if (await canLaunchUrl(Uri.parse(googleUrl))) {
        await launchUrl(Uri.parse(googleUrl));
      }
    }
  }

  void launchPhone(String? phone) async {
    if (phone != null && phone.isNotEmpty) {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phone,
      );
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      }
    }
  }

  void launchEmail(String? email) async {
    if (email != null && email.isNotEmpty) {
      final Uri launchUri = Uri(
        scheme: 'mailto',
        path: email,
      );
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      }
    }
  }
}
