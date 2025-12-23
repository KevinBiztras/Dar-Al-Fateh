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
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

import '../../../constants/app_constants.dart';
import '../../../customWidgtes/common_text_field.dart';
import '../../../models/CountryListModel.dart';

class CountryDropdown extends StatefulWidget {
  List<Countries>? countryList;
  int? selectedCountryId, selectedStateId;
  Function(int?, int?, bool) callback;

  CountryDropdown(this.countryList, this.selectedCountryId,
      this.selectedStateId, this.callback,
      {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CountryStateDropdownState();
  }
}

class _CountryStateDropdownState extends State<CountryDropdown> {
  Countries? selectedCountry;
  States? selectedState;
  AppLocalizations? localizations;
  final GlobalKey<FormFieldState>? _stateKey = GlobalKey();


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localizations = AppLocalizations.of(context);
  }

  void filterSelectedCountryState() {
    if (widget.selectedCountryId != null) {
      for (Countries cou in widget.countryList ?? []) {
        if (cou.id == widget.selectedCountryId) {
          widget.selectedCountryId = null;
          selectedCountry = cou;
          print('selected country------ ${selectedCountry?.name}');
          print('selected country------ ${cou.name}');
          if ((selectedCountry?.states ?? []).isNotEmpty) {
            for (States state in selectedCountry?.states ?? []) {
              if (state.id == widget.selectedStateId) {
                widget.selectedStateId = null;
                selectedState = state;
                break;
              }
            }
          }
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    filterSelectedCountryState();
    return Column(
      children: [
        DropdownButtonFormField<Countries>(
          elevation: 0,
          value: selectedCountry,
          menuMaxHeight: AppSizes.height / 2,
          // dropdownColor: ,
          decoration: formFieldDecoration(context, "", localizations?.translate(AppStringConstant.country) ?? '',
              isDense: true, isRequired: true),
          items: (widget.countryList ?? []).map((Countries optionData) {
            return DropdownMenuItem(
              child: Text(
                optionData.name ?? "",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              value: optionData,
            );
          }).toList(),
          onChanged: (value) {
            print('dadads---Edit');
            setState(() {
              selectedCountry = value;
              selectedState = null;
              _stateKey?.currentState?.reset();
              widget.callback(selectedCountry?.id, selectedState?.id,
                  (selectedCountry?.states ?? []).isNotEmpty);
            });
          },
          validator: (value) {
            if (value == null) {
              return localizations?.translate(AppStringConstant.required);
            }
          },
        ),
        const SizedBox(
          height: AppSizes.sidePadding,
        ),

        if ((selectedCountry?.states ?? []).isNotEmpty)
          DropdownButtonFormField<States>(
            key: _stateKey,
            elevation: 0,
            menuMaxHeight: AppSizes.height / 2,
            value: selectedState,
            // dropdownColor: MobikulTheme.lightGrey,
            decoration: formFieldDecoration(context, "", localizations?.translate(AppStringConstant.state) ?? '',
                isDense: true, isRequired: true),
            items: (selectedCountry?.states ?? []).map((States optionData) {
              return DropdownMenuItem(
                child: Text(
                  optionData.name ?? "",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: optionData,
              );
            }).toList(),
            onChanged: (value) {
              selectedState = value;
              print('selected state =========> $value');
              widget.callback(selectedCountry?.id, selectedState?.id, true);
            },
            validator: (value) {
              if (value == null) {
                return localizations?.translate(AppStringConstant.required);
              }
            },
          )
      ],
    );
  }
}
