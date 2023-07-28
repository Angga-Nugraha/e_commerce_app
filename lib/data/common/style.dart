import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

final TextStyle kTitle =
    GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w700);

final TextStyle kSubTitle =
    GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500);

final TextStyle kLabel =
    GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700);

const Color primaryColor = Colors.black;
const Color onPrimaryColor = Colors.white;
Color secondaryColor = Colors.grey.shade300;

final myTheme = ThemeData(
  colorScheme: ThemeData.light().colorScheme.copyWith(
      primary: primaryColor,
      onPrimary: onPrimaryColor,
      secondary: secondaryColor),
  scaffoldBackgroundColor: onPrimaryColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: onPrimaryColor,
    foregroundColor: primaryColor,
  ),
  cardTheme: CardTheme(
    color: onPrimaryColor,
    shadowColor: primaryColor,
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(200, 40),
      backgroundColor: primaryColor,
      foregroundColor: onPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  ),
);
