import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehome/business_logic/patient/patient_bloc.dart';
import 'package:rehome/business_logic/patientsearch/bloc/patientsearch_bloc.dart';
import 'package:rehome/domain/models/patient/models.dart';
import 'package:rehome/presentation/patientsearchwidget.dart';

class PatientPage extends StatelessWidget {
  const PatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientSearchBloc(),
      child: Row(
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
                return Text("$patient");
              }))
        ],
      ),
    );
  }
}
