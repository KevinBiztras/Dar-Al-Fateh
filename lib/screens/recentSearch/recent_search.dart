import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

import '../../helper/app_shared_pref.dart';

class RecentSearch extends StatefulWidget {
  final Function(String)? onItemSelected;
  final List<String>? recentSearch;

  const RecentSearch({Key? key, this.onItemSelected,this.recentSearch}) : super(key: key);

  @override
  State<RecentSearch> createState() => _RecentSearchState();
}

class _RecentSearchState extends State<RecentSearch> {
  List<String> recentSearch = [];

  @override
  void initState() {
    // TODO: implement initState
    recentSearch = widget.recentSearch ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: recentSearch.isNotEmpty,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(
                      context,
                    )?.translate(AppStringConstant.recentSearch) ??
                    "",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: () {
                  AppSharedPref().clearAllSearches();
                  setState(() {
                    recentSearch = AppSharedPref().getRecentSearches();
                  });
                },
                child: Text(
                  AppLocalizations.of(
                        context,
                      )?.translate(AppStringConstant.clearAll) ??
                      "",

                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: recentSearch.isNotEmpty,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recentSearch.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 6),
                    InkWell(
                      onTap: () {
                        if (widget.onItemSelected != null) {
                          widget.onItemSelected!(recentSearch[index]);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recentSearch[index],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          InkWell(
                            onTap: () {
                              AppSharedPref().removeSearchItem(
                                recentSearch[index],
                              );
                              setState(() {
                                recentSearch = AppSharedPref()
                                    .getRecentSearches();
                              });
                            },
                            child: Icon(
                              CupertinoIcons.clear_circled,
                              size: 17,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
