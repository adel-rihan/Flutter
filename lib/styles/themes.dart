import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  fontFamily: 'jannah',
  colorScheme: ColorScheme.light(
    background: Colors.white,
    surface: Colors.grey[300]!,
    primary: Colors.blue,
    secondary: Colors.blue,
    onBackground: Colors.black,
    onSurface: Colors.black,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    titleSpacing: 20,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light, // ios
      statusBarIconBrightness: Brightness.dark, // Android
    ),
    // elevation: 10,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 20),
    bodyMedium: TextStyle(fontSize: 16),
    bodySmall: TextStyle(fontSize: 14),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Colors.grey.withOpacity(0.5),
    // showSelectedLabels: false,
    // showUnselectedLabels: false,
    // backgroundColor: Colors.white,
    elevation: 15,
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  fontFamily: 'jannah',
  colorScheme: const ColorScheme.dark(
    background: Color.fromRGBO(24, 25, 26, 1),
    surface: Color.fromRGBO(36, 37, 38, 1),
    primary: Colors.blue,
    secondary: Colors.blue,
    onBackground: Colors.white,
    onSurface: Colors.white,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    titleSpacing: 20,
    backgroundColor: Color.fromRGBO(24, 25, 26, 1),
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(24, 25, 26, 1),
      statusBarBrightness: Brightness.dark, // ios
      statusBarIconBrightness: Brightness.light, // Android
    ),
    // elevation: 10,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 20),
    bodyMedium: TextStyle(fontSize: 16),
    bodySmall: TextStyle(fontSize: 14),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Colors.grey.withOpacity(0.5),
    // showSelectedLabels: false,
    // showUnselectedLabels: false,
    // backgroundColor: const Color.fromRGBO(24, 25, 26, 1),
    elevation: 15,
  ),
);
