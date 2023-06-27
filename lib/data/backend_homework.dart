import 'package:ReHome/domain/models/patient/homework.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Klasse zur Anbindung von Hausaufgaben spezifischen Funktionen an das Backend
class HomeworkBackend {
  // speichert übergebene Hausaufgabe ins Backend
  // Datenstruktur wird hierfür in Backendstruktur überführt
  Future<ParseResponse> saveHomework(Homework homework) async {
    WeekHomework weekHomework = homework.repeated;
    DateTime repeatedSince = homework.repeatedSince;
    Map<Week, WeekHomework> weeks = homework.weeks;

    ParseObject parseHomework = ParseObject('Homework')
      ..set('repeatedHomework', parseWeekHomework(weekHomework, null))
      ..set('repeatedSince', repeatedSince);

    List weeksHomeworkList = List.empty();

    weeks.forEach((week, mapHomework) {
      weeksHomeworkList.add(parseWeekHomework(mapHomework, week));
    });

    parseHomework.set('weekHomeworks', weeksHomeworkList);

    ParseResponse response = await parseHomework.save();
    return response;
  }

  ParseObject parseWeekHomework(WeekHomework weekHomework, Week? week) {
    return ParseObject('WeekHomework');
  }
}
