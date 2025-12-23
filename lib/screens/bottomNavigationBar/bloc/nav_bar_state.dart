/*
 * *
 *
 *  Webkul Software.
 *
 *  @package Mobikul App
 *
 *  @Category Mobikul
 *
 *  @author Webkul <support@webkul.com>
 *
 *  @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *
 *  @license https://store.webkul.com/license.html ASL Licence
 *
 *  @link https://store.webkul.com/license.html
 *
 * /
 */

part of 'nav_bar_cubit.dart';


class NavigationState extends Equatable{
  final NavbarItems? item;
  int index;

  NavigationState(this.index,this.item);

  @override
  // TODO: implement props
  List<Object?> get props => [this.item,this.index];

}