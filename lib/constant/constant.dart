// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.orange,
  fontFamily: "ThaiFont",
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    color: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.orange,
  fontFamily: "ThaiFont",
  scaffoldBackgroundColor: Colors.grey[850],
  appBarTheme: AppBarTheme(
    color: Colors.grey[850],
    titleTextStyle: TextStyle(
      color: Colors.white,
    ),
  ),
);

// Make DropShadow to Sub Menu on Home Page
class DropShadow {
  static BoxDecoration boxDecoration =
      BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [
    BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 3,
      blurRadius: 5,
      offset: Offset(0, 3),
    )
  ]);
  static BoxDecoration boxDecoration_dark = BoxDecoration(
      color: Colors.grey[800]!,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.grey[850]!.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 5,
          offset: Offset(0, 3),
        )
      ]);
}

// Configure to Fitting on Different Devices
class SizeConfig {
  static late double screenHeight;
  static late double screenWidth;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static void init(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }

  static double height(double inputHeight) {
    return blockSizeVertical * inputHeight;
  }

  static double width(double inputWidth) {
    return blockSizeHorizontal * inputWidth;
  }
}
