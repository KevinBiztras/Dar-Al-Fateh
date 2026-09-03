

import 'package:flutter/cupertino.dart';
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
import '../constants/app_constants.dart';

AppBar commonAppBar(
  String heading,
  BuildContext context, {
  bool isHomeEnable = false,
  bool isElevated = true,
  bool isLeadingEnable = false,
  List<Widget>? actions,
  VoidCallback? onPressed,
}) {
  final bool isDark = Theme.of(context).brightness == Brightness.dark;

  // Brand palette — deep forest green anchor with a warm gold accent
  const Color _brandGreen = Color(0xFF1B5E20);
  const Color _brandGreenLight = Color(0xFF2E7D32);
  const Color _gold = Color(0xFFF9A825);
  const Color _onBrand = Colors.white;

  return AppBar(
    elevation: isElevated ? 0 : 0,
    // Flush the system status bar with our gradient
    // flexibleSpace: Container(
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //       colors: isDark
    //           ? [const Color(0xFF1A1A2E), const Color(0xFF16213E)]
    //           : [_brandGreen, _brandGreenLight],
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //     ),
    //     boxShadow: isElevated
    //         ? [
    //             BoxShadow(
    //               color: _brandGreen.withOpacity(0.35),
    //               blurRadius: 12,
    //               offset: const Offset(0, 4),
    //             ),
    //           ]
    //         : [],
    //   ),
    // ),
    backgroundColor: Colors.transparent,
    foregroundColor: _onBrand,
    // Leading: close icon or back arrow
    leading: isLeadingEnable
        ? IconButton(
            onPressed: onPressed,
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.clear, size: 18, color: _onBrand),
            ),
          )
        : null,
    titleSpacing: isLeadingEnable ? null : 16,
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isHomeEnable) ...[
          // Logo with a subtle circular backdrop
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            padding: const EdgeInsets.all(4),
            child: ClipOval(
              child: Image.asset(
                'lib/assets/images/df_logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                heading,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: _brandGreenLight,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                  height: 1.1,
                ),
              ),
              if (isHomeEnable)
                Text(
                  'Fresh & Organic',
                  style: TextStyle(
                    color: _gold,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
    actions: actions != null
        ? [
            ...actions.map(
              (action) => _StyledActionButton(child: action),
            ),
            const SizedBox(width: 4),
          ]
        : null,
  );
}

/// Wraps each action icon with a subtle circular frosted backing
/// so they feel cohesive against the gradient bar.
class _StyledActionButton extends StatelessWidget {
  final Widget child;
  const _StyledActionButton({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          shape: BoxShape.circle,
        ),
        child: Theme(
          // Force icon colour to white inside the tinted bubble
          data: Theme.of(context).copyWith(
            iconTheme: const IconThemeData(color: Colors.white, size: 20),
          ),
          child: child,
        ),
      ),
    );
  }
}