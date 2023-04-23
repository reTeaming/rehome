/// The Home Screen
import 'package:flutter/material.dart';
import 'package:basic_app/types.dart';
import 'package:basic_app/widgets.dart';

/// This is the home screen
class HomeScreen extends StatelessWidget {
  final String title = "ReHome - Basic App";
  final IconData screenIcon = Icons.home;
  final IconData calIcon = Icons.calendar_today;

  @override
  Widget build(BuildContext context) {
    return RehomeAppBar(mainMenu);
  }
}

/// The actual main menu items
final mainMenu = <MainMenuItem>[
  SectionItem("Modul 1",
      Image.asset(iconSports, height: defaultMainMenuIconSize), '/information'),
];
