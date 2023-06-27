import 'package:ReHome/domain/models/patient/homework.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Klasse zur Anbindung von Hausaufgaben spezifischen Funktionen an das Backend
class HomeworkBackend {
  // speichert übergebene Hausaufgabe ins Backend
  // Datenstruktur wird hierfür in Backendstruktur überführt
  Future<ParseResponse> saveHomework(Homework homework) async {
    // initialisiert alle Felder aus homework für schnelleren/angenehmeren Zugriff
    WeekHomework weekHomework = homework.repeated;
    DateTime repeatedSince = homework.repeatedSince;
    Map<Week, WeekHomework> weeks = homework.weeks;

    // initialisiere ParseObject eines Homework Objekts mit ersten Einträgen
    ParseObject parseHomework = ParseObject('Homework')
      ..set('repeatedHomework', parseWeekHomework(weekHomework, null))
      ..set('repeatedSince', repeatedSince);

    // erstelle Liste zur Speicherung aller WeekHomeworks in der weeks map
    List weeksHomeworkList = List.empty();

    // fülle Liste mit WeekHomeworks
    weeks.forEach((week, mapHomework) {
      weeksHomeworkList.add(parseWeekHomework(mapHomework, week));
    });

    // füge WeekHomeworks zum ParseObject hinzu
    parseHomework.set('weekHomeworks', weeksHomeworkList);

    // speichere Homework Objekt im Backend
    ParseResponse response = await parseHomework.save();
    return response;
  }

  ParseObject parseWeekHomework(WeekHomework weekHomework, Week? week) {
    return ParseObject('WeekHomework');
  }
}
