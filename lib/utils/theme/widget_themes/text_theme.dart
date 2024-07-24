import 'package:flutter/material.dart';

class TTextTheme {
  static const TextTheme lightTextTheme = TextTheme(
    displayMedium: TextStyle(
        fontWeight: FontWeight.w900,
        color: Colors.black87,
        fontStyle: FontStyle.normal),
    titleSmall: TextStyle(
      color: Colors.black54,
      fontSize: 24,
    ),
  );

  static const TextTheme darkTextTheme = TextTheme(
    displayMedium: TextStyle(
        fontWeight: FontWeight.w900,
        color: Colors.white70,
        fontStyle: FontStyle.normal),
    titleSmall: TextStyle(
      color: Colors.white60,
      fontSize: 24,
    ),
  );
}
