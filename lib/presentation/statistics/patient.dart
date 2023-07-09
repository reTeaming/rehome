import 'package:flutter/material.dart';
import 'package:rehome/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// für das 1. Diagramm benötigt man:
// - Die Listenlänge der Hausaufgabe (Anzahl der zu absolvierenden Blöcke)
// - Anzahl der bereits absolvierten Blöcke

class Diagramm1 extends StatelessWidget {
  const Diagramm1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SfCircularChart(
      series: <CircularSeries>[
        RadialBarSeries<ChartData, String>(
            dataSource: homeworkDone,
            xValueMapper: (ChartData data, _) => data.week,
            yValueMapper: (ChartData data, _) => data.done,
            // die Anzahl, die den vollständigen Kreis beschreibt
            maximumValue: 100,
            // Farbe des Kreisbalkens, je nach Fortschritt
            pointColorMapper: (ChartData data, _) {
              if (data.done < 10) {
                return Colors.red;
              } else if (data.done < 50) {
                return Colors.amber;
              } else {
                return Colors.green;
              }
            })
      ],
      // Annotation innerhalb des Kreises
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
            widget: Text(
          //hier muss die Länge der Hausaufgabenliste rein
          '${homeworkDone.first.done} von ?? \n der Blöcke',
          style: const TextStyle(fontSize: 33),
          textAlign: TextAlign.center,
        )),
      ],
      title: ChartTitle(
        alignment: ChartAlignment.near,
        text: 'Diese Woche bereits absolviert:',
        textStyle: rehomeTheme.textTheme.titleLarge,
      ),
    )));
  }
}

// Klasse der benötigten Daten für das Diagramm
class ChartData {
  ChartData(this.week, this.done);
  // week beschreibt den Balken, done beinhaltet die Prozentzahl der Blöcke,
  // und beschreibt somit wie lang der Kreisbalken ist
  final String week;
  final int done;
}

final List<ChartData> homeworkDone = [
  // hier muss die Anzahl der Prozentzahl absolvierten blöcke rein (in Prozent)
  ChartData('dieseWoche', 60),
];
