
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

/// NAME       SIZE   WEIGHT   SPACING  2018 NAME
/// display4   112.0  thin     0.0      headline1
/// display3   56.0   normal   0.0      headline2
/// display2   45.0   normal   0.0      headline3
/// display1   34.0   normal   0.0      headline4
/// headline   24.0   normal   0.0      headline5
/// title      20.0   medium   0.0      headline6
/// subhead    16.0   normal   0.0      subtitle1
/// body2      14.0   medium   0.0      body1 (bodyText1)
/// body1      14.0   normal   0.0      body2 (bodyText2)
/// caption    12.0   normal   0.0      caption
/// button     14.0   medium   0.0      button
/// subtitle   14.0   medium   0.0      subtitle2

class AppTheme {
  static Color appPrimaryColor = Color(0xFF7737FF);

  static Color lightAccentColor = Color(0xFF3B516E);
  static Color lightScaffoldBackgroundColor = Color(0xFFF5F9FF);

  static Color darkAccentColor = Colors.white;
  static Color darkScaffoldBackgroundColor = Color(0xFF191828);

  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: 'Quicksand-Bold',
      //primarySwatch: Colors.deepPurple,
      primaryColor: appPrimaryColor,
      accentColor: lightAccentColor,
      scaffoldBackgroundColor: lightScaffoldBackgroundColor,
      colorScheme: ColorScheme.light(
        primary: appPrimaryColor = Color(0xFF7737FF),
        secondary: Color(0xFF3B516E),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: lightScaffoldBackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          //color: appPrimaryColor,
          color: lightAccentColor,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          //fontFamily: 'Pacifico-Regular',
          fontFamily: 'Quicksand-Regular',
        ),
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: lightScaffoldBackgroundColor, //Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      tabBarTheme: TabBarTheme(
        //labelColor: Colors.red
        unselectedLabelColor: Color(0xFF3B516E).withOpacity(0.5),
        labelColor: Colors.white,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(48.0),
          color: appPrimaryColor,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: lightAccentColor,
          fontSize: 10.sp,
        ),
        bodyText2: TextStyle(
          color: lightAccentColor.withOpacity(0.5),
          fontSize: 10.sp,
        ),
        subtitle1: TextStyle(
          color: lightAccentColor,
          fontSize: 12.sp,
        ),
        subtitle2: TextStyle(
          color: lightAccentColor.withOpacity(0.5),
          fontSize: 12.sp,
        ),
        headline6: TextStyle(
          color: lightAccentColor,
          //fontWeight: FontWeight.w900,
          fontSize: 14.sp,
        ),
        headline5: TextStyle(
          color: lightAccentColor,
          //fontWeight: FontWeight.w900,
          fontSize: 16.sp,
        ),
        headline4: TextStyle(
          color: lightAccentColor,
          fontWeight: FontWeight.w900,
          fontSize: 18.sp,
        ),
        headline3: TextStyle(
          color: lightAccentColor,
          fontWeight: FontWeight.w900,
          fontSize: 20.sp,
        ),
        headline2: TextStyle(
          color: lightAccentColor,
          fontWeight: FontWeight.w900,
          fontSize: 22.sp,
        ),
        headline1: TextStyle(
          color: lightAccentColor,
          fontWeight: FontWeight.w900,
          fontSize: 24.sp,
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      fontFamily: 'Quicksand-Medium',
      primarySwatch: Colors.deepPurple,
      primaryColor: appPrimaryColor,
      accentColor: darkAccentColor,
      colorScheme: ColorScheme.dark(
        primary: appPrimaryColor = Color(0xFF7737FF),
        secondary: darkAccentColor = Colors.white,
      ),
      scaffoldBackgroundColor: darkScaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: darkScaffoldBackgroundColor,
        elevation: 0.0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: appPrimaryColor,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          //fontFamily: 'Pacifico-Regular',
          fontFamily: 'Quicksand-Regular',
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: darkScaffoldBackgroundColor, //Colors.white,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      tabBarTheme: TabBarTheme(
        //labelColor: Colors.red
        unselectedLabelColor: darkAccentColor.withOpacity(0.5),
        labelColor: Colors.white,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(48.0),
          color: appPrimaryColor,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          color: darkAccentColor,
          fontSize: 10.sp,
        ),
        bodyText2: TextStyle(
          color: darkAccentColor.withOpacity(0.5),
          fontSize: 10.sp,
        ),
        subtitle1: TextStyle(
          color: darkAccentColor,
          fontSize: 12.sp,
        ),
        subtitle2: TextStyle(
          color: darkAccentColor.withOpacity(0.5),
          fontSize: 12.sp,
        ),
        headline6: TextStyle(
          color: darkAccentColor,
          //fontWeight: FontWeight.w900,
          fontSize: 14.sp,
        ),
        headline5: TextStyle(
          color: darkAccentColor,
          //fontWeight: FontWeight.w900,
          fontSize: 16.sp,
        ),
        headline4: TextStyle(
          color: darkAccentColor,
          fontWeight: FontWeight.w900,
          fontSize: 18.sp,
        ),
        headline3: TextStyle(
          color: darkAccentColor,
          fontWeight: FontWeight.w900,
          fontSize: 20.sp,
        ),
        headline2: TextStyle(
          color: darkAccentColor,
          fontWeight: FontWeight.w900,
          fontSize: 22.sp,
        ),
        headline1: TextStyle(
          color: darkAccentColor,
          fontWeight: FontWeight.w900,
          fontSize: 24.sp,
        ),
      ),
    );
  }
}
