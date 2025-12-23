import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import '../../config/theme.dart';
import '../../constants/app_constants.dart';
import '../../constants/route_constant.dart';
import '../../customWidgtes/circle_page_indicator.dart';
import '../../helper/app_shared_pref.dart';
import '../../helper/image_view.dart';
import '../../models/walkThroughModel.dart';

 class WalkThroughScreen extends StatefulWidget {
   final  WalkThroughModel? walkViewThroughModel;
  const WalkThroughScreen({Key? key, this.walkViewThroughModel}) : super(key: key);

  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  final _currentPageNotifier = ValueNotifier<int>(0);
  bool flag = false;
  int showDescIndexValue = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_buildUI()
    );
  }

  Widget _buildUI() {
    return Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        color: MobikulTheme.lightGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          const SizedBox(height: 20,),
        Column(
          children: [
            _buildPageView(),
            const SizedBox(
              height: AppSizes.mediumPadding,),
            SizedBox(
              width: AppSizes.height,
              child: Center(
                child: _buildCircularindicator(_currentPageNotifier),
              ),
            ),
          ],
        ),
        if (_currentPageNotifier.value==(int.parse("${widget.walkViewThroughModel?.
        walkThroughData?.length}") - 1))  Column(
    children: [
    SizedBox(
      width: AppSizes.width,
      height: AppSizes.itemHeight,
      child: Padding(
      padding:  const EdgeInsets.fromLTRB(19.0,0,19.0,0.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary),
        onPressed: () {
          AppSharedPref().setShowWalkThrough(false);
          AppSharedPref().getIfLogin() ?? false
              ? Navigator.pushReplacementNamed(context,navBar,arguments: 0):
          Navigator.pushReplacementNamed(context, loginSignup,
              arguments: true);
      }, child:  Text( AppLocalizations.of(context)?.translate(AppStringConstant.continueWalkThrough) ?? "",style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.secondaryContainer),),)),
    ),

    ],
    ) else textButton()
    ],
    ));
  }

  Widget _buildPageView() {
    return
      SizedBox(
          height: AppSizes.height / 2.8 + 200,
          child: CarouselSlider.builder(
              itemCount: widget.walkViewThroughModel?.walkThroughData?.length,
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentPageNotifier.value = index;
                    showDescIndexValue = index;
                    flag = !flag;

                  });
                },
                enlargeCenterPage: true,
                height: AppSizes.height / 2.8 + 250,
                viewportFraction: 0.8,
                enableInfiniteScroll: false,
              ),
              itemBuilder: (context, index, i) {
                return
                  InkWell(
                      onTap: () {},
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  30, 40, 30, 15.0),
                              child: SizedBox(
                                height: AppSizes.height / 2.8,
                                width: AppSizes.width / 1.5,
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ImageView(
                                    url: widget.walkViewThroughModel
                                        ?.walkThroughData?[index].image ?? "",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: AppSizes.width / 1.8,
                              child: Text(
                                  widget.walkViewThroughModel?.walkThroughData?[index]
                                      .title ?? "",
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: const TextStyle(color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                            const SizedBox(height: 10),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(AppSizes.widgetSidePadding,0,AppSizes.widgetSidePadding,0),
                            child: ((widget.walkViewThroughModel?.walkThroughData?[index]
                                .description!
                                .length ??
                                0) <
                                150)
                                ? SizedBox(
                              width: AppSizes.width / 2,
                              child: Text(
                                  widget.walkViewThroughModel?.walkThroughData?[index]
                                      .description ??
                                      "",
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14)),
                            )
                                : Column(
                              children: <Widget>[
                                Text(
                             (widget.walkViewThroughModel?.walkThroughData![index]
                                .description ?? ""),
                                    maxLines: (flag) ? 3 : 10000,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                   ),
                                if ((widget.walkViewThroughModel?.walkThroughData?[index]
                                    .description
                                    ?.length ??
                                    0) >
                                    170) ...[
                                  Visibility(
                                    visible: ((flag && showDescIndexValue == index)),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            child: Text(
                                              ((flag && showDescIndexValue == index))
                                                  ? AppLocalizations.of(context)?.translate(AppStringConstant.showMore) ?? ""
                                                  : AppLocalizations.of(context)?.translate(AppStringConstant.showLess) ?? "",
                                              style: const TextStyle(
                                                  color: Colors.blue),
                                            ),
                                            onTap: () {
                                              setState(() {
                                                showDescIndexValue = index;
                                                flag = !flag;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ]
                              ],
                            ),
                          ),
                        ),
                      ),
                      if ((widget.walkViewThroughModel?.walkThroughData![index]
                      .description
                      ?.length ??
                      0) >
                170) ...[
                Visibility(
                visible: ((!flag && showDescIndexValue == index)),
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                InkWell(
                child: Text(
                ((flag && showDescIndexValue == index))
                ? AppLocalizations.of(context)?.translate(AppStringConstant.showMore) ?? ""
                    : AppLocalizations.of(context)?.translate(AppStringConstant.showLess) ?? "",
                style: const TextStyle(
                color: Colors.blue),
                ),
                onTap: () {
                setState(() {
                showDescIndexValue = index;
                flag = !flag;
                });
                },
                ),


                ],
                        ),

                      ))]])));
              }
          )
      );
  }

  Widget textButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(19.0, 0, 19.0, 0.0),
          child: SizedBox(
            height: AppSizes.itemHeight,
            child: TextButton(
              onPressed: () {
                AppSharedPref().setShowWalkThrough(false);
                AppSharedPref().getIfLogin() ?? false
                    ? Navigator.pushReplacementNamed(context,navBar,arguments: 0):
                Navigator.pushReplacementNamed(context, loginSignup,
                    arguments: true);
              },
              style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                  side: BorderSide(width: 1.5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      AppLocalizations.of(context)?.translate(AppStringConstant.skip) ?? "",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge,
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 10)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCircularindicator(_currentPageNotifier) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: CirclePageIndicator(
        dotColor: AppColors.lightGray.withOpacity(0.1),
        selectedDotColor: Theme
            .of(context)
            .bottomAppBarTheme
            .color ?? Colors.white,
        itemCount: widget.walkViewThroughModel?.walkThroughData?.length,
        currentPageNotifier: _currentPageNotifier,
      ),
    );
  }
}
