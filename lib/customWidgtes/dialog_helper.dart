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
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message),
            if (isForgotPassword)
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: localizations?.translate(AppStringConstant.emailAddress),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            style: _dialogButtonStyle,
            onPressed: () {
              if (isForgotPassword && controller.text.isEmpty) {
                AlertMessage.showError(localizations?.translate(AppStringConstant.invalidEmail) ?? '', context);
                return;
              }
              Navigator.pop(ctx);
              onConfirm?.call(controller.text.trim());
            },
            child: Text(localizations?.translate(AppStringConstant.ok) ?? "", style: const TextStyle(color: AppColors.white)),
          ),
          TextButton(
            style: _dialogButtonStyle,
            onPressed: () {
              Navigator.pop(ctx);
              onCancel?.call(true);
            },
            child: Text(localizations?.translate(AppStringConstant.cancel) ?? "", style: const TextStyle(color: AppColors.white)),
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
