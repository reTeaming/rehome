import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehome/business_logic/patientsearch/bloc/patientsearch_bloc.dart';
import 'package:rehome/presentation/patientsearchwidget.dart';

class PatientPage extends StatelessWidget {
  const PatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientSearchBloc(),
      child: const Row(
        children: [
          Expanded(flex: 1, child: PatientSearchWidget()),
          Expanded(
              flex: 3,
              child: Center(
                child: Text("Patient"),
              ))
        ],
      ),
    );
  }
}
