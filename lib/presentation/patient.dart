import 'package:ReHome/domain/repositories/patient_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../business_logic/patients/patients_bloc.dart';

// Screen für die Patientendaten
class PatientPage extends StatelessWidget {
  const PatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    // übergibt Patient aus dem Repository
    return BlocProvider(
      create: (context) => PatientsBloc(patientRepository: PatientRepository()),
      // User Interface
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: <Widget>[
            // scrollbare Appbar
            SliverAppBar(
              stretch: true,
              onStretchTrigger: () {
                return Future<void>.value();
              },
              expandedHeight: 250.0,
              backgroundColor: Colors.black,
              flexibleSpace: FlexibleSpaceBar(
                // Mode für das "Nach-Oben-Ziehen"- des Screens
                stretchModes: const <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                // Titel der Seite (Namen, Geburtstag und Therapiestart des Patienten)
                centerTitle: false,
                title: BlocBuilder<PatientsBloc, PatientsState>(
                    builder: (context, state) {
                  return Text(
                      '${state.patient.name}, geb. am: ${DateFormat.yMMMMd().format(state.patient.birthDate)}, in Therapie seit: ${DateFormat.yMMMMd().format(state.patient.therapyStart)}');
                }
                    /* builder: (context) {
                    final patient = context.select(
                      (PatientsBloc bloc) => bloc.state.patient,
                    ); 
                    return Text(
                        '${patient.name}, geb. am: ${DateFormat.yMMMMd().format(patient.birthDate)}, in Therapie seit: ${DateFormat.yMMMMd().format(patient.therapyStart)}');
                  },*/
                    ),
                background: const Image(
                  image: AssetImage('assets/ReHomeLogo.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            // Blöcke für detaillierte Informationen über den Patienten
            SliverList(
              delegate: SliverChildListDelegate(
                const <Widget>[
                  Column(
                    children: [
                      ZieleWidget(),
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

class ZieleWidget extends StatelessWidget {
  const ZieleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: 400, width: 1200, child: Card(child: Text('Ziele')));
  }
}
