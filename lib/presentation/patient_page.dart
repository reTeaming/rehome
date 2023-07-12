import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rehome/business_logic/patient/patient_bloc.dart';
import 'package:rehome/domain/models/patient/exercise.dart';
import 'package:rehome/domain/models/patient/homework.dart';
import 'package:rehome/presentation/statistics/patient.dart';

// Screen für die Patientendaten
class PatientPage extends StatelessWidget {
  const PatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    // übergibt Patient aus dem Repository
    return CustomScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: <Widget>[
        // scrollbare Appbar
        BlocBuilder<PatientBloc, PatientState>(
          builder: (context, state) {
            final String therapyStart =
                state.active!.therapyStart?.toString() ??
                    "Kein Startzeitpunkt angegeben";
            return SliverAppBar(
              // Parameter, wann/wie Appbar zu sehen ist
              pinned: true,
              floating: false,
              stretch: false,
              onStretchTrigger: () {
                return Future<void>.value();
              },
              // Aussehen der Appbar (Höhe, Farbe)
              expandedHeight: 250.0,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                // Mode für das "Nach-Oben-Ziehen"- des Screens
                stretchModes: const <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                // Titel der Seite (Namen, Geburtstag und Therapiestart des Patienten)
                centerTitle: false,
                title: Text(
                  '${state.active!.name}, geb. am: ${DateFormat.yMMMMd().format(state.active!.birthDate)}, in Therapie seit: $therapyStart',
                  style: const TextStyle(color: Colors.black),
                ),
                //Hintergrund
                //background: const Image(
                // image: AssetImage('assets/ReHomeLogo.png'),
                // fit: BoxFit.fill,
                //),
              ),
            );
          },
        ),
        // Body des Screens
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              const Column(
                children: [
                  //ZieleWidget
                  ZieleStateful(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [ExerciseDoneDiagramm(), HoursSpentDiagramm()]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    //HausaufgabenWidget
                    HausaufgabenWidget(),
                    //ÜbungenWidget
                    UebungenWidget(),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    TotalDiagramm(),
                    RangeDiagramm(Joint.shoulder),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    RangeDiagramm(Joint.ellbow),
                    RangeDiagramm(Joint.wrist)
                  ]),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ausklappbares ZieleWidget
class ZieleStateful extends StatefulWidget {
  const ZieleStateful({super.key});

  @override
  State<ZieleStateful> createState() => _ZieleState();
}

// Ausklapp-State
class _ZieleState extends State<ZieleStateful> {
  bool expand = false;

// Ändern des Ausklapp-State
  void setExpansion() {
    setState(() {
      expand = !expand;
    });
  }

// Widget
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setExpansion();
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            // Permanentes ListTile des aktuellen Ziels
            return ListTile(
                title: BlocBuilder<PatientBloc, PatientState>(
                  builder: (context, state) {
                    return const Text('Aktuelles Ziel: ');
                  },
                ),
                subtitle: const Text('Tippen, um vergangene Ziele anzuzeigen'),
                onTap: () {
                  setExpansion();
                });
          },
          // Ausklappbare Liste vergangener Ziele
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
    return BlocBuilder<PatientBloc, PatientState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 400,
            width: 500,
            child: Column(
              children: [
                _buildDayColumn('Montag', Day.monday),
                const Divider(),
                _buildDayColumn('Dienstag', Day.tuesday),
                const Divider(),
                _buildDayColumn('Mittwoch', Day.wednesday),
                const Divider(),
                _buildDayColumn('Donnerstag', Day.thursday),
                const Divider(),
                _buildDayColumn('Freitag', Day.friday),
                const Divider(),
                _buildDayColumn('Samstag', Day.saturday),
                const Divider(),
                _buildDayColumn('Sonntag', Day.sunday),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Hilfswidget zum generieren der Aufgabenliste für jeden Tag
Widget _buildDayColumn(String weekday, Day day) {
  return BlocBuilder<PatientBloc, PatientState>(
    builder: (context, state) {
      return Expanded(
        child: Column(
          children: [
            Text(weekday),
            Text(state.active?.homework.repeated.exercises[day]?.toString() ??
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

// bisheriger Platzhalter für Übungswidget
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 400,
        width: 300,
        child: BlocBuilder<PatientBloc, PatientState>(
          builder: (context, state) {
            return const Card(child: Text('Übungen'));
          },
        ));
  }
}
