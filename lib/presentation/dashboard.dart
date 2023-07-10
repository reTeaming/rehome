// Erster Entwurf vom Dashboard (erstmal hauptsächlich um das Scrollbar Widget zu testen)
import 'package:flutter/material.dart';
import 'package:rehome/theme.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            backgroundColor: white,
            title: Text(
              'Dashboard',
              style: TextStyle(
                color: Color(0xFF2E2E48),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid.count(
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              crossAxisCount: 3,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                      color: myCol,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: const EdgeInsets.all(8),
                  child: const Text(statistik1),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: myCol,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: const EdgeInsets.all(8),
                  child: const Text(statistik2),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: myCol,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: const EdgeInsets.all(8),
                  child: const Text(statistik3),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: myCol,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: const EdgeInsets.all(8),
                  child: const Text(statistik4),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: myCol,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: const EdgeInsets.all(8),
                  child: const Text(statistik5),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: myCol,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: const EdgeInsets.all(8),
                  child: const Text(statistik6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const myCol = Color.fromARGB(255, 221, 240, 255);
const statistik1 =
    "Statistik 1: \n Anzahl aktiver Patienten, Anzahl Patienten Archiv \n benötigte Daten: Anbindung Patienten Backend";
const statistik2 =
    "Statistik 2: \n durchschnittlich absolvierte Trainingszeit in dieser Woche, evtl. Trendansicht über einen Monat, die am häufigsten durchgeführte Übung \n benötigte Daten: Übungsdaten Backend";
const statistik3 =
    "Statistik 3: \n TODOs meiner Patienten \n benötigte Daten: Übungen Backend";
const statistik4 =
    "Statistik 4: \n Übung mit der höchsten Erfolgsquote, Übung mit der schlechtesten Erfolgsquote \n benötigte Daten: Übungen Backend";
const statistik5 =
    "Statistik 5: \n die Zuletzt absolvierten Übungen mit zugehörigem Patientenname \n benötigte Daten: Übungen Backend, Patientendaten Backend";
const statistik6 =
    "Statistik 6: \n Auszeichnungen: Patient X hat alle Übungen für diese Woche abgeschlossen \n benötigte Daten: Übungen Backend, Patientendaten Backend";
