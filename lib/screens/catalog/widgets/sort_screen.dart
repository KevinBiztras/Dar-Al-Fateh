import 'package:flutter/material.dart';
import 'package:flutter_project_structure/models/SplashScreenModel.dart';
import '../../../constants/app_string_constant.dart';
import '../../../customWidgtes/app_bar.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/app_shared_pref.dart';
import 'package:collection/collection.dart';

class CatalogSortPage extends StatefulWidget {
  final String? selectedSorting;

  const CatalogSortPage(this.selectedSorting);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CatalogSortState();
  }
}

class _CatalogSortState extends State<CatalogSortPage> {
  SortData? _selectValue;
  List<SortData>? sortData;

  @override
  void initState() {
    print("selectedSorting-->${widget.selectedSorting}");
    sortData = AppSharedPref().getSplashData()?.sortData;
    if (widget.selectedSorting?.isNotEmpty ?? false) {
      _selectValue = AppSharedPref()
          .getSplashData()
          ?.sortData
          ?.firstWhereOrNull((e) => e.code == "${widget.selectedSorting}");
    } else {
      _selectValue = AppSharedPref().getSplashData()?.sortData?.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: commonAppBar(
          "${AppLocalizations.of(context)?.translate(AppStringConstant.sort)}",
          context),
      body: ListView.builder(
          itemCount: AppSharedPref().getSplashData()?.sortData?.length ?? 0,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Radio<SortData>(
                  activeColor: Theme.of(context).colorScheme.onPrimary,
                  value: sortData![index],
                  groupValue: _selectValue,
                  onChanged: (value) {
                    setState(() {
                      _selectValue = value;
                      Navigator.pop(context, _selectValue?.code);
                    });
                  },
                ),
                Text(sortData?[index].label ?? ""),
              ],
            );
          }),
    );
  }
}
