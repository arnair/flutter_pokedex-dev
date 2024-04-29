import 'package:flutter/material.dart';
import 'import_theme.dart';

class AppTextStyle {
  //// Title
  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Palette.grey,
    letterSpacing: 0.15,
  );

  static const TextStyle titleRed = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Palette.red500,
    letterSpacing: 0.15,
  );

  //// Text
  static const TextStyle textBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Palette.grey,
    letterSpacing: 0.5,
  );

  static const TextStyle textWhite = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.white,
    letterSpacing: 0.15,
  );

  static const TextStyle text = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Palette.grey,
  );

  static const TextStyle textRed = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Palette.red500,
  );

  //// Caption
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Palette.grey,
    letterSpacing: 0.15,
  );

  static const TextStyle captionWhite = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.white,
    letterSpacing: 0.15,
  );
}
