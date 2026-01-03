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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/config/theme.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/badge_icon.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';
import 'package:flutter_project_structure/models/UserDataModel.dart';
import 'package:flutter_project_structure/screens/bottomNavigationBar/bloc/nav_bar_cubit.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_bloc.dart';
import 'package:flutter_project_structure/screens/cart/bloc/cart_screen_repository.dart';
import 'package:flutter_project_structure/screens/cart/cart_screen.dart';
import 'package:flutter_project_structure/screens/category/bloc/category_screen_bloc.dart';
import 'package:flutter_project_structure/screens/category/bloc/category_screen_repository.dart';
import 'package:flutter_project_structure/screens/category/category_screen.dart';
import 'package:flutter_project_structure/screens/home/bloc/home_screen_bloc.dart';
import 'package:flutter_project_structure/screens/home/bloc/home_screen_repository.dart';
import 'package:flutter_project_structure/screens/home/home_screen.dart';
import 'package:flutter_project_structure/screens/profile/bloc/profile_screen_bloc.dart';
import 'package:flutter_project_structure/screens/profile/bloc/profile_screen_repository.dart';
import 'package:flutter_project_structure/screens/profile/profile_screen.dart';
import 'package:lottie/lottie.dart';
import '../../../helper/app_shared_pref.dart';

class NavBarView extends StatefulWidget {
  int  selectedIndex = 0;
  NavBarView({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _NavBarViewState createState() => _NavBarViewState();
}

class _NavBarViewState extends State<NavBarView> {
  AppLocalizations? _localizations;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetList = [
      MultiBlocProvider(
        providers: [
          BlocProvider<HomeScreenBloc>(
              create: (context) =>
                  HomeScreenBloc(repository: HomeScreenRepositoryImp())),
        ],
        child: HomeScreen(),
      ),
      // BlocProvider(
      //   create: (context) =>
      //       CategoryScreenBloc(CategoryScreenRepositoryImp()),
      //   child: CategoryScreen(),
      // ),
      BlocProvider(
        create: (context) =>
            CartScreenBloc(repository: CartScreenRepositoryImp()),
        child: const CartScreen(),
      ),
      BlocProvider(
        create: (context) =>
            ProfileScreenBloc(repository: ProfileScreenRepositoryImp()),
        child: const ProfileScreen(),
      )
    ];
    return WillPopScope(
      onWillPop: () async {
        if (widget.selectedIndex != 0) {
          BlocProvider.of<NavigationCubit>(context)
              .getNavBarItem(NavbarItems.home);
          return false;
        }
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: AppColors.lightGray,
            selectedItemColor:MobikulTheme.clientAccentColor,
            showSelectedLabels: true,
            currentIndex: widget.selectedIndex,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.home,
                ),
                label: _localizations?.translate(AppStringConstant.home),
              ),
              // BottomNavigationBarItem(
              //     icon: const Icon(Icons.category_outlined),
              //     label: _localizations?.translate(AppStringConstant.categories)),
              BottomNavigationBarItem(
                icon: _cartButtonValue(),
                label: _localizations?.translate(AppStringConstant.cart),
              ),
              BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      const Icon(Icons.person_outlined),
                      if ((AppSharedPref().getSplashData()?.addons?.odooGdpr ??
                              false) &&
                          !(AppSharedPref().getUserData()?.isEmailVerified ??
                              true))
                        const Positioned(
                            right: 0,
                            top: -8,
                            child: Text(
                              '!',
                              style:
                                  TextStyle(color: AppColors.red, fontSize: 18),
                            ))
                    ],
                  ),
                  label: _localizations?.translate(AppStringConstant.profile))
            ],
          onTap: (index) => setState(() => widget.selectedIndex = index),
          ),
        body: widgetList.elementAt(widget.selectedIndex),
      ),
    );
  }

  _cartButtonValue() {
    return BadgeIcon(
      icon: const Icon(Icons.shopping_cart_outlined),
      badgeColor: Colors.red,
    );
  }
}
