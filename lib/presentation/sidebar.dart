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
      theme: SidebarXTheme(
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
      ),
      extendedTheme: const SidebarXTheme(
        // sidebar width
        width: 180,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      footerDivider: divider,

      /**
     
      //rehome Logo linke untere Ecke
      toggleButtonBuilder: (context, extended) {
        return SizedBox(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/rehomeLogo.png'),
          ),
        );
      },
     */

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

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
