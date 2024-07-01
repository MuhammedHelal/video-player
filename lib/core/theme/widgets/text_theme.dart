import 'package:flutter/material.dart';
import 'package:videoplayer/core/consts/colors.dart';

abstract class MyTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    headlineSmall: const TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    // listview item title
    bodyMedium: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    headlineLarge: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: primaryColor,
    ),
    labelMedium: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      color: primaryColor,
    ),
    bodySmall: const TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.white),
    labelSmall: const TextStyle(
        fontSize: 11.0, fontWeight: FontWeight.w400, color: Colors.white),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineSmall: const TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ), // listview item title
    bodyMedium: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    headlineLarge: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: primaryColor,
    ),
    labelMedium: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: Colors.white70,
    ),
    labelLarge: const TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white70),
    bodySmall: const TextStyle(
        fontSize: 12.0, fontWeight: FontWeight.w400, color: Colors.white70),
    labelSmall: const TextStyle(
        fontSize: 11.0, fontWeight: FontWeight.w400, color: Colors.white70),
  );

  static final TextStyle durationTextStyle =
      const TextStyle().copyWith(color: Colors.white, fontSize: 14);
}
