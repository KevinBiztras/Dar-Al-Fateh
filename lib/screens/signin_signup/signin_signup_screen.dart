

/**
 * Webkul Software.
 * @package Mobikul App
 * @Category Mobikul
 * @author Webkul <support@webkul.com>
 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 * @license https://store.webkul.com/license.html ASL Licence
 * @link https://webkul.com
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/constants/route_constant.dart';
import 'package:flutter_project_structure/helper/alert_message.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/helper/app_shared_pref.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/helper/open_bottom_model_sheet.dart';
import 'package:flutter_project_structure/models/SignUpScreenModel.dart';
import 'package:flutter_project_structure/models/SplashScreenModel.dart';
import 'package:flutter_project_structure/screens/signin_signup/bloc/signin_signup_screen_bloc.dart';

class SignInSignUpScreen extends StatefulWidget {
  bool fromsplash = false;

  SignInSignUpScreen(this.fromsplash, {Key? key}) : super(key: key);

  @override
  _SignInSignUpScreenState createState() => _SignInSignUpScreenState();
}

class _SignInSignUpScreenState extends State<SignInSignUpScreen> {
  AppLocalizations? _localizations;
  SigninSignupScreenBloc? bloc;
  late bool _loading;
  SplashScreenModel? model;

  // Same palette as the email login screen.
  static const _pageColor = Color(0xFFF4FAF6);
  static const _greenColor = Color(0xFF2E7D32);
  static const _linkColor = Color(0xFF806B43);
  static const _textColor = Color(0xFF1C241D);

  @override
  void initState() {
    super.initState();
    bloc = context.read<SigninSignupScreenBloc>();
    _loading = false;
    model = AppSharedPref().getSplashData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = AppLocalizations.of(context);
  }

  void _goBack() {
    if (widget.fromsplash) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        navBar,
        (route) => false,
        arguments: 0,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninSignupScreenBloc, SigninSignupScreenState>(
      builder: (context, state) {
        if (state is LoadingState) {
          _loading = true;
        } else if (state is SigninSignupScreenError) {
          _loading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            if (!mounted) return;
            AlertMessage.showError(state.message ?? '', context);
          });
        } else if (state is SignupScreenFormSuccess) {
          _loading = false;
          SignUpScreenModel response = state.data;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            if (!mounted) return;
            AlertMessage.showSuccess(response.message ?? '', context);
            AppSharedPref().setIfLogin(response.success);
            if (AppSharedPref().getSplashData()?.allowGuestCheckout ?? false) {
              bloc?.add(const GetMergeCartEvent());
            }
            Navigator.pushNamedAndRemoveUntil(
              context,
              navBar,
              (route) => false,
              arguments: 0,
            );
          });
        }
        return Stack(children: <Widget>[_buildUI(), if (_loading) Loader()]);
      },
    );
  }

  Widget _buildUI() {
    final allowSignup = model?.allowSignup ?? true;
    final allowGuestCheckout = model?.allowGuestCheckout ?? false;
    final title =
        _localizations?.translate(AppStringConstant.signInOrRegister) ??
        'Sign in or register';

    return Scaffold(
      backgroundColor: _pageColor,
      appBar: AppBar(
        backgroundColor: _pageColor,
        foregroundColor: _textColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: allowGuestCheckout
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                onPressed: _loading ? null : _goBack,
              )
            : null,
        title: Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Fill tall screens, but allow scrolling on short screens and
            // when accessibility text sizes increase.
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 520,
                    minHeight: constraints.maxHeight > 40
                        ? constraints.maxHeight - 40
                        : 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 48),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                'lib/assets/images/appIconLarge.png',
                              ),
                              radius: 50,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              _localizations?.translate(
                                    AppStringConstant.APPNAME,
                                  ) ??
                                  '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: _textColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: _textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _loading
                                ? null
                                : () {
                                    signInSignUpBottomModalSheet(
                                      context,
                                      false,
                                    );
                                  },
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
                                horizontal: 16,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            child: Text(
                              _localizations?.translate(
                                    AppStringConstant.signInWithEmail,
                                  ) ??
                                  'Sign in with email',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // if (allowSignup) ...[
                          ...[
                            const SizedBox(height: 12),
                            Center(
                              child: TextButton(
                                onPressed: _loading
                                    ? null
                                    : () {
                                        signInSignUpBottomModalSheet(
                                          context,
                                          true,
                                        );
                                      },
                                style: TextButton.styleFrom(
                                  foregroundColor: _linkColor,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                child: Text(
                                  _localizations?.translate(
                                        AppStringConstant.createAnAccount,
                                      ) ??
                                      'Create an account',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                          const SizedBox(height: 16),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
