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

// Klasse der benötigten Daten für das Diagramm1
class ChartData1 {
  ChartData1(this.week, this.done);
  // week beschreibt den Balken, done beinhaltet die Prozentzahl der Blöcke,
  // und beschreibt somit wie lang der Kreisbalken ist
  final String week;
  final int done;
}

// hier muss die Anzahl der Prozentzahl absolvierten blöcke rein (in Prozent)
final List<ChartData1> homeworkDone = [
  ChartData1('dieseWoche', 60),
];

// für das 2. Diagramm benötigt man:
// - die absolvierten Übungsstunden pro Woche

class Diagramm2 extends StatelessWidget {
  const Diagramm2({super.key});

  @override
  Widget build(BuildContext context) {
    double sum = hoursSpent.map((item) => item.hours).reduce((x, y) => x + y);
    return Scaffold(
        body: Center(
      child: SfCartesianChart(
        //Automatische Anpassung der Axen beim Verchieben
        enableAxisAnimation: true,
        series: <ChartSeries<ChartData2, String>>[
          // Bildet Säulendiagramm
          ColumnSeries<ChartData2, String>(
              dataSource: hoursSpent,
              xValueMapper: (ChartData2 data, _) => data.week,
              yValueMapper: (ChartData2 data, _) => data.hours,
              color: primaryColor,
              name: '${'Gesamtzeit:$sum'}Stunden')
        ],
        primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
          // wie viele Wochen angezeigt werden (von hinten)
          autoScrollingDelta: 5,
          autoScrollingMode: AutoScrollingMode.end,
        ),
        //Möglichkeit zu scrollen
        zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
        // Titel
        title: ChartTitle(
          alignment: ChartAlignment.near,
          text: 'Übungsstunden pro Woche:',
          textStyle: rehomeTheme.textTheme.titleLarge,
        ),
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
        ),
      ),
    ));
  }
}

// Klasse der benötigten Daten für das Diagramm1
class ChartData2 {
  ChartData2(
    this.week,
    this.hours,
  );
  // week beschreibt die betrachtete Woche
  // hours beschreibt die Anzahl der Übungsstunden in dieser Woche
  final String week;
  final double hours;
}

//hier muss die Liste der Wochen und Übungsstunden rein
final List<ChartData2> hoursSpent = [
  ChartData2('Woche 1', 2),
  ChartData2('Woche 2', 6),
  ChartData2('Woche 3', 3),
  ChartData2('Woche 4', 4),
  ChartData2('Woche 5', 6),
  ChartData2('Woche 6', 5),
  ChartData2('Woche 7', 6),
  ChartData2('Woche 8', 3),
  ChartData2('Woche 9', 4),
  ChartData2('Woche 10', 6),
  ChartData2('Woche 11', 5),
  ChartData2('Woche 12', 6),
  ChartData2('Woche 13', 3),
  ChartData2('Woche 14', 4),
  ChartData2('Woche 15', 6)
];
