import 'package:emergency_one/core/constants/colors.dart';
import 'package:flutter/material.dart';

var lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
    surface: SurfaceColor,
    primary: primaryColor,
    primaryContainer: PrimaryContainerColor,
    onPrimaryContainer: OnPrimaryContainerColor,
    onSurface: OnSurfaceColor,
  ),

  textTheme: const TextTheme(
    bodySmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: OnSurfaceColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: OnSurfaceColor,
    ),
    bodyLarge: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: OnSurfaceColor,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: OnSurfaceColor,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: OnSurfaceColor,
    ),
    labelLarge: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: OnSurfaceColor,
    ),

  ),
);
