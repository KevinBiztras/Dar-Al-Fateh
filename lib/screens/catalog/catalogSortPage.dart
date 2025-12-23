import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/models/SplashScreenModel.dart';

import '../../helper/app_shared_pref.dart';
import '../home/views/product_item_full_width.dart';

class CatalogSortPage extends StatefulWidget{
  final List<SortData>list;
  CatalogSortPage(this.list);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CatalogSortState();
  }
}

class _CatalogSortState extends State<CatalogSortPage> {
  int? _selectValue=0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title:Text("Sorted Items"),),
      body: ListView.builder(itemCount: AppSharedPref().getSplashData()?.sortData?.length ?? 0 ,itemBuilder: (context,index){
        List<SortData>? sortData = AppSharedPref().getSplashData()?.sortData;
        print("hello length:------*****************--------${sortData?.length.toString()}");
        // return data.length>0 ?Center(child: Text("Yess data is available"),) : Center(child: Text("No data is available"),);
        return Row(
          children: [
            Radio<int>( activeColor: Theme.of(context).colorScheme.onPrimary,
              value: index,
              groupValue: _selectValue,
              onChanged: (int? value) {
                setState(() {
                  _selectValue = value;
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