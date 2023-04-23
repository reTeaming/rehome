import 'package:flutter/material.dart';

// Colors according to the rules of Material design
// https://material.io/design/color/the-color-system.html#color-theme-creation
// Primary
final impulsDarkGray = Color(0xff444f57);
final impulsDarkerGray = Color(0xff111c24);
// Secondary
final impulsDarkBlue = Color(0xff3387bb);
final impulsDarkerBlue = Color(0xff003b6f);
// Background
final impulsLightGray = Color(0xffb9b8bc);
// Surface, onPrimary, onSecondary
final impulsWhite = Colors.white;
// Error
final impulsRed = Colors.red;

final impulsColorScheme = ColorScheme(
    primary: impulsDarkGray,
    primaryContainer: impulsDarkerGray,
    secondary: impulsDarkBlue,
    secondaryContainer: impulsDarkerBlue,
    surface: impulsWhite,
    background: impulsLightGray,
    error: impulsRed,
    onPrimary: impulsWhite,
    onSecondary: impulsWhite,
    onSurface: impulsDarkerGray,
    onBackground: impulsDarkerGray,
    onError: impulsWhite,
    brightness: Brightness.light);

const impulsBorderRadius = 10.0;

final impulsBorderShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(impulsBorderRadius)));

final double impulsElementElevation = 4;

final ThemeData impulsThemeData = ThemeData(
    // Define the default brightness and colors.
    colorScheme: impulsColorScheme,
    textTheme: TextTheme(
      headline1: TextStyle(
          fontFamily: 'Pacifico', fontSize: 24.0, color: Colors.white),
      headline2: TextStyle(fontFamily: 'Pacifico', fontSize: 24.0),
      headline3: TextStyle(fontFamily: 'Pacifico', fontSize: 20.0),
    ),
    // Define the default font family.
    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            shape: impulsBorderShape,
            primary: impulsDarkGray,
            elevation: impulsElementElevation)),
    cardTheme: CardTheme(
      shape: impulsBorderShape,
      elevation: impulsElementElevation,
    ));
