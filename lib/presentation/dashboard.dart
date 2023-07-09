// Erster Entwurf vom Dashboard (erstmal hauptsächlich um das Scrollbar Widget zu testen)
import 'package:flutter/material.dart';
import 'package:rehome/presentation/patientsearchwidget.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const DashBoard());
  }

  @override
  Widget build(BuildContext context) {
    return const PatientSearchWidget();
  }
}
