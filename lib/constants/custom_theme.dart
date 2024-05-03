import 'package:flutter/material.dart';
import 'package:flutter_pokedex/constants/fonts.dart';
import 'package:flutter_pokedex/constants/palette.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'custom_theme.g.dart';

@Riverpod(keepAlive: true)
class CustomTheme extends _$CustomTheme {
  @override
  ThemeData build() => ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Palette.primary,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Palette.primary,
        ),
        fontFamily: Fonts.primary,
      );

  void changeColor({required Color color}) {
    state = state.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: color,
      ),
      appBarTheme: state.appBarTheme.copyWith(
        color: color,
      ),
    );
  }
}

extension ColorThemeShort on BuildContext {
  Color get colorTheme => Theme.of(this).colorScheme.primary;
}
