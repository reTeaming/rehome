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
        RadialBarSeries<ChartData1, String>(
            dataSource: homeworkDone,
            xValueMapper: (ChartData1 data, _) => data.week,
            yValueMapper: (ChartData1 data, _) => data.done,
            // die Anzahl, die den vollständigen Kreis beschreibt
            maximumValue: 100,
            // Farbe des Kreisbalkens, je nach Fortschritt
            pointColorMapper: (ChartData1 data, _) {
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
      // Titel des Diagramms
      title: ChartTitle(
        alignment: ChartAlignment.near,
        text: 'Diese Woche bereits absolviert:',
        textStyle: rehomeTheme.textTheme.titleLarge,
      ),
    )));
  }
}

// Klasse der benötigten Daten für das Diagramm
class ChartData1 {
  ChartData1(this.week, this.done);
  // week beschreibt den Balken, done beinhaltet die Prozentzahl der Blöcke,
  // und beschreibt somit wie lang der Kreisbalken ist
  final String week;
  final int done;
}

final List<ChartData1> homeworkDone = [
  // hier muss die Anzahl der Prozentzahl absolvierten blöcke rein (in Prozent)
  ChartData1('dieseWoche', 60),
];

class Diagramm2 extends StatelessWidget {
  const Diagramm2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SfCartesianChart(
        enableAxisAnimation: true,
        series: <ChartSeries<ChartData2, String>>[
          // Renders column chart
          ColumnSeries<ChartData2, String>(
              dataSource: hoursSpent,
              xValueMapper: (ChartData2 data, _) => data.week,
              yValueMapper: (ChartData2 data, _) => data.hours,
              color: primaryColor)
        ],
        primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
          autoScrollingDelta: 5,
          autoScrollingMode: AutoScrollingMode.end,
        ),
        zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
        title: ChartTitle(
          alignment: ChartAlignment.near,
          text: 'Übungsstunden pro Woche:',
          textStyle: rehomeTheme.textTheme.titleLarge,
        ),
      ),
    ));
  }
}

class ChartData2 {
  ChartData2(
    this.week,
    this.hours,
  );
  final String week;
  final double hours;
}

final List<ChartData2> hoursSpent = [
  ChartData2('Woche 1', 5),
  ChartData2('Woche 2', 6),
  ChartData2('Woche 3', 3),
  ChartData2('Woche 4', 4),
  ChartData2('Woche 5', 6),
  ChartData2('Woche 1', 5),
  ChartData2('Woche 2', 6),
  ChartData2('Woche 3', 3),
  ChartData2('Woche 4', 4),
  ChartData2('Woche 10', 6),
  ChartData2('Woche 11', 5),
  ChartData2('Woche 12', 6),
  ChartData2('Woche 13', 3),
  ChartData2('Woche 14', 4),
  ChartData2('Woche 15', 6)
];
