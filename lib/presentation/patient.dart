import 'package:ReHome/domain/models/patient/homework.dart';
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
            BlocBuilder<PatientsBloc, PatientsState>(
              builder: (context, state) {
                return SliverAppBar(
                  stretch: true,
                  onStretchTrigger: () {
                    return Future<void>.value();
                  },
                  expandedHeight: 250.0,
                  backgroundColor: Colors.white38,
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
                        '${state.patient.name}, geb. am: ${DateFormat.yMMMMd().format(state.patient.birthDate)}, in Therapie seit: ${DateFormat.yMMMMd().format(state.patient.therapyStart)}',
                        style: const TextStyle(color: Colors.black),
                      );
                    }),
                    //Hintergrund
                    background: const Image(
                      image: AssetImage('assets/ReHomeLogo.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
            // Blöcke für detaillierte Informationen über den Patienten
            BlocBuilder<PatientsBloc, PatientsState>(
              builder: (context, state) {
                return SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      const Column(
                        children: [
                          //ZieleWidget
                          ZieleStateful(),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //HausaufgabenWidget
                                HausaufgabenWidget(),
                                //ÜbungenWidget
                                UebungenWidget(),
                              ]),
                        ],
                      ),
                    ],
                  ),
                );
              },
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
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        //PatientsBloc.add(ExpansionChange());
        BlocProvider.of<PatientsBloc>(context).add(ExpansionChange(isExpanded));
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
                title: const Text('Aktuelles Ziel: '),
                onTap: () {
                  BlocProvider.of<PatientsBloc>(context)
                      .add(ExpansionChange(isExpanded));
                  //context.read<PatientsBloc>().add(ExpansionChange());
                });
          },
          body: const ListTile(
            title: Text('Vergangene Ziele: '),
            subtitle: Text(''),
          ),
          //isExpanded: false,
        ),
      ],
    );
  }
}

class ZieleStateful extends StatefulWidget {
  const ZieleStateful({super.key});

  @override
  _ZieleState createState() => _ZieleState();
}

class _ZieleState extends State<ZieleStateful> {
  bool expand = false;

  void setExpansion() {
    setState(() {
      expand = !expand;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setExpansion();
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(title: BlocBuilder<PatientsBloc, PatientsState>(
              builder: (context, state) {
                return const Text('Aktuelles Ziel: ');
              },
            ), onTap: () {
              setExpansion();
            });
          },
          body: const ListTile(
            title: Text('Vergangene Ziele: '),
            subtitle: Text(''),
          ),
          isExpanded: expand,
        ),
      ],
    );
  }
}

class HausaufgabenWidget extends StatelessWidget {
  const HausaufgabenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientsBloc, PatientsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 400,
            width: 500,
            child: Column(
              children: [
                /*Expanded(
                    child: Column(
                  children: [
                    const Text('Montag: '),
                    Text(state.patient.homework.repeated.exercises[Day.MONDAY]
                        .toString())
                  ],
                )),
                const Divider(
                  color: Colors.grey,
                ),
                Expanded(
                    child: Column(
                  children: [
                    const Text('Dienstag: '),
                    Text(state.patient.homework.repeated.exercises[Day.TUESDAY]
                        .toString())
                  ],
                )),
                const Divider(
                  color: Colors.grey,
                ),
                Expanded(
                    child: Column(
                  children: [
                    const Text('Mittwoch: '),
                    Text(state
                        .patient.homework.repeated.exercises[Day.WEDNESDAY]
                        .toString())
                  ],
                )),
                const Divider(
                  color: Colors.grey,
                ),
                Expanded(
                    child: Column(
                  children: [
                    const Text('Donnerstag: '),
                    Text(state.patient.homework.repeated.exercises[Day.THURSDAY]
                        .toString())
                  ],
                )),
                const Divider(
                  color: Colors.grey,
                ),
                Expanded(
                    child: Column(
                  children: [
                    const Text('Freitag: '),
                    Text(state.patient.homework.repeated.exercises[Day.FRIDAY]
                        .toString())
                  ],
                )),
                const Divider(
                  color: Colors.grey,
                ),
                Expanded(
                    child: Column(
                  children: [
                    const Text('Samstag: '),
                    Text(state.patient.homework.repeated.exercises[Day.SATURDAY]
                        .toString())
                  ],
                )),
                const Divider(
                  color: Colors.grey,
                ),
                Expanded(
                    child: Column(
                  children: [
                    const Text('Sonntag: '),
                    Text(state.patient.homework.repeated.exercises[Day.SUNDAY]
                        .toString())
                  ],
                )), */
                _buildDailyExercise('Montag', Day.MONDAY),
                const Divider(),
                _buildDailyExercise('Dienstag', Day.TUESDAY),
                const Divider(),
                _buildDailyExercise('Mittwoch', Day.WEDNESDAY),
                const Divider(),
                _buildDailyExercise('Donnerstag', Day.THURSDAY),
                const Divider(),
                _buildDailyExercise('Freitag', Day.FRIDAY),
                const Divider(),
                _buildDailyExercise('Samstag', Day.SATURDAY),
                const Divider(),
                _buildDailyExercise('Sonntag', Day.SUNDAY),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildDailyExercise(String weekday, Day day) {
  return BlocBuilder<PatientsBloc, PatientsState>(
    builder: (context, state) {
      return Expanded(
        child: Column(
          children: [
            Text(weekday),
            Text(state.patient.homework.repeated.exercises[day]?.toString() ??
                ''),
          ],
        ),
      );
    },
  );
}

class UebungenWidget extends StatelessWidget {
  const UebungenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        width: 500,
        child: BlocBuilder<PatientsBloc, PatientsState>(
          builder: (context, state) {
            return const Card(child: Text('Übungen'));
          },
        ));
  }
}
