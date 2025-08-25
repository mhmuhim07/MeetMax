import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFF377DFF);
const Color textColor = Color(0xFF1D2A3A);
const Color backgroundColor = Colors.white;
const Color greyColor = Color(0xFFF1F3F6);
const Color darkGreyColor = Color(0xFF6E7A8A);

final appTheme = ThemeData(
  scaffoldBackgroundColor: backgroundColor,
  primaryColor: primaryColor,
  textTheme: GoogleFonts.poppinsTextTheme(
    ThemeData.light().textTheme.copyWith(
          displaySmall: const TextStyle(
              color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
          titleMedium: const TextStyle(color: darkGreyColor, fontSize: 14),
          bodyLarge: const TextStyle(color: textColor, fontSize: 14),
          labelLarge: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: greyColor,
    contentPadding:
        const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    // ignore: deprecated_member_use
    prefixIconColor: textColor.withOpacity(0.5),
    hintStyle: GoogleFonts.poppins(color: darkGreyColor),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primaryColor,
      textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.5,
    iconTheme: const IconThemeData(color: textColor),
    titleTextStyle: GoogleFonts.poppins(
        color: textColor, fontSize: 18, fontWeight: FontWeight.w600),
  ),
);
