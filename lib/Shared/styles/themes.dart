import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/Shared/styles/colors.dart';

ThemeData darktheme = ThemeData(
  switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(HexColor('333739'))),
  primarySwatch: defaultcolor,
  /*floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: HexColor('333739')),*/
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    // backgroundColor: HexColor('333739'),
    elevation: 0.0,
    color: /*Colors.white*/ HexColor('333739'),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: HexColor('333739')),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 28,
    ),
    iconTheme: const IconThemeData(color: Colors.white, size: 28),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: HexColor('333739'),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultcolor,
      unselectedItemColor: Colors.grey,
      elevation: 40.0),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  ),
);

ThemeData lighttheme = ThemeData(
  switchTheme:
      SwitchThemeData(thumbColor: MaterialStateProperty.all(/*Colors.deepOrange*/defaultcolor)),
  primarySwatch: defaultcolor,
  /*floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),*/
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    color: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.orange),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 28,
    ),
    iconTheme: IconThemeData(color: Colors.black, size: 28),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultcolor,
      unselectedItemColor: Colors.grey,
      elevation: 40.0),
);

