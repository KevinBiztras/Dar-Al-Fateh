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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_switch_button.dart';
import 'package:flutter_project_structure/customWidgtes/common_text_field.dart';
import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/customWidgtes/common_tool_bar.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/firebase_analytics.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/helper/open_bottom_model_sheet.dart';

// import 'package:flutter_project_structure/marketplace/helpers/marketplace_signup_option.dart';
// import 'package:flutter_project_structure/marketplace/marketplaceModel/SignUpDetailsModel.dart';
import 'package:flutter_project_structure/models/CountryListModel.dart';
import 'package:flutter_project_structure/models/UserDataModel.dart';
import 'package:flutter_project_structure/screens/signin_signup/bloc/signin_signup_screen_bloc.dart';
import 'package:flutter_project_structure/utils/helper.dart';

class CreateAnAccount extends StatefulWidget {
  const CreateAnAccount({Key? key}) : super(key: key);

  @override
  _CreateAnAccountState createState() => _CreateAnAccountState();
}

class _CreateAnAccountState extends State<CreateAnAccount> {
  SigninSignupScreenBloc? bloc;
  late TextEditingController _emailController,
      _passwordController,
      _nameController,
      _confirmPasswordController;
  late AppLocalizations? _localizations;
  late bool _loading;
  bool agreeOnTerms = true;
  CountryListModel? _countryListModel;

  // SignUpDetails sellerDetails = SignUpDetails();
  late GlobalKey<FormState> _formKey;

  void _validateForm() async {
    if (_formKey.currentState?.validate() == true) {
      Helper.hideSoftKeyBoard();
      if ((AppSharedPref().getSplashData()?.termsAndConditions ?? false) &&
          !agreeOnTerms) {
        AlertMessage.showError(
            _localizations
                    ?.translate(AppStringConstant.acceptTermAndCondition) ??
                "",
            context);
      } else {
        bloc?.add(SignUpEvent(_emailController.text.trim(),
            _passwordController.text, _nameController.text));
        bloc?.emit(LoadingState());
      }
    }
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _nameController = TextEditingController(text: "");
    _confirmPasswordController = TextEditingController(text: "");
    _loading = false;
    _formKey = GlobalKey();
    bloc = context.read<SigninSignupScreenBloc>();
    bloc?.add(const SignUpInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninSignupScreenBloc, SigninSignupScreenState>(
      builder: (context, state) {
        print(state);
        if (state is LoadingState) {
          _loading = true;
        } else if (state is SignUpInitialDataState) {
          _loading = false;
          _countryListModel = state.model;
        } else if (state is SigninSignupScreenError) {
          _loading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(state.message ?? "", context);
          });
        } else if (state is SignupScreenFormSuccess) {
          _loading = false;
          var model = state.data;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showSuccess(model.message ?? "", context);
            AppSharedPref().setIfLogin(model.success);
            if (_passwordController.text.trim().isNotEmpty) {
              AppSharedPref()
                  .setCurrentPassword(_passwordController.text ?? "");
            }
            AppSharedPref().setUserData(UserDataModel(
                cartCount: model.login?.cartCount,
                name: model.login?.customerName,
                email: model.login?.customerEmail,
                bannerImage: model.login?.customerBannerImage,
                profileImage: model.login?.customerProfileImage,
                customerId: model.login?.customerId,
                isSeller: model.login?.isSeller,
                isEmailVerified: model.login?.isEmailVerified));
            // AnalyticsEventsFirebase().signUpEvent(state.data.toString());
            if (AppSharedPref().getSplashData()?.allowGuestCheckout ?? false) {
              bloc?.add(const GetMergeCartEvent());
            }
            Navigator.pushNamedAndRemoveUntil(context, navBar, (route) => false,
                arguments: 0);
          });
        } else if (state is SignUpTermSuccessState) {
          _loading = false;
          Future.delayed(Duration.zero, () {
            DialogHelper.signUpTerms(
                (state.data.termsAndConditions != null)
                    ? (state.data.termsAndConditions ?? '')
                    : (state.data.sellerTermsAndConditions ?? ''),
                context);
          });
        }
        return Stack(
          children: <Widget>[
            _buildContent(),
            Visibility(
              child: Loader(),
              visible: _loading,
            ),
          ],
        );
      },
    );
  }

  static const _pageColor = Color(0xFFF4FAF6);
  static const _fieldColor = Color(0xFFF8F5F0);
  static const _greenColor = Color(0xFF2E7D32);
  static const _linkColor = Color(0xFF806B43);
  static const _textColor = Color(0xFF1C241D);

  Widget _buildContent() {
    final baseTheme = Theme.of(context);
    final roundedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Color(0xFFD6D9D2)),
    );

    // Scoped to this screen. Retain the shared fields and toolbar so their
    // validators, password controls, and navigation behavior stay intact.
    return Theme(
      data: baseTheme.copyWith(
        scaffoldBackgroundColor: _pageColor,
        colorScheme: baseTheme.colorScheme.copyWith(
          primary: _greenColor,
          onPrimary: Colors.white,
          secondary: _greenColor,
          surface: _pageColor,
          onSurface: _textColor,
        ),
        appBarTheme: baseTheme.appBarTheme.copyWith(
          backgroundColor: _pageColor,
          foregroundColor: _textColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          iconTheme: const IconThemeData(color: _textColor, size: 20),
          titleTextStyle: const TextStyle(
            color: _textColor, fontSize: 20, fontWeight: FontWeight.w600,
          ),
        ),
        textTheme: baseTheme.textTheme.copyWith(
          titleMedium: baseTheme.textTheme.titleMedium?.copyWith(
            color: _textColor, fontSize: 18, fontWeight: FontWeight.w400,
          ),
        ),
        inputDecorationTheme: baseTheme.inputDecorationTheme.copyWith(
          filled: true,
          fillColor: _fieldColor,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 14),
          hintStyle: const TextStyle(
              color: Color(0xFF94948E), fontSize: 18),
          labelStyle: const TextStyle(color: _textColor, fontSize: 18),
          border: roundedBorder,
          enabledBorder: roundedBorder,
          focusedBorder: roundedBorder.copyWith(
            borderSide: const BorderSide(
                color: Color(0xFFD9CEB8), width: 2),
          ),
          errorBorder: roundedBorder.copyWith(
            borderSide: BorderSide(color: baseTheme.colorScheme.error),
          ),
          focusedErrorBorder: roundedBorder.copyWith(
            borderSide: BorderSide(
                color: baseTheme.colorScheme.error, width: 2),
          ),
        ),
        textSelectionTheme: baseTheme.textSelectionTheme.copyWith(
          cursorColor: _linkColor,
          selectionColor: _greenColor.withOpacity(0.2),
          selectionHandleColor: _greenColor,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: _linkColor,
            textStyle: const TextStyle(fontSize: 14),
          ),
        ),
      ),
      child: Builder(
        builder: (themedContext) => SafeArea(
          top: false,
          child: _buildStyledContent(themedContext),
        ),
      ),
    );
  }

  Widget _buildStyledContent(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageColor,
      appBar: commonToolBar(
          _localizations?.translate(AppStringConstant.createAnAccount) ?? "",
          context,
          isLeadingEnable: true),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 16, 32, 24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: AppSizes.normalPadding,
                ),
                CommonTextField(
                  useAccountStyle: true,
                  controller: _emailController,
                  isPassword: false,
                  hintText: _localizations
                          ?.translate(AppStringConstant.emailAddress) ??
                      "",
                  isRequired: true,
                  inputType: TextInputType.emailAddress,
                  validationType: AppStringConstant.email,
                ),

                const SizedBox(height: AppSizes.extraPadding),
                CommonTextField(
                  useAccountStyle: true,
                  controller: _nameController,
                  isRequired: true,
                  isPassword: false,
                  hintText:
                      _localizations?.translate(AppStringConstant.name) ?? '',
                  inputType: TextInputType.name,
                ),

                const SizedBox(height: AppSizes.extraPadding),

                CommonTextField(
                  useAccountStyle: true,
                  hintText:
                      _localizations?.translate(AppStringConstant.password) ??
                          "",
                  controller: _passwordController,
                  isRequired: true,
                  isPassword: true,
                  inputType: TextInputType.visiblePassword,
                  validationType: AppStringConstant.password,
                ),
                const SizedBox(height: AppSizes.extraPadding),
                CommonTextField(
                  useAccountStyle: true,
                  hintText: _localizations
                          ?.translate(AppStringConstant.confirmPassword) ??
                      "",
                  controller: _confirmPasswordController,
                  isRequired: true,
                  isPassword: true,
                  inputType: TextInputType.visiblePassword,
                  validation: (value) {
                    if (_confirmPasswordController.text.isEmpty) {
                      return "${AppLocalizations.of(context)?.translate(AppStringConstant.required)}";
                    } else if (_confirmPasswordController.text !=
                        _passwordController.text) {
                      return _localizations
                              ?.translate(AppStringConstant.passwordNotMatch) ??
                          '';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: AppSizes.extraPadding),
                Visibility(
                  visible:
                      AppSharedPref().getSplashData()?.termsAndConditions ??
                          false,
                  child: CommonSwitchButton(
                      _localizations?.translate(
                              AppStringConstant.agreeTermAndCondition) ??
                          '', (value) {
                    setState(() {
                      agreeOnTerms = value;
                    });
                  }, agreeOnTerms),
                ),
                Visibility(
                  visible:
                      AppSharedPref().getSplashData()?.termsAndConditions ??
                          false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            bloc?.add(const SignUpTermsEvent());
                          },
                          child: Text(
                              (_localizations?.translate(
                                      AppStringConstant.viewTerms) ??
                                  ''),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: _linkColor))),
                    ],
                  ),
                ),

                // MarketPlaceSignUpOption( _countryListModel?.countries ?? [], (SignUpDetails data){
                //   sellerDetails = data;
                // }, (){
                //   bloc?.add(const SellerSignUpTermsEvent());
                // }),
                const SizedBox(height: AppSizes.normalPadding),

                /// Signup

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _validateForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _greenColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      minimumSize: const Size(double.infinity, 48),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    child: Text(
                      _localizations?.translate(
                              AppStringConstant.createAnAccount) ?? '',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.extraPadding),

                /// Loging
                Center(
                  child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4,
                  children: [
                    Text(
                        _localizations
                                ?.translate(AppStringConstant.alreadyAccount)
 ??
                            '',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 14,
                            color: _linkColor)),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          signInSignUpBottomModalSheet(context, false);
                        },
                        child: Text(
                            (_localizations
                                        ?.translate(AppStringConstant.signIn) ??
                                    '')
,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: _linkColor)))
                  ],
                ),

                ),
                const SizedBox(height: AppSizes.extraPadding),
              ],
            ),
          ),
        ),
      ),
    );
  }
}