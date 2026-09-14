import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../config/theme.dart';
import '../constants/app_constants.dart';
import '../constants/app_string_constant.dart';
import '../helper/alert_message.dart';
import '../helper/app_localizations.dart';
import '../screens/orders/bloc/order_screen_bloc.dart';
import '../screens/orders/bloc/order_screen_repository.dart';
import '../screens/orders/views/reorder_screen.dart';
import 'common_text_field.dart';

class DialogHelper {
  // Common button style
  static ButtonStyle _dialogButtonStyle = TextButton.styleFrom(
    backgroundColor: AppColors.black,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  );

  static Future<void> quantityDialog(
      BuildContext context,
      AppLocalizations? localizations, {
        ValueChanged<String>? onSave,
        String? initialValue,
      }) {
    final controller = TextEditingController(text: initialValue ?? "0");
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(localizations?.translate(AppStringConstant.enterQuantity) ?? ""),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: localizations?.translate(AppStringConstant.quantity) ?? "",
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: TextButton(
              style: _dialogButtonStyle,
              onPressed: () => Navigator.pop(ctx),
              child: Text(localizations?.translate(AppStringConstant.cancel) ?? "", style: const TextStyle(color: AppColors.white)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0,bottom: 12.0),
            child: TextButton(
              style: _dialogButtonStyle,
              onPressed: () {
                onSave?.call(controller.text.trim());
                Navigator.pop(ctx);
              },
              child: Text(localizations?.translate(AppStringConstant.save) ?? "", style: const TextStyle(color: AppColors.white)),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> confirmationDialog(
      String text,
      BuildContext context,
      AppLocalizations? localizations, {
        VoidCallback? onConfirm,
        VoidCallback? onCancel,
        bool barrierDismissible = false,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (ctx) => AlertDialog(
        title: Text(localizations?.translate(text) ?? ""),
        actions: [
          TextButton(
            style: _dialogButtonStyle,
            onPressed: () {
              Navigator.pop(ctx);
              onCancel?.call();
            },
            child: Text(localizations?.translate(AppStringConstant.cancel) ?? "", style: const TextStyle(color: AppColors.white)),
          ),
          TextButton(
            style: _dialogButtonStyle,
            onPressed: () {
              Navigator.pop(ctx);
              onConfirm?.call();
            },
            child: Text(
              (localizations?.translate(AppStringConstant.ok) ?? "")
                  .toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> reorderDialog(
      String id,
      BuildContext context, {
        bool barrierDismissible = false,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (ctx) => BlocProvider(
        create: (_) => OrderScreenBloc(repository: OrderScreenRepositoryImp()),
        child: ReorderDialog(id: id),
      ),
    );
  }

  static Future<void> locationPermissionDialog(
      String text,
      BuildContext context,
      AppLocalizations? localizations, {
        VoidCallback? onConfirm,
      }) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(localizations?.translate(AppStringConstant.userYourLocation) ?? ""),
        content: Text(localizations?.translate(text) ?? ""),
        actions: [
          TextButton(
            style: _dialogButtonStyle,
            onPressed: () => Navigator.pop(ctx),
            child: Text(localizations?.translate(AppStringConstant.cancel) ?? "", style: const TextStyle(color: AppColors.white)),
          ),
          TextButton(
            style: _dialogButtonStyle,
            onPressed: () {
              Navigator.pop(ctx);
              onConfirm?.call();
            },
            child: Text(localizations?.translate(AppStringConstant.ok) ?? "", style: const TextStyle(color: AppColors.white)),
          ),
        ],
      ),
    );
  }

  static Future<void> showExceptionDialog(
      String text,
      BuildContext context, {
        VoidCallback? onConfirm,
        String? buttonText,
      }) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(text),
        actions: [
          TextButton(
            style: _dialogButtonStyle,
            onPressed: () {
              Navigator.pop(ctx);
              onConfirm?.call();
            },
            child: Text(buttonText ?? 'Retry', style: const TextStyle(color: AppColors.white)),
          ),
        ],
      ),
    );
  }

static Future<void> forgotPasswordDialog(
  BuildContext context,
  AppLocalizations? localizations,
  String title,
  String message, {
  ValueChanged<String>? onConfirm,
  ValueChanged<bool>? onCancel,
  bool isForgotPassword = true,
  String email = "",
}) {
  final controller = TextEditingController(text: email);

  const pageColor = Color(0xFFF4FAF6);
  const fieldColor = Color(0xFFF8F5F0);
  const greenColor = Color(0xFF2E7D32);
  const linkColor = Color(0xFF806B43);
  const textColor = Color(0xFF1C241D);

  final fieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(
      color: Color(0xFFD6D9D2),
    ),
  );

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      backgroundColor: pageColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      titlePadding: const EdgeInsets.fromLTRB(24, 28, 24, 12),
      contentPadding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: textColor,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: const TextStyle(
                color: textColor,
                fontSize: 15,
                height: 1.5,
              ),
            ),
            if (isForgotPassword) ...[
              const SizedBox(height: 24),
              Text(
                localizations?.translate(
                      AppStringConstant.emailAddress,
                    ) ??
                    "",
                style: const TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                cursorColor: textColor,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  hintText: localizations?.translate(
                    AppStringConstant.emailAddress,
                  ),
                  hintStyle: const TextStyle(
                    color: Color(0xFF94948E),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: fieldColor,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: fieldBorder,
                  enabledBorder: fieldBorder,
                  focusedBorder: fieldBorder.copyWith(
                    borderSide: const BorderSide(
                      color: Color(0xFFD9CEB8),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      actions: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: greenColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                if (isForgotPassword && controller.text.isEmpty) {
                  AlertMessage.showError(
                    localizations?.translate(
                          AppStringConstant.invalidEmail,
                        ) ??
                        '',
                    context,
                  );
                  return;
                }
                Navigator.pop(ctx);
                onConfirm?.call(controller.text.trim());
              },
              child: Text(
                localizations?.translate(AppStringConstant.ok) ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: linkColor,
                minimumSize: const Size(double.infinity, 44),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(ctx);
                onCancel?.call(true);
              },
              child: Text(
                localizations?.translate(AppStringConstant.cancel) ?? "",
                style: const TextStyle(
                  color: linkColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
  static Future<void> searchDialog(
      BuildContext context,
      AppLocalizations? localizations,
      GestureTapCallback onImageTap,
      GestureTapCallback onTextTap,
      ) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(localizations?.translate(AppStringConstant.searchByScanning) ?? ""),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(leading: const Icon(Icons.format_color_text), title: Text(localizations?.translate(AppStringConstant.text) ?? ""), onTap: onTextTap),
            ListTile(leading: const Icon(Icons.image_search), title: Text(localizations?.translate(AppStringConstant.image) ?? ""), onTap: onImageTap),
          ],
        ),
      ),
    );
  }

  static Future<void> signUpTerms(String data, BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: SingleChildScrollView(child: HtmlWidget(data)),
        actions: [
          TextButton(
            style: _dialogButtonStyle,
            onPressed: () => Navigator.pop(ctx),
            child: const Text("OK", style: TextStyle(color: AppColors.white)),
          ),
        ],
      ),
    );
  }

  static Future<void> deleteAccountConfirmationDialog(
      BuildContext context,
      String title,
      String description,
      Function(String)? onConfirm,
      AppLocalizations? localizations,
      ) {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(description),
              CommonTextField(
                hintText: localizations?.translate(AppStringConstant.password) ?? "",
                controller: controller,
                isRequired: true,
                isPassword: true,
                validationType: AppStringConstant.password,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            style: _dialogButtonStyle,
            onPressed: () => Navigator.pop(ctx),
            child: Text(localizations?.translate(AppStringConstant.cancel) ?? "", style: const TextStyle(color: AppColors.white)),
          ),
          TextButton(
            style: _dialogButtonStyle,
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                Navigator.pop(ctx);
                onConfirm?.call(controller.text.trim());
              }
            },
            child: Text(localizations?.translate(AppStringConstant.ok) ?? "", style: const TextStyle(color: AppColors.white)),
          ),
        ],
      ),
    );
  }

  static Future<void> accessDeniedDialog(
      String title,
      String text,
      BuildContext context,
      AppLocalizations? localizations, {
        VoidCallback? onConfirm,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(localizations?.translate(title) ?? ""),
        content: Text(localizations?.translate(text) ?? ""),
        actions: [
          TextButton(
            style: _dialogButtonStyle,
            onPressed: () {
              Navigator.pop(ctx);
              onConfirm?.call();
            },
            child: Text(localizations?.translate(AppStringConstant.ok) ?? "", style: const TextStyle(color: AppColors.white)),
          ),
        ],
      ),
    );
  }

  static Future<void> loaderDialog(
      String title,
      String description,
      BuildContext context,
      AppLocalizations? localizations,
      ) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(localizations?.translate(title) ?? ""),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             CircularProgressIndicator(color: MobikulTheme.clientAccentColor),
             SizedBox(height: 16),
            Text(
              localizations?.translate(description) ?? '',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
    );
  }
}
