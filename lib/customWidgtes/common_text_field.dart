/*
 * Webkul Software.
 * @package Mobikul App
 * @Category Mobikul
 * @author Webkul <support@webkul.com>
 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 * @license https://store.webkul.com/license.html ASL Licence
 * @link https://store.webkul.com/license.html
 */
// ignore_for_file: file_names, prefer_const_constructors
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_project_structure/config/theme.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/utils/validator.dart';

class CommonTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  String? labelText;
  final String? helperText;
  bool? isRequired;
  final TextInputType inputType;
  final String? validationType;
  final String? validationMessage;
  bool readOnly;
  bool? enable;
  bool? isDense;
  bool isPassword;
  Function(String)? onChange;
  int? maxLine;
  Function()? onEditingComplete;
  String? Function(String?)? validation;
  TextDirection? textDirection;

  // Presentation only; existing callers retain their original appearance.
  final bool useAccountStyle;

  CommonTextField(
      {required this.controller,
      required this.isPassword,
      this.hintText = '',
      this.labelText = '',
      this.helperText,
      this.isRequired = false,
      this.inputType = TextInputType.text,
      this.validationType,
      this.validationMessage = '',
      this.maxLine = 1,
      this.readOnly = false,
      this.enable = true,
      this.onChange,
      this.validation,
      this.textDirection,
      this.onEditingComplete,
      this.isDense = true,
      this.useAccountStyle = false});

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.isPassword ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final suffix = widget.isPassword
        ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: suffixIconColor(context),
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
        : null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.useAccountStyle) ...[
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              (widget.labelText ?? '').isNotEmpty
                  ? widget.labelText!
                  : (widget.hintText ?? ''),
              style: const TextStyle(
                color: Color(0xFF1C241D),
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 12),
        ] else if (widget.labelText != "")
          Row(
            children: [
              Text((widget.labelText ?? '') +
                  ((widget.isRequired ?? false) ? "*" : "")),
            ],
          ),
        TextFormField(
          textDirection: widget.textDirection,
          cursorColor: widget.useAccountStyle
              ? const Color(0xFF1C241D)
              : Theme.of(context).colorScheme.onPrimary,
          enabled: widget.enable,
          readOnly: widget.readOnly,
          maxLines: widget.maxLine,
          obscureText: _obscureText,
          keyboardType: widget.inputType,
          controller: widget.controller,
          style: widget.useAccountStyle
              ? const TextStyle(
                  color: Color(0xFF1C241D),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                )
              : Theme.of(context).textTheme.bodyLarge,
          onChanged: widget.onChange,
          onEditingComplete: widget.onEditingComplete,
          decoration: widget.useAccountStyle
              ? _accountDecoration(context, suffix)
              : formFieldDecoration(
                  context, widget.helperText, widget.hintText,
                  isRequired: widget.isRequired,
                  suffix: suffix,
                  isDense: widget.isDense,
                ),
          validator:
              ((widget.isRequired == true) && (widget.validation == null))
                  ? (value) {
                      if (widget.isRequired == true) {
                        if (value?.isEmpty ?? false) {
                          return (widget.validationMessage != '')
                              ? widget.validationMessage
                              : "${AppLocalizations.of(context)?.translate(AppStringConstant.required)}";
                        } else if (widget.validationType == AppStringConstant.email) {
                          return (Validator.isEmailValid(value ?? '') != null) ? AppLocalizations.of(context)?.translate(Validator.isEmailValid(value ?? '') ?? '') : null;
                        } else if (widget.validationType == AppStringConstant.password) {
                          return (Validator.isValidPassword(value ?? '') != null) ? AppLocalizations.of(context)?.translate(Validator.isValidPassword(value ?? '') ?? '') : null;
                        } else {
                          return null;
                        }
                      } else {
                        return null;
                      }
                    }
                  : widget.validation,
        ),
      ],
    );
  }

  InputDecoration _accountDecoration(BuildContext context, Widget? suffix) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: Color(0xFFD6D9D2)),
    );
    return InputDecoration(
      errorMaxLines: 3,
      isDense: widget.isDense,
      filled: true,
      fillColor: const Color(0xFFF8F5F0),
      hintText: widget.hintText,
      helperText: widget.helperText,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: const TextStyle(
        color: Color(0xFF94948E), fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      suffixIcon: suffix,
      border: border,
      enabledBorder: border,
      disabledBorder: border,
      focusedBorder: border.copyWith(
        borderSide: const BorderSide(color: Color(0xFFD9CEB8), width: 2),
      ),
      errorBorder: border.copyWith(
        borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
      ),
      focusedErrorBorder: border.copyWith(
        borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 2),
      ),
    );
  }
}

InputDecoration formFieldDecoration(
  BuildContext context,
  String? helperText,
  String? hintText, {
  bool? isDense = true,
  bool? isRequired,
  Widget? suffix,
}) {
  return InputDecoration(
    errorMaxLines: 3,
    isDense: isDense,
    hintText: helperText,
    labelText: (hintText ?? "") +
        ((isRequired ?? false) && (hintText != '') ? "*" : ""),
    hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
      fontWeight: FontWeight.normal,
    ),
    labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.normal,
        ),
    fillColor: MobikulTheme.primaryColor,
    suffixIcon: suffix,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: BorderSide(color: AppColors.black)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: BorderSide(color: AppColors.black)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: BorderSide(color: AppColors.black)),
  );
}

Color suffixIconColor(BuildContext context) {
  switch (Theme.of(context).brightness) {
    case Brightness.light:
      return Colors.grey.shade700;
    case Brightness.dark:
      return Colors.white70;
  }
}