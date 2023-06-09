import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehome/business_logic/patient/patient_bloc.dart';
import 'package:rehome/domain/models/patient/models.dart';
import 'package:rehome/presentation/patient_page.dart';
import 'package:rehome/presentation/patientsearchwidget.dart';

class PatientOverviewPage extends StatelessWidget {
  const PatientOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(flex: 1, child: PatientSearchWidget()),
        Expanded(
            flex: 3,
            child: BlocBuilder<PatientBloc, PatientState>(
                builder: (context, state) {
              final Patient? patient = state.active;
              if (patient == null) {
                return const Center(
                    child: Text("Wähle zuerst einen Patienten aus"));
              }
              return const PatientPage();
            }))
      ],
    );
  }
}
