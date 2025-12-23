
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

class MobikulTheme {
  static const Color primaryColor = Color(0xFFFFFFFF);  // don't change this color
  static const Color accentColor = Color(0xFF000000);   // don't change this color

  static const Color clientPrimaryColor = Color(0xFFFFFFFF);  // replace with client primary color
  static const Color clientAccentColor = Color(0xFF000000);     // replace with client accent color


  static const Color lightGrey = Color(0xffe8e5e5);
  static const Color lightGreyTest = Color(0xfff7f7f7);
  static const Color appbarTextColor = Color(0xFF000000);

}

class AppTheme {
  AppTheme._();


  static final Color _iconColor = Colors.blueAccent.shade200;

  static const Color _lightPrimaryColor = Colors.white24;
  static const Color _lightPrimaryVariantColor = MobikulTheme.primaryColor;
  static const Color _lightSecondaryColor = Colors.green;
  static const Color _lightOnPrimaryColor = Colors.black;

  static const Color _darkPrimaryColor = Colors.white24;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static const Color _darkSecondaryColor = Colors.white;
  static const Color _darkOnPrimaryColor = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: false,
      appBarTheme: const AppBarTheme(
        actionsIconTheme: IconThemeData(
          color:MobikulTheme.appbarTextColor,

        ),
        titleTextStyle: TextStyle(
          color: MobikulTheme.appbarTextColor,
          fontSize: 20,
          fontFamily: "Roboto",
          fontWeight: FontWeight.bold,),
        color: MobikulTheme.clientPrimaryColor,

        iconTheme: IconThemeData(color: MobikulTheme.appbarTextColor,),
      ),
      textSelectionTheme: const TextSelectionThemeData(selectionColor: Colors.black12, cursorColor: Colors.green),
      colorScheme: const ColorScheme.light(
        primary: _lightPrimaryColor,
        secondaryContainer: _lightPrimaryVariantColor,
        // primaryVariant: _lightPrimaryVariantColor,
        secondary: _lightSecondaryColor,
        onPrimary: MobikulTheme.clientAccentColor,
      ),
      iconTheme: const IconThemeData(
        color: _lightOnPrimaryColor,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: _lightOnPrimaryColor),
      textTheme: _lightTextTheme,
      dividerTheme: const DividerThemeData(color: Colors.black12),
      bottomAppBarTheme: const BottomAppBarThemeData(color: Color(0xFF2A65B3),));

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: false,
      scaffoldBackgroundColor: _darkPrimaryVariantColor,
      appBarTheme: const AppBarTheme(
        actionsIconTheme: IconThemeData(
          // color: MobikulTheme.appbarTextColor,

        ),
        titleTextStyle: TextStyle(
          // color: MobikulTheme.appbarTextColor,
          fontSize: 20,
          fontFamily: "Roboto",
          fontWeight: FontWeight.bold,),
        // color: MobikulTheme.clientPrimaryColor,

        // iconTheme: IconThemeData(color: MobikulTheme.appbarTextColor,),
      ),
      colorScheme: const ColorScheme.dark(
        primary: _darkPrimaryColor,
        secondaryContainer: _darkPrimaryVariantColor,
        // primaryVariant: _darkPrimaryVariantColor,
        secondary: _darkSecondaryColor,
        onPrimary: _darkOnPrimaryColor,
        background: Colors.white12,
      ),
      iconTheme: IconThemeData(
        color: _darkOnPrimaryColor,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: _darkOnPrimaryColor),
      textTheme: _darkTextTheme,
      dividerTheme: const DividerThemeData(color: Colors.grey),
      bottomAppBarTheme: const BottomAppBarThemeData(color: _darkOnPrimaryColor));

  static const TextTheme _lightTextTheme = TextTheme(
    displayLarge: _lightScreenHeading1TextStyle,
    displayMedium: _lightScreenHeading2TextStyle,
    displaySmall: _lightScreenHeading3TextStyle,
    headlineMedium: _lightScreenHeading4TextStyle,
    headlineSmall: _lightScreenHeading5TextStyle,
    titleLarge: _lightScreenHeading6TextStyle,
    titleMedium: _lightScreenSubTile1TextStyle,
    titleSmall: _lightScreenSubTile2TextStyle,
    bodyLarge: _lightScreenTaskNameTextStyle,
    bodyMedium: _lightScreenTaskDurationTextStyle,
  );

  static final TextTheme _darkTextTheme = TextTheme(
    displayLarge: _darkScreenHeading1TextStyle,
    displayMedium: _darkScreenHeading2TextStyle,
    displaySmall: _darkScreenHeading3TextStyle,
    headlineMedium: _darkScreenHeading4TextStyle,
    headlineSmall: _darkScreenHeading5TextStyle,
    titleLarge: _darkScreenHeading6TextStyle,
    titleMedium: _darkScreenSubTile1TextStyle,
    titleSmall: _darkScreenSubTile2TextStyle,
    bodyLarge: _darkScreenTaskNameTextStyle,
    bodyMedium: _darkScreenTaskDurationTextStyle,
  );
  static const TextStyle _lightScreenHeading1TextStyle = TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
      color: _lightOnPrimaryColor,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenHeading2TextStyle = TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      color: _lightOnPrimaryColor,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenHeading3TextStyle = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: _lightOnPrimaryColor,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenHeading4TextStyle = TextStyle(
      fontSize: 18.0,
      // fontWeight: FontWeight.bold,
      color: _lightOnPrimaryColor,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenHeading5TextStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: _lightOnPrimaryColor,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenHeading6TextStyle = TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: _lightOnPrimaryColor,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenTaskNameTextStyle = TextStyle(
      fontSize: 14.0, color: _lightOnPrimaryColor, fontFamily: "Roboto");

  static const TextStyle _lightScreenTaskDurationTextStyle = TextStyle(
      fontSize: 12.0, color: _lightOnPrimaryColor, fontFamily: "Roboto");

  static const TextStyle _lightScreenSubTile1TextStyle =
  TextStyle(fontSize: 20.0, color: Colors.grey, fontFamily: "Roboto");

  static const TextStyle _lightScreenSubTile2TextStyle =
  TextStyle(fontSize: 16.0, color: Colors.grey, fontFamily: "Roboto");

  static final TextStyle _darkScreenHeading1TextStyle =
  _lightScreenHeading1TextStyle.copyWith(color: _darkOnPrimaryColor);

  static final TextStyle _darkScreenHeading2TextStyle =
  _lightScreenHeading2TextStyle.copyWith(color: _darkOnPrimaryColor);

  static final TextStyle _darkScreenHeading3TextStyle =
  _lightScreenHeading3TextStyle.copyWith(color: _darkOnPrimaryColor);

  static final TextStyle _darkScreenHeading4TextStyle =
  _lightScreenHeading4TextStyle.copyWith(color: _darkOnPrimaryColor);

  static final TextStyle _darkScreenHeading5TextStyle =
  _lightScreenHeading5TextStyle.copyWith(color: _darkOnPrimaryColor);

  static final TextStyle _darkScreenHeading6TextStyle =
  _lightScreenHeading6TextStyle.copyWith(color: _darkOnPrimaryColor);

  static final TextStyle _darkScreenTaskNameTextStyle =
  _lightScreenTaskNameTextStyle.copyWith(color: _darkOnPrimaryColor);

  static final TextStyle _darkScreenTaskDurationTextStyle =
  _lightScreenTaskDurationTextStyle.copyWith(color: _darkOnPrimaryColor);

  static const TextStyle _darkScreenSubTile1TextStyle =
      _lightScreenSubTile1TextStyle;

  static const TextStyle _darkScreenSubTile2TextStyle =
      _lightScreenSubTile2TextStyle;

  static const TextStyle smallBoldText = TextStyle(
      fontSize: 12.0, fontWeight: FontWeight.bold, fontFamily: "Roboto");
}
