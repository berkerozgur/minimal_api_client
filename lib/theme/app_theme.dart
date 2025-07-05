import 'package:flutter/material.dart';
import 'nord_colors.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: NordColors.nord10,
      onPrimary: NordColors.nord6,
      primaryContainer: NordColors.nord4,
      onPrimaryContainer: NordColors.nord0,

      secondary: NordColors.nord8,
      onSecondary: NordColors.nord0,
      secondaryContainer: NordColors.nord5,
      onSecondaryContainer: NordColors.nord0,

      tertiary: NordColors.nord7,
      onTertiary: NordColors.nord0,
      tertiaryContainer: NordColors.nord6,
      onTertiaryContainer: NordColors.nord0,

      error: NordColors.nord11,
      onError: NordColors.nord6,
      errorContainer: NordColors.nord13,
      onErrorContainer: NordColors.nord0,

      surface: NordColors.nord6,
      onSurface: NordColors.nord0,
      surfaceTint: NordColors.nord10,

      surfaceContainerHighest: NordColors.nord4,
      surfaceContainerHigh: NordColors.nord5,
      surfaceContainer: NordColors.nord5,
      surfaceContainerLow: NordColors.nord6,
      surfaceContainerLowest: NordColors.nord6,

      primaryFixed: NordColors.nord10,
      onPrimaryFixed: NordColors.nord6,
      primaryFixedDim: NordColors.nord9,
      onPrimaryFixedVariant: NordColors.nord3,

      tertiaryFixed: NordColors.nord7,
      onTertiaryFixed: NordColors.nord0,
      tertiaryFixedDim: NordColors.nord9,
      onTertiaryFixedVariant: NordColors.nord3,

      outline: NordColors.nord3,
      outlineVariant: NordColors.nord4,
      scrim: NordColors.nord0,
      inverseSurface: NordColors.nord0,
      onInverseSurface: NordColors.nord6,
      inversePrimary: NordColors.nord8,
      shadow: NordColors.nord3,
    ),
    typography: Typography.material2021(),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: NordColors.nord8,
      onPrimary: NordColors.nord0,
      primaryContainer: NordColors.nord2,
      onPrimaryContainer: NordColors.nord6,

      secondary: NordColors.nord7,
      onSecondary: NordColors.nord6,
      secondaryContainer: NordColors.nord3,
      onSecondaryContainer: NordColors.nord6,

      tertiary: NordColors.nord9,
      onTertiary: NordColors.nord6,
      tertiaryContainer: NordColors.nord2,
      onTertiaryContainer: NordColors.nord6,

      error: NordColors.nord11,
      onError: NordColors.nord0,
      errorContainer: NordColors.nord12,
      onErrorContainer: NordColors.nord6,

      surface: NordColors.nord0,
      onSurface: NordColors.nord6,
      surfaceTint: NordColors.nord8,

      surfaceContainerHighest: NordColors.nord1,
      surfaceContainerHigh: NordColors.nord2,
      surfaceContainer: NordColors.nord2,
      surfaceContainerLow: NordColors.nord0,
      surfaceContainerLowest: NordColors.nord0,

      primaryFixed: NordColors.nord8,
      onPrimaryFixed: NordColors.nord0,
      primaryFixedDim: NordColors.nord9,
      onPrimaryFixedVariant: NordColors.nord4,

      tertiaryFixed: NordColors.nord9,
      onTertiaryFixed: NordColors.nord6,
      tertiaryFixedDim: NordColors.nord7,
      onTertiaryFixedVariant: NordColors.nord4,

      outline: NordColors.nord4,
      outlineVariant: NordColors.nord2,
      scrim: NordColors.nord6,
      inverseSurface: NordColors.nord6,
      onInverseSurface: NordColors.nord0,
      inversePrimary: NordColors.nord10,
      shadow: NordColors.nord2,
    ),
    typography: Typography.material2021(),
  );
}
