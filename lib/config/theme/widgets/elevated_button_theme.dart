import 'package:flutter/material.dart';
import 'package:happy_cooking/config/theme/size.dart';

class CustomElevatedButtonTheme {
  CustomElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: const RoundedRectangleBorder(),
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      side: const BorderSide(color: Colors.blue),
      padding: const EdgeInsets.symmetric(vertical: buttonHeight),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(

      shape: const RoundedRectangleBorder(),
      foregroundColor: Colors.black,
      backgroundColor: Colors.amber,
      side: const BorderSide(color: Colors.amber),
      padding: const EdgeInsets.symmetric(vertical: buttonHeight),
    ),
  );
}
