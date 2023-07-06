import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

ThemeData rehomeTheme = ThemeData(
  colorScheme:
      const ColorScheme.light(primary: primaryColor, secondary: canvasColor),
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: primaryColor,
  canvasColor: const Color(0xFFEDEDF4),
  dividerColor: Colors.grey.withOpacity(0.5),
  iconTheme: IconThemeData(color: Colors.red.withOpacity(0.7), size: 20),
  appBarTheme: const AppBarTheme(
    backgroundColor: canvasColor,
    foregroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    elevation: 2,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: const Color(0xFF2E2E48),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
);

SidebarXTheme sidebarTheme = SidebarXTheme(
  margin: const EdgeInsets.all(10),
  decoration: BoxDecoration(
    color: canvasColor,
    borderRadius: BorderRadius.circular(20),
  ),
  hoverColor: scaffoldBackgroundColor,
  textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
  selectedTextStyle: const TextStyle(color: Colors.white),
  itemTextPadding: const EdgeInsets.only(left: 30),
  selectedItemTextPadding: const EdgeInsets.only(left: 30),
  itemDecoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: canvasColor),
  ),
  selectedItemDecoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: actionColor.withOpacity(0.37),
    ),
    gradient: const LinearGradient(
      colors: [accentCanvasColor, canvasColor],
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.28),
        blurRadius: 30,
      )
    ],
  ),
  iconTheme: IconThemeData(
    color: Colors.white.withOpacity(0.7),
    size: 20,
  ),
  selectedIconTheme: const IconThemeData(
    color: Colors.white,
    size: 20,
  ),
);

const primaryColor = Color.fromARGB(255, 65, 52, 207);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color.fromARGB(255, 219, 219, 255);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
