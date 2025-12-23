import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import 'package:flutter_project_structure/screens/orders/bloc/order_screen_events.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_string_constant.dart';
import '../../../constants/route_constant.dart';
import '../../../helper/alert_message.dart';
import '../../../helper/app_localizations.dart';
import '../bloc/order_screen_bloc.dart';
import '../bloc/order_screen_state.dart';

class ReorderDialog extends StatefulWidget {
  final String ? id;

  const ReorderDialog({
    Key? key,
     this.id,
  }) : super(key: key);

  @override
  _ReorderDialogState createState() => _ReorderDialogState();
}

class _ReorderDialogState extends State<ReorderDialog> {
  int? selectedValue;
  AppLocalizations? localizations;
  OrderScreenBloc? orderScreenBloc;
  bool isLoading = false;
  bool ? mergeCart;

  @override
  void didChangeDependencies() {
    localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    orderScreenBloc = context.read<OrderScreenBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderScreenBloc, OrderScreenState>(
        builder: (context, currentState) {
      if (currentState is OrderScreenInitial) {
      } else if (currentState is ReorderStateSuccess) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          isLoading = false;
        AlertMessage.showSuccess(currentState.data.message ?? "", context);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(navBar, (route) => false,arguments: 2);
        });
      } else if (currentState is OrderScreenError) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          isLoading = false;
          AlertMessage.showError(currentState.message, context);
        });
      }
      return isLoading ? Loader() :
      AlertDialog(
        content: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  (localizations?.translate("alert") ?? "").toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: AppSizes.widgetSidePadding,
                ),
                Text(
                  localizations?.translate(AppStringConstant.mergeCartMsg)?? "",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: AppSizes.extraPadding,
                ),
                RadioListTile<int>(
                  activeColor: Theme.of(context).colorScheme.onPrimary,
                  title: Text(
                      localizations?.translate(AppStringConstant.mergeCart) ?? "",
                      style: Theme.of(context).textTheme.bodyLarge),
                  value: 1,
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                      mergeCart=true;
                    });
                  },
                ),
                RadioListTile<int>(
                  activeColor: Theme.of(context).colorScheme.onPrimary,
                  title: Text(
                    localizations?.translate(AppStringConstant.emptyOldCart) ?? "",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  value: 2,
                  groupValue: selectedValue,
                  subtitle: selectedValue == 2
                      ? Text(localizations
                              ?.translate(AppStringConstant.emptyOldCartSubtitle) ??
                          "")
                      : null,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                      mergeCart=false;
                    });
                  },
                ),
              ],
            ),
            Positioned(right:0,top:0,child: InkWell(onTap:(){
             Navigator.pop(context);
           },child: const Icon(Icons.highlight_remove,size: 20,)))
          ],
        ),
        actions: <Widget>[
          SizedBox(
            width: AppSizes.width,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSizes.extraPadding),
              child: ElevatedButton(
                onPressed: () {
                  if(mergeCart != null) {
                    isLoading = true;
                    orderScreenBloc?.add(ReorderEvent(widget.id ?? "0",  mergeCart ?? false));
                    setState(() {

                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  (localizations?.translate(AppStringConstant.ok) ?? "")
                      .toUpperCase(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondaryContainer,
                      ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
