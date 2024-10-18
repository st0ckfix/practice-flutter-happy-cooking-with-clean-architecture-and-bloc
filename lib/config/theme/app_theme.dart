import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_cooking/config/theme/appbar_theme.dart';
import 'package:happy_cooking/config/theme/widgets/elevated_button_theme.dart';
import 'package:happy_cooking/config/theme/widgets/outlined_button_theme.dart';

class CustomAppTheme {
  ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.montserratTextTheme(),
      //appBarTheme: CustomAppbarTheme().lightAppbarTheme,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.light),
      outlinedButtonTheme: CustomOutlinedButtonTheme.lightOutlinedButtonTheme,
      elevatedButtonTheme: CustomElevatedButtonTheme.lightElevatedButtonTheme);

  ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.montserratTextTheme(),
      //appBarTheme: CustomAppbarTheme().darkAppbarTheme,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber, brightness: Brightness.dark),
      outlinedButtonTheme: CustomOutlinedButtonTheme.darkOutlinedButtonTheme,
      elevatedButtonTheme: CustomElevatedButtonTheme.darkElevatedButtonTheme);
}
