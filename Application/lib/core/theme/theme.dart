import 'package:flutter/material.dart';

class Palette {
  static const TextStyle customTextStyle = TextStyle(
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w500,
    color: blackColor,
  );
  static const Color customColor = Color(0xFF4A90E2); // Blue
  static const Color cardBackgroundColor = Color(0xFFF5F5F5); // Light Grey
  static const Color textColor = blackColor;

  static const primaryColor = Color(0xFF4A90E2); // Blue
  static const backgroundColor = Color(0xFFF5F5F5); // Light Grey
  static const cardColor = Color(0xFFFFFFFF); // White
  static const appBarColor = Colors.white;
  static const buttonColor = Color.fromRGBO(61, 61, 61, 1); // Blue
  static const borderColor = Color.fromRGBO(200, 200, 200, 1.0); // Light Grey
  static const whiteColor = Colors.white;

  static const blackColor = Colors.black;
  static const boarderColor = Colors.grey;
  static const iconColor = Color.fromRGBO(61, 61, 61, 1);

  static const buttonTextColor = Color.fromRGBO(255, 255, 255, 1.0); // White
  static const hintTextColor = Color.fromRGBO(150, 150, 150, 1.0); // Grey
  static const snackBarErrorColor = Colors.red;
  static const snackBarSuccessColor = Colors.green;

  static var lightModeAppTheme = ThemeData.light(useMaterial3: true).copyWith(
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: appBarColor,
      titleTextStyle: TextStyle(
        color: textColor,
        fontSize: 20,
      ),
    ),
    iconTheme: const IconThemeData(
      size: 30,
      color: iconColor,
    ),
    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(iconColor),
        iconColor: MaterialStatePropertyAll(iconColor),
      ),
    ),
    cardTheme: const CardTheme(
      color: cardColor,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        backgroundColor: const MaterialStatePropertyAll(buttonColor),
        foregroundColor: const MaterialStatePropertyAll(buttonTextColor),
        fixedSize: const MaterialStatePropertyAll(
          Size(100, 50),
        ),
      ),
    ),
  );
}
