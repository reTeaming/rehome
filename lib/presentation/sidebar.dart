import 'package:rehome/theme.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: sidebarTheme,
      extendedTheme: const SidebarXTheme(
        // sidebar width
        width: 180,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      footerDivider: divider,

      // Profilbild/Profil obere linke Ecke
      toggleButtonBuilder: (context, extended) {
        return const Center();
      },
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/rehomeLogo.png'),
          ),
        );
      },
      // Buttons der sidebar
      items: const [
        SidebarXItem(icon: Icons.dashboard, label: 'Dashboard'),
        SidebarXItem(icon: Icons.people, label: 'Patienten'),
        SidebarXItem(icon: Icons.sports_gymnastics_outlined, label: 'Aufgaben'),
        SidebarXItem(icon: Icons.settings, label: 'Einstellungen'),
      ],
    );
  }
}
