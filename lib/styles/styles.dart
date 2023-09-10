import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: HexColor('#0a0f1d'),
      surface: HexColor('#101421'), // 1a1b2c
      primary: HexColor('#424553'),
      secondary: HexColor('#d3334e'),
      onBackground: Colors.white,
      onSurface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: HexColor('#0a0f1d'),
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('#0a0f1d'),
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
      elevation: 0,
    ),
    textTheme: TextTheme(
      displayLarge:
          const TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
      titleLarge: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(
        fontSize: 24.0,
        color: Colors.grey[700],
      ),
      bodyMedium: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      bodySmall: const TextStyle(fontSize: 16.0),
    ),
    buttonTheme: const ButtonThemeData(
      shape: ContinuousRectangleBorder(),
    ),
    sliderTheme: SliderThemeData(
      thumbColor: HexColor('#d3334e'),
      activeTrackColor: HexColor('#424553'),
      inactiveTrackColor: HexColor('#2b2d36'),
    ));
