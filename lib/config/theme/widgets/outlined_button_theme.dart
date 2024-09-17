import 'package:flutter/material.dart';
import 'package:happy_cooking/config/theme/color.dart';
import 'package:happy_cooking/config/theme/size.dart';

class CustomOutlinedButtonTheme {
  CustomOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: secondaryColor,
      side: const BorderSide(color: secondaryColor),
      padding: const EdgeInsets.symmetric(vertical: buttonHeight),
    ),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: Colors.white,
      side: const BorderSide(color: Colors.white),
      padding: const EdgeInsets.symmetric(vertical: buttonHeight),
    ),
  );
}
