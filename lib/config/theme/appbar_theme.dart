import 'package:flutter/material.dart';

class CustomAppbarTheme {
  AppBarTheme lightAppbarTheme = const AppBarTheme(
    color: Colors.blue,
    iconTheme: IconThemeData(color: Colors.white),
  );

  AppBarTheme darkAppbarTheme = const AppBarTheme(
    color: Colors.deepPurple,
    iconTheme: IconThemeData(color: Colors.white),
  );
}
