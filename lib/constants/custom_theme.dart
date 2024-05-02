import 'package:flutter/material.dart';
import 'package:flutter_pokedex/constants/fonts.dart';
import 'package:flutter_pokedex/constants/palette.dart';

final ThemeData customTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Palette.primary,
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Palette.primary,
  ),
  fontFamily: Fonts.primary,
);

extension TextThemeShort on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}
