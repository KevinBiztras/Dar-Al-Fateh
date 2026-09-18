import 'dart:convert';

/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';

import 'package:flutter_project_structure/customWidgtes/dialog_helper.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/firebase_analytics.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/helper/open_bottom_model_sheet.dart';
import 'package:flutter_project_structure/models/LoginResponseModel.dart';
import 'package:flutter_project_structure/models/SplashScreenModel.dart';
import 'package:flutter_project_structure/models/UserDataModel.dart';
import 'package:flutter_project_structure/screens/signin_signup/bloc/signin_signup_screen_bloc.dart';
import 'package:flutter_project_structure/utils/helper.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';

import '../../../helper/encryption.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  SigninSignupScreenBloc? bloc;
  late TextEditingController _emailController, _passwordController;
  late AppLocalizations? _localizations;
  late bool _obscureText, _loading;
  late GlobalKey<FormState> _formKey;
  SplashScreenModel? model;

  @override
  void initState() {
    _emailController = TextEditingController(text: AppConstant.demoEmail);
    _passwordController = TextEditingController(text: AppConstant.demoPassword);
    model = AppSharedPref().getSplashData();
    bloc = context.read<SigninSignupScreenBloc>();
    _obscureText = true;
    _loading = false;
    _formKey = GlobalKey();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  void _validateForm() async {
    if (_formKey.currentState?.validate() == true) {
      Helper.hideSoftKeyBoard();
      bloc?.add(
        LoginEvent(_emailController.text.trim(), _passwordController.text),
      );
      bloc?.emit(LoadingState());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninSignupScreenBloc, SigninSignupScreenState>(
      builder: (context, state) {
        if (state is LoadingState) {
          _loading = true;
        } else if (state is ForgotPasswordState) {
          _loading = false;
          var model = state.data;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showSuccess(model.message ?? "", context);
            Navigator.pushNamedAndRemoveUntil(
              context,
              navBar,
              (route) => false,
              arguments: 0,
            );
          });
        } else if (state is LoginState) {
          _loading = false;
          var model = state.data;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            updateUserPreference(model);
            checkFingerprint();
            AlertMessage.showSuccess(model.message ?? "", context);
            if (AppSharedPref().getSplashData()?.allowGuestCheckout ?? false) {
              bloc?.add(const GetMergeCartEvent());
            }
          });
        } else if (state is FingerprintLoginState) {
          _loading = false;
          var model = state.data;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            updateUserPreference(model);
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(navBar, (route) => false, arguments: 0);
            if (AppSharedPref().getSplashData()?.allowGuestCheckout ?? false) {
              bloc?.add(const GetMergeCartEvent());
            }
            AlertMessage.showSuccess(model.message ?? "", context);
          });
        } else if (state is SigninSignupScreenError) {
          _loading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(state.message ?? "", context);
          });
        }
        return Stack(
          children: <Widget>[
            _buildContent(),
            // Visibility(
            //   child: Loader(),
            //   visible: _loading,
            // ),
          ],
        );
      },
    );
  }

  // Screen-specific colors from the supplied reference.
  static const _pageColor = Color(0xFFF4FAF6);
  static const _fieldColor = Color(0xFFF8F5F0);
  static const _greenColor = Color(0xFF2E7D32);
  static const _linkColor = Color(0xFF806B43);

  InputDecoration _loginInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF94948E), fontSize: 18),
      filled: true,
      fillColor: _fieldColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xFFD6D9D2)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xFFD6D9D2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xFFD9CEB8), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }

  void _showResetPassword() {
    DialogHelper.forgotPasswordDialog(
      context,
      _localizations,
      _localizations?.translate(AppStringConstant.forgotPasswordTitle) ?? '',
      _localizations?.translate(AppStringConstant.forgotPasswordMessage) ?? '',
      onConfirm: (email) {
        bloc?.add(ForgotPasswordEvent(email));
        bloc?.emit(LoadingState());
      },
      email: _emailController.text,
    );
  }

  Widget _buildContent() {
    return Scaffold(
      backgroundColor: _pageColor,
      appBar: AppBar(
        backgroundColor: _pageColor,
        foregroundColor: const Color(0xFF1C241D),
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Log in',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Form(
                key: _formKey,
                child: AutofillGroup(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF171D18),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _emailController,
                        enabled: !_loading,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.username],
                        autocorrect: false,
                        enableSuggestions: false,
                        cursorColor: _linkColor,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFF171D18),
                        ),
                        decoration: _loginInputDecoration('Email'),
                        validator: (value) {
                          final email = (value ?? '').trim();
                          if (email.isEmpty) return 'Please enter your email.';
                          if (!RegExp(
                            r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
                          ).hasMatch(email)) {
                            return 'Please enter a valid email address.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF171D18),
                              ),
                            ),
                          ),
                          Flexible(
                            child: TextButton(
                              onPressed: _loading ? null : _showResetPassword,
                              style: TextButton.styleFrom(
                                foregroundColor: _linkColor,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 12,
                                ),
                                textStyle: const TextStyle(fontSize: 14),
                              ),
                              child: const Text(
                                'Reset Password',
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: _passwordController,
                        enabled: !_loading,
                        obscureText: _obscureText,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [AutofillHints.password],
                        autocorrect: false,
                        enableSuggestions: false,
                        cursorColor: _linkColor,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFF171D18),
                        ),
                        decoration: _loginInputDecoration('Password'),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your password.'
                            : null,
                        onFieldSubmitted: (_) {
                          if (!_loading) _validateForm();
                        },
                      ),
                      const SizedBox(height: 36),
                      ElevatedButton(
                        onPressed: _loading ? null : _validateForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _greenColor,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: _greenColor.withOpacity(
                            0.35,
                          ),
                          disabledForegroundColor: Colors.white,
                          elevation: 0,
                          minimumSize: const Size(double.infinity, 48),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        child: const Text('Log in'),
                      ),
                      // if (model?.allowSignup ?? true) ...[
                       ...[
                        const SizedBox(height: 12),
                        Center(
                          child: TextButton(
                            onPressed: _loading
                                ? null
                                : () {
                                    Navigator.pop(context);
                                    signInSignUpBottomModalSheet(context, true);
                                  },
                            style: TextButton.styleFrom(
                              foregroundColor: _linkColor,
                              textStyle: const TextStyle(fontSize: 14),
                            ),
                            child: const Text("Don't have an account?"),
                          ),
                        ),
                      ],
                      if (AppSharedPref().getFingerPrintData() != null) ...[
                        const SizedBox(height: 16),
                        Center(
                          child: InkWell(
                            onTap: _loading
                                ? null
                                : () => startAuthentication(false),
                            child: Lottie.asset(
                              'lib/assets/lottie/finger_print.json',
                              width: 64,
                              height: 64,
                              fit: BoxFit.contain,
                              repeat: true,
                            ),
                          ),
                        ),
                      ],
                      if (_loading) ...[
                        const SizedBox(height: 16),
                        Center(child: Loader()),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //==========Update Session==========//
  void updateUserPreference(LoginResponseModel model) {
    AppSharedPref().setIfLogin(model.success);
    if (_passwordController.text.trim().isNotEmpty) {
      AppSharedPref().setCurrentPassword(_passwordController.text ?? "");
    }
    AppSharedPref().setUserData(
      UserDataModel(
        isEmailVerified: model.isEmailVerified,
        name: model.customerName,
        email: model.customerEmail,
        bannerImage: model.customerBannerImage,
        profileImage: model.customerProfileImage,
        cartCount: model.cartCount,
        customerId: model.customerId,
        isSeller: model.isSeller,
      ),
    );
  }

  //================Handle Fingerprint Login==============//
  final LocalAuthentication auth = LocalAuthentication(); //----Initialization
  void checkFingerprint() {
    auth.isDeviceSupported().then((value) {
      if (value) {
        debugPrint("$value");
        auth.getAvailableBiometrics().then((value) {
          debugPrint("face----------->${value.contains(BiometricType.face)}");
          debugPrint(
            "fingerprint----------->${value.contains(BiometricType.fingerprint)}",
          );

          if (value.contains(BiometricType.fingerprint)) {
            showFingerprintDialog();
          } else {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(navBar, (route) => false, arguments: 0);
          }
        });
      } else {
        print("Else Condition");
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(navBar, (route) => false, arguments: 0);
      }
    });
  }

  void showFingerprintDialog() async {
    DialogHelper.forgotPasswordDialog(
      context,
      _localizations,
      _localizations?.translate(AppStringConstant.fingerprintLogin) ?? "",
      _localizations?.translate(AppStringConstant.fingerprintLoginDialog) ?? "",
      onConfirm: (data) {
        startAuthentication(true);
      },
      onCancel: (value) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(navBar, (route) => false, arguments: 0);
      },
      isForgotPassword: false,
      email: "",
    );
  }

  void startAuthentication(bool alreadyLogin) async {
    auth.isDeviceSupported().then((value) async {
      if (value) {
        bool didAuthenticate = await auth.authenticate(
          localizedReason:
              _localizations?.translate(AppStringConstant.fingerprintLogin) ??
              '',
        );
        if (didAuthenticate) {
          if (alreadyLogin) {
            Map<String, dynamic> header = {};
            header["login"] = _emailController.text;
            header["pwd"] = _passwordController.text;
            String key = generateEncodedApiKey(json.encode(header));
            AppSharedPref().setFingerPrintData(key);
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(navBar, (route) => false, arguments: 0);
          } else {
            bloc?.add(
              FingerprintLoginEvent(AppSharedPref().getFingerPrintData() ?? ""),
            );
            bloc?.emit(LoadingState());
          }
        } else {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(
              _localizations?.translate(
                    AppStringConstant.authenticationFailed,
                  ) ??
                  '',
              context,
            );
          });
        }
      } else {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          AlertMessage.showError(
            _localizations?.translate(AppStringConstant.authenticationUnable) ??
                '',
            context,
          );
        });
      }
    });
  }
}
