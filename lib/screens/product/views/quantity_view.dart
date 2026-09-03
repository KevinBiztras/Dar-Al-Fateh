

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
import 'package:flutter/services.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

import '../bloc/product_screen_bloc.dart';
import '../bloc/product_screen_event.dart';
import '../bloc/product_screen_state.dart';

class QuantityView extends StatefulWidget {
  ValueChanged<int>? callBack;
  ProductScreenBloc? bloc;
  int? counter;

  QuantityView({this.callBack, this.bloc, this.counter});

  @override
  State<StatefulWidget> createState() {
    return _QuantityViewState();
  }
}

class _QuantityViewState extends State<QuantityView> {
  AppLocalizations? _localizations;
  late int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.counter ?? 1;
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  String get _unitLabel {
    if (_counter > 1) {
      return _localizations?.translate(AppStringConstant.units) ?? 'Units';
    }
    return _localizations?.translate(AppStringConstant.unit) ?? 'Unit';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.cardColor,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Label
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _localizations?.translate(AppStringConstant.quantity) ??
                    'Quantity',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 2),
              Text(
                '$_counter $_unitLabel',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          // Pill counter
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary.withOpacity(0.07),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: theme.colorScheme.onPrimary.withOpacity(0.15),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Decrement
                _CounterButton(
                  icon: Icons.remove,
                  onTap: () {
                    if (_counter > 1) {
                      setState(() => _counter--);
                      _changeQty(_counter);
                    }
                  },
                  enabled: _counter > 1,
                ),

                // Count display
                SizedBox(
                  width: 44,
                  child: Center(
                    child: Text(
                      '$_counter',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                // Increment
                _CounterButton(
                  icon: Icons.add,
                  onTap: () {
                    setState(() => _counter++);
                    _changeQty(_counter);
                  },
                  enabled: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _changeQty(int counter) {
    widget.bloc?.add(QuantityUpdateEvent(counter));
    widget.bloc?.emit(ProductScreenInitial());
    widget.callBack?.call(counter);
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;

  const _CounterButton({
    required this.icon,
    required this.onTap,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    final color = enabled
        ? Theme.of(context).colorScheme.onPrimary
        : Colors.grey[300]!;
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: enabled
              ? Theme.of(context).colorScheme.onPrimary
              : Colors.grey[200],
        ),
        child: Icon(
          icon,
          size: 18,
          color: enabled
              ? Theme.of(context).colorScheme.secondaryContainer
              : Colors.grey[400],
        ),
      ),
    );
  }
}
