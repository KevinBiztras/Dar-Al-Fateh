/**

 * Webkul Software.

 * @package Mobikul App

 * @Category Mobikul

 * @author Webkul <support@webkul.com>

 * @Copyright (c) Webkul Software Private Limited (https://webkul.com)

 * @license https://store.webkul.com/license.html ASL Licence

 * @link https://store.webkul.com/license.html

 */
import 'package:equatable/equatable.dart';import 'package:flutter_bloc/flutter_bloc.dart';
part 'nav_bar_items.dart';
part 'nav_bar_state.dart';

class NavigationCubit extends Cubit<NavigationState>{
  NavigationCubit() : super(NavigationState(0, NavbarItems.home));

  void getNavBarItem(NavbarItems navbarItem) {
    switch (navbarItem) {
      case NavbarItems.home:
        emit(NavigationState(0, NavbarItems.home));
        break;
      case NavbarItems.categories:
        emit(NavigationState(1,NavbarItems.categories ));
        break;
      case NavbarItems.cart:
        emit(NavigationState(2,NavbarItems.cart ));
        break;
      case NavbarItems.profile:
        emit(NavigationState(3, NavbarItems.profile));
    }
  }
}