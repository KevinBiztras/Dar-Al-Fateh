import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/config/theme.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/app_bar.dart';
import 'package:flutter_project_structure/helper/loader.dart';
import '../../../constants/arguments_map.dart';
import '../../../models/FilterDataModel.dart';
import '../../../models/HomeScreenModel.dart';
import '../../catalog/bloc/catalog_screen_bloc.dart';

class SubCategoriesFilterScreen extends StatefulWidget {
  final Map<String, dynamic>? fetchFilterData;

  const SubCategoriesFilterScreen(this.fetchFilterData, {super.key});

  @override
  State<SubCategoriesFilterScreen> createState() =>
      _SubCategoriesFilterScreenState();
}

class _SubCategoriesFilterScreenState extends State<SubCategoriesFilterScreen> {
  bool isLoading = false;
  GetFilterAttribute? filterModel;
  CatalogScreenBloc? _filterBloc;
  int category = 0;
  int selectedCategoryList = 0;
  AttributeValue? selectedValue; // Default selected value
  double startPriceValue = 0, endPriceValue = 500;
  double? minPrice, maxPrice;
  RangeValues? _values;
  List<dynamic> filterList = [];

  List<List<int>> selectedData = [];

  @override
  void initState() {
    category = widget.fetchFilterData?[categoryIdKey] ?? 0;

    filterList = widget.fetchFilterData?[filterListKey] ?? [];

    // selectedValue =

    _filterBloc = context.read<CatalogScreenBloc>();
    _filterBloc?.add(
      FilterFetchDataEvent({
        "category_id": category,
        "filter": filterList,
        "max_price": widget.fetchFilterData?[maxPriceKey],
        "min_price": widget.fetchFilterData?[minPriceKey],
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: commonAppBar(
        "${AppLocalizations.of(context)?.translate(AppStringConstant.filterBy)}",
        context,
      ),
      body: BlocBuilder<CatalogScreenBloc, CatalogScreenState>(
        builder: (context, currentState) {
          if (currentState is CatalogScreenInitialState) {
            isLoading = true;
          } else if (currentState is FilterFetchState) {
            isLoading = false;
            filterModel = currentState.filterModel;
            startPriceValue = filterModel?.min_price ?? 0;
            endPriceValue = filterModel?.max_price ?? 500;
          }
          return SingleChildScrollView(child: _buildUI());
        },
      ),
      bottomSheet: __filterButton(context),
    );
  }

  Widget _buildUI() {
    return Stack(
      children: [
        Visibility(
          visible: filterModel != null,
          child: Column(
            children: [
              _categoriesTile(context, filterModel),
              if (filterModel?.is_price_filter_available ?? false)
                _rangeSlider(context, filterModel),
              _filterTile(context, filterModel),
              SizedBox(height: 70),
            ],
          ),
        ),
        Visibility(visible: isLoading, child: Loader()),
      ],
    );
  }

  Widget __filterButton(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: MobikulTheme.clientPrimaryColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context, {
                      "filter": filterList,
                      "category_id": category,
                      "max_price":
                          _values?.end.toString() ??
                          filterModel?.availableMaxPrice,
                      "min_price":
                          _values?.start.toString() ??
                          filterModel?.availableMinPrice,
                    });
                  },
                  icon: const Icon(Icons.filter_list, color: Colors.white),
                  label: Text(
                    "${AppLocalizations.of(context)?.translate(AppStringConstant.applyFilter)}",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: MobikulTheme.appbarTextColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                flex: 1,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: MobikulTheme.clientPrimaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      category = 0;
                      selectedData.clear();
                      filterList.clear();
                      _filterBloc?.add(
                        FilterFetchDataEvent(const {"category_id": 0}),
                      );
                    });
                  },
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: Text(
                    "${AppLocalizations.of(context)?.translate(AppStringConstant.resetFilter)}",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: MobikulTheme.appbarTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _rangeSlider(BuildContext context, GetFilterAttribute? filterModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          RangeSlider(
            min: filterModel?.availableMinPrice ?? 0,
            max: filterModel?.availableMaxPrice ?? 500,
            divisions: 10,
            activeColor: Colors.black,
            values:
                ((_values?.start ?? 0.0) >=
                        (filterModel?.availableMinPrice ?? 0) &&
                    (_values?.end ?? 0.0) <
                        (filterModel?.availableMaxPrice ?? 0))
                ? _values ?? RangeValues(startPriceValue, endPriceValue)
                : RangeValues(
                    filterModel?.availableMinPrice ?? 0,
                    filterModel?.availableMaxPrice ?? 500,
                  ),
            inactiveColor: Colors.grey,
            labels: RangeLabels(
              _values?.start.toString() ?? startPriceValue.toString(),
              _values?.end.toString() ?? endPriceValue.toString(),
            ),
            onChanged: (values) {
              setState(() {
                _values = values;
                startPriceValue = values.start;
                endPriceValue = values.end;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _values?.start.toString() ?? startPriceValue.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  _values?.end.toString() ?? endPriceValue.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _categoriesTile(BuildContext context, GetFilterAttribute? filterModel) {
    List<Widget> list = [];

    if (filterModel?.categories != null &&
        (filterModel?.categories?.length ?? 0) > 0) {
      filterModel?.categories?.forEach((value) {
        if (value.children != null && (value.children?.length ?? 0) > 0) {
          list.add(_expansionTile(context, value, value, 0));
        } else {
          list.add(_simpleTile(context, value));
        }
      });
    }
    return Column(children: list);
  }

  _filterTile(BuildContext context, GetFilterAttribute? filterModel) {
    List<Widget> list = [];

    if (filterModel?.filters != null &&
        (filterModel?.filters?.length ?? 0) > 0) {
      filterModel?.filters?.forEach((value) {
        if (value.attributeValue != null &&
            (value.attributeValue?.length ?? 0) > 0) {
          if (value.displayType == "select") {
            var selectedValue = value.attributeValue?.firstWhere(
              (item) => filterList.any(
                (filter) => filter[0] == value.id && filter[1] == item.id,
              ),
              orElse: () => value.attributeValue!.first,
            );
            list.add(
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value.name ?? "",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                    SizedBox(height: 8),
                    Theme(
                      data: ThemeData().copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        // Adjust width as needed
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          // Background color
                          borderRadius: BorderRadius.circular(4),
                          // Rounded corners
                          border: Border.all(
                            color: Colors.grey,
                          ), // Border color
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          onChanged: (newValue) {
                            setState(() {
                              selectedValue = newValue;
                              int index = filterList.indexWhere(
                                (item) => item[0] == value.id,
                              );

                              if (index != -1) {
                                filterList[index] = [value.id, newValue.id];
                              } else {
                                filterList.add([value.id, newValue.id]);
                              }

                              print("filterList-->$filterList");
                            });
                          },
                          value: selectedValue,
                          items: value.attributeValue?.map<DropdownMenuItem>((
                            value,
                          ) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value.name ?? "",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.color,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            list.add(_expansionFilterTile(context, value, 16));
          }
        }
      });
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: list);
  }

  _expansionTile(
    BuildContext context,
    val,
    Categories? categories,
    double padding,
  ) {
    List<Widget> child = [];
    if (val.children != null && val.children.length > 0) {
      val.children.forEach((value) {
        if (value.children != null && (value.children.length ?? 0) > 0) {
          child.add(_expansionTile(context, value, categories, 16));
        } else {
          child.add(
            _childTile(
              context,
              value,
              categories?.displayType,
              val.name,
              val.categoryId,
            ),
          );
        }
      });
    } else {
      val.children.forEach((value) {
        child.add(
          _childTile(
            context,
            value,
            categories?.displayType,
            val.name,
            val.categoryId,
          ),
        );
      });
    }
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: Padding(
        padding: EdgeInsets.only(left: padding),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: ExpansionTile(
            leading: Radio<int>(
              activeColor: Theme.of(context).colorScheme.onPrimary,
              value: val.categoryId,
              groupValue: category,
              onChanged: (int? value) {
                _values = null;
                selectedCategoryList = val.categoryId;
                _filterBloc?.emit(CatalogScreenInitialState());
                _filterBloc?.add(
                  FilterFetchDataEvent({"category_id": val.categoryId}),
                );
                category = val.categoryId;
                setState(() {});
              },
            ),
            title: Row(
              children: [
                Text(
                  "${val.name} ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                Text(
                  val.children.length != 0
                      ? "(${val.children.length.toString()})"
                      : "" ?? "",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
            children: child,
          ),
        ),
      ),
    );
  }

  _expansionFilterTile(BuildContext context, val, double padding) {
    List<Widget> child = [];

    if (val.attributeValue != null && val.attributeValue.length > 0) {
      val.attributeValue.forEach((value) {
        if (value.attributeValue != null &&
            (value.attributeValue.length ?? 0) > 0) {
          child.add(_expansionFilterTile(context, value, 0));
        } else {
          child.add(
            _childTile(context, value, val.displayType, val.name, val.id),
          );
        }
      });
    } else {
      val.attributeValue.forEach((value) {
        child.add(
          _childTile(context, value, val.displayType, val.name, val.id),
        );
      });
    }
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: Padding(
        padding: EdgeInsets.only(left: padding),
        child: ExpansionTile(
          title: Row(
            children: [
              Text(
                val.name ?? "",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              Text(
                "  (${val.attributeValue.length})",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
          children: child,
        ),
      ),
    );
  }

  ListTile _simpleTile(BuildContext context, val) {
    return ListTile(
      leading: val.displayType != "checkbox"
          ? Radio<int>(
              activeColor: Theme.of(context).colorScheme.onPrimary,
              value: val.categoryId,
              groupValue: category,
              onChanged: (int? value) {
                _values = null;
                selectedCategoryList = val.categoryId;
                _filterBloc?.emit(CatalogScreenInitialState());
                _filterBloc?.add(
                  FilterFetchDataEvent({"category_id": val.categoryId}),
                );
                setState(() {
                  category = val.categoryId;
                });
              },
            )
          : Checkbox(
              activeColor: Theme.of(context).colorScheme.onPrimary,
              value: filterList.any((item) => item[1] == val.id),
              onChanged: (bool? value) {
                setState(() {});
              },
            ),
      title: Row(
        children: [
          Text(
            "${val.name}  " ?? "",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ],
      ),
    );
  }

  _childTile(BuildContext context, val, value, title, parentId) {
    return ListTile(
      onTap: () {},
      title: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Row(
          children: [
            value != "checkbox"
                ? Radio<int>(
                    activeColor: Theme.of(context).colorScheme.onPrimary,
                    value: val is AttributeValue ? val.id : val.categoryId,
                    groupValue: category,
                    onChanged: (int? selectedValue) {
                      _values = null;
                      selectedCategoryList = val is AttributeValue
                          ? val.id
                          : val.categoryId;
                      _filterBloc?.emit(CatalogScreenInitialState());
                      _filterBloc?.add(
                        FilterFetchDataEvent({
                          "category_id": val is AttributeValue
                              ? val.id
                              : val.categoryId,
                        }),
                      );
                      setState(() {
                        category = val is AttributeValue
                            ? val.id
                            : val.categoryId;
                      });
                    },
                  )
                : Checkbox(
                    activeColor: Theme.of(context).colorScheme.onPrimary,
                    value: filterList.any((item) => item[1] == val.id),
                    onChanged: (bool? isChecked) {
                      setState(() {
                        if (isChecked != null && isChecked) {
                          // if (filterList.contains(val.id)) {
                          filterList.add([parentId, val.id]);
                        } else {
                          filterList.removeWhere((item) => item[1] == val.id);
                        }
                        val.isChecked = isChecked ?? false;
                      });
                    },
                  ),
            title != "Color"
                ? Row(
                    children: [
                      Text(
                        val.name ?? "",
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      Text(
                        (val is AttributeValue
                                        ? val.attributeValue?.length
                                        : val.children.length) !=
                                    null &&
                                (val is AttributeValue
                                        ? val.attributeValue?.length
                                        : val.children.length) !=
                                    0
                            ? "  (${(val is AttributeValue ? val.attributeValue?.length : val.children.length).toString()})"
                            : '' ?? "",
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor:
                              (val.colorCode != null && val.colorCode != "")
                              ? Color(
                                  int.parse(
                                    "${val.colorCode}".replaceAll("#", "0xFF"),
                                  ),
                                )
                              : Colors.transparent,
                        ),
                      ),
                      Text(
                        val.name ?? "",
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
