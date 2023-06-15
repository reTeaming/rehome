import 'package:ReHome/domain/repositories/patient_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../business_logic/patients/patients_bloc.dart';

// Screen für die Patientendaten
class PatientsPage extends StatelessWidget {
  const PatientsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const PatientsPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientsBloc(patientRepository: PatientRepository()),
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: <Widget>[
            // scrollbare Appbar mit Namen, Geburtstag und Therapiestart des Patienten
            SliverAppBar(
              stretch: true,
              onStretchTrigger: () {
                return Future<void>.value();
              },
              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                // Mode für das "Nach-Oben-Ziehen"- des Screens
                stretchModes: const <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                centerTitle: false,
                title: Builder(
                  builder: (context) {
                    final patient = context.select(
                      (PatientsBloc bloc) => bloc.state.patient,
                    );
                    return Text(
                        '${patient.name}, geb. am: ${DateFormat.yMMMMd().format(patient.birthDate)}, in Therapie seit: ${DateFormat.yMMMMd().format(patient.therapyStart)}');
                  },
                ),
                background: FlutterLogo(),
              ),
            ),
            // Blöcke für detaillierte Informationen über den Patienten
            SliverList(
              delegate: SliverChildListDelegate(
                const <Widget>[
                  Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 400,
                                width: 600,
                                child: Card(child: Text('HausaufgabenPlan'))),
                            SizedBox(
                                height: 400,
                                width: 600,
                                child: Card(child: Text('Übungen'))),
                          ]),
                      SizedBox(
                          height: 400,
                          width: 1200,
                          child: Card(child: Text('Ziele'))),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
