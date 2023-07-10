import 'package:flutter/material.dart';
import 'package:rehome/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../../domain/models/patient/exercise.dart';

// für das 1. Diagramm benötigt man:
// - Die Listenlänge der Hausaufgabe (Anzahl der zu absolvierenden Blöcke)
// - Anzahl der bereits absolvierten Blöcke

class ExerciseDoneDiagramm extends StatelessWidget {
  const ExerciseDoneDiagramm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SfCircularChart(
      series: <CircularSeries>[
        //Daten des Kreisbalkendiagramms
        RadialBarSeries<ExerciseDoneData, String>(
            dataSource: homeworkDone,
            xValueMapper: (ExerciseDoneData data, _) => data.week,
            yValueMapper: (ExerciseDoneData data, _) => data.done,
            // die Anzahl, die den vollständigen Kreis beschreibt
            maximumValue: 100,
            // Farbe des Kreisbalkens, je nach Fortschritt
            pointColorMapper: (ExerciseDoneData data, _) {
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

// Klasse der benötigten Daten für das ExerciseDoneDiagramm
class ExerciseDoneData {
  ExerciseDoneData(this.week, this.done);
  // week beschreibt den Balken, done beinhaltet die Prozentzahl der Blöcke,
  // und beschreibt somit wie lang der Kreisbalken ist
  final String week;
  final int done;
}

// hier muss die Anzahl der Prozentzahl absolvierten blöcke rein (in Prozent)
final List<ExerciseDoneData> homeworkDone = [
  ExerciseDoneData('dieseWoche', 60),
];

// für das 2. Diagramm benötigt man:
// - die absolvierten Übungsstunden pro Woche

class HoursSpentDiagramm extends StatelessWidget {
  const HoursSpentDiagramm({super.key});

  @override
  Widget build(BuildContext context) {
    // Ausrechnen der Gesamtzeit der Übungsstunden
    double sum = hoursSpent.map((item) => item.hours).reduce((x, y) => x + y);
    return Scaffold(
        body: Center(
      child: SfCartesianChart(
        //Automatische Anpassung der Axen beim Verchieben
        enableAxisAnimation: true,
        series: <ChartSeries<PracticeHoursData, String>>[
          // Bildet Säulendiagramm
          ColumnSeries<PracticeHoursData, String>(
              dataSource: hoursSpent,
              xValueMapper: (PracticeHoursData data, _) => data.week,
              yValueMapper: (PracticeHoursData data, _) => data.hours,
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
        // Anzeige der Gesamtübungsstunden
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
        ),
      ),
    ));
  }
}

// Klasse der benötigten Daten für das HoursSpentDiagramm
class PracticeHoursData {
  PracticeHoursData(
    this.week,
    this.hours,
  );
  // week beschreibt die betrachtete Woche
  // hours beschreibt die Anzahl der Übungsstunden in dieser Woche
  final String week;
  final double hours;
}

//hier muss die Liste der Wochen und Übungsstunden rein
final List<PracticeHoursData> hoursSpent = [
  PracticeHoursData('Woche 1', 2),
  PracticeHoursData('Woche 2', 6),
  PracticeHoursData('Woche 3', 3),
  PracticeHoursData('Woche 4', 4),
  PracticeHoursData('Woche 5', 6),
  PracticeHoursData('Woche 6', 5),
  PracticeHoursData('Woche 7', 6),
  PracticeHoursData('Woche 8', 3),
  PracticeHoursData('Woche 9', 4),
  PracticeHoursData('Woche 10', 6),
  PracticeHoursData('Woche 11', 5),
  PracticeHoursData('Woche 12', 6),
  PracticeHoursData('Woche 13', 3),
  PracticeHoursData('Woche 14', 4),
  PracticeHoursData('Woche 15', 6)
];

// für das 3. Diagramm benötigt man:
// - Die einzelnen erreichten Werte der Übung des jeweiligen Gelenks
// - Die jeweiligen geplanten Werte/Zielwerte der Übung des jeweiligen Gelenks
// - beide Werte mit Datum (gleiches Datum!!)

class RangeDiagramm extends StatelessWidget {
  // beschreibt das Gelenk für das das Diagramm die Werte anzeigen soll
  final Joint joint;
  const RangeDiagramm(this.joint, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SfCartesianChart(
      series: <ChartSeries>[
        // Daten für die erzielten Ergebnisse
        LineSeries<RangeData, DateTime>(
          dataSource: expectationData,
          xValueMapper: (RangeData data, _) => data.date,
          yValueMapper: (RangeData data, _) => data.range,
          color: Colors.red,
          name: 'Ziel',
        ),
        LineSeries<RangeData, DateTime>(
            dataSource: achievedData,
            xValueMapper: (RangeData data, _) => data.date,
            yValueMapper: (RangeData data, _) => data.range,
            color: primaryColor,
            name: 'erreichter Wert'),
      ],
      //Format der x-Achse
      primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat.yMMMMd(),
        // wie viele Tage angezeigt werden (von hinten)
        autoScrollingDelta: 30,
        autoScrollingDeltaType: DateTimeIntervalType.days,
        autoScrollingMode: AutoScrollingMode.end,
        enableAutoIntervalOnZooming: true,
      ),
      // Möglichkeit zu scrollen
      zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
      // Titel des Diagramms abhängig vom Gelenk
      title: ChartTitle(
        alignment: ChartAlignment.near,
        text: switch (joint) {
          Joint.ellbow => 'Verlauf des Bewegungsradius am Ellenbogen: ',
          Joint.shoulder => 'Verlauf des Bewegungsradius an der Schulter:',
          Joint.wrist => 'Verlauf des Bewegungsradius am Handgelenk:',
        },
        textStyle: rehomeTheme.textTheme.titleLarge,
      ),
      legend: const Legend(
        isVisible: true,
        position: LegendPosition.bottom,
      ),
    )));
  }
}

// Klasse der benötigten Daten für das RangeDiagramm
class RangeData {
  RangeData(this.date, this.range);
  //date beschreibt das Datum, wann die Übung ausgeführt wurde
  //range die jeweiligen Werte
  final DateTime date;
  final double range;
}

//hier müssen die jeweiligen geplanten Werte/Zielwerte der Übung des jeweiligen
// Gelenks  rein
final List<RangeData> expectationData = [
  RangeData(DateTime(2023, 3, 14, 16, 12, 44, 36), 0.2),
  RangeData(DateTime(2023, 3, 15, 16, 12, 44, 36), 0.4),
  RangeData(DateTime(2023, 3, 17, 16, 12, 44, 36), 0.5),
  RangeData(DateTime(2023, 3, 18, 16, 12, 44, 36), 0.5),
  RangeData(DateTime(2023, 3, 22, 16, 12, 44, 36), 0.6)
];

//hier müssen die einzelnen erreichten Werte der Übung des jeweiligen
// Gelenks rein
final List<RangeData> achievedData = [
  RangeData(DateTime(2023, 3, 14, 16, 12, 44, 36), 0.1),
  RangeData(DateTime(2023, 3, 15, 16, 12, 44, 36), 0.3),
  RangeData(DateTime(2023, 3, 17, 16, 12, 44, 36), 0.3),
  RangeData(DateTime(2023, 3, 18, 16, 12, 44, 36), 0.4),
  RangeData(DateTime(2023, 3, 22, 16, 12, 44, 36), 0.5)
];

// für das 4. Diagramm benötigt man:
// - Die gesamten Parameterwerte gemittelt nach einer Übung

class TotalDiagramm extends StatelessWidget {
  const TotalDiagramm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SfCartesianChart(
      series: <ChartSeries>[
        // Daten für die erzielten Ergebnisse
        LineSeries<TotalData, DateTime>(
          dataSource: totalData,
          xValueMapper: (TotalData data, _) => data.date,
          yValueMapper: (TotalData data, _) => data.values,
          color: primaryColor,
          name: 'Gesamtdaten',
        ),
      ],
      //Format der x-Achse
      primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat.yMMMMd(),
        // wie viele Tage angezeigt werden (von hinten)
        autoScrollingDelta: 30,
        autoScrollingDeltaType: DateTimeIntervalType.days,
        autoScrollingMode: AutoScrollingMode.end,
        enableAutoIntervalOnZooming: true,
      ),
      // Möglichkeit zu scrollen
      zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
      // Titel des Diagramms
      title: ChartTitle(
        alignment: ChartAlignment.near,
        text: 'Gesamtverlauf der Therapie ',
        textStyle: rehomeTheme.textTheme.titleLarge,
      ),
      legend: const Legend(
        isVisible: true,
        position: LegendPosition.bottom,
      ),
    )));
  }
}

// Klasse der benötigten Daten für das TotalDiagramm
class TotalData {
  TotalData(this.date, this.values);
  //date beschreibt das Datum, wann die letzte Übung ausgeführt wurde (und der
  // Gesamtwert neu berechnet wurde)
  // values  die jeweiligen Werte
  final DateTime date;
  final double values;
}

//hier müssen die gemittelten Gesamtwerte rein
final List<TotalData> totalData = [
  TotalData(DateTime(2023, 3, 14, 16, 12, 44, 36), 0.2),
  TotalData(DateTime(2023, 3, 15, 16, 12, 44, 36), 0.4),
  TotalData(DateTime(2023, 3, 17, 16, 12, 44, 36), 0.5),
  TotalData(DateTime(2023, 3, 18, 16, 12, 44, 36), 0.5),
  TotalData(DateTime(2023, 3, 22, 16, 12, 44, 36), 0.6)
];
