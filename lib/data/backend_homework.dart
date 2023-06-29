import 'package:ReHome/data/backend_exercise.dart';
import 'package:ReHome/domain/models/patient/exercise.dart';
import 'package:ReHome/domain/models/patient/homework.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Klasse zur Anbindung von Hausaufgaben spezifischen Funktionen an das Backend
class HomeworkBackend {
  // speichert übergebene Hausaufgabe ins Backend
  // Datenstruktur wird hierfür in Backendstruktur überführt
  static Future<ParseResponse> saveHomework(Homework homework) async {
    // initialisiert alle Felder aus homework für schnelleren/angenehmeren Zugriff
    WeekHomework weekHomework = homework.repeated;
    DateTime repeatedSince = homework.repeatedSince;
    Map<Week, WeekHomework> weeks = homework.weeks;

    // initialisiere ParseObject eines Homework Objekts mit ersten Einträgen
    ParseObject parseHomework = ParseObject('Homework')
      ..set(
          'repeatedHomework',
          parseWeekHomework(weekHomework,
              null)) // TODO: austesten ob Homework erst erstellt werden muss
      ..set('repeatedSince', repeatedSince);

    // erstelle Liste zur Speicherung aller WeekHomeworks in der weeks map
    List weeksHomeworkList = List.empty(growable: true);

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

  // konvertiert gegebene WeekHomework in ein Backend ParseObject
  // falls Week mitgegeben wird, wird diese mit abgespeichert
  static ParseObject parseWeekHomework(WeekHomework weekHomework, Week? week) {
    int? year = week?.year;
    int? weekNumber = week?.weekNumber;
    Map<Day, List<ExerciseBlock>> exercises = weekHomework.exercises;

    ParseObject parseWeekHomework = ParseObject('WeekHomework');

    if (week != null) {
      parseWeekHomework
        ..set('year', year)
        ..set('week', weekNumber);
    }

    // erstelle Liste zur Speicherung aller ExerciseBlocks in der Exersises Map
    List exerciseBlockList = List.empty(growable: true);

    // fülle Liste mit Exercise Blöcken
    exercises.forEach((day, blockList) {
      exerciseBlockList.addAll(parseExerciseBlocks(blockList,
          day)); // TODO: austesten ob ParseObject erst erstellt werden muss
    });

    // füge ExerciseBlocks zum ParseObject hinzu
    parseWeekHomework.set('exercises', exerciseBlockList);

    return parseWeekHomework;
  }

  // konvertiert gegebenen ExerciseBlock in ein Backend ParseObject
  static List<ParseObject> parseExerciseBlocks(
      List<ExerciseBlock> exerciseBlocks, Day day) {
    // initialisiere Liste zum speichern der geparsten Blöcke
    List<ParseObject> parseBlockList = List.empty(growable: true);
    // iteriere über alle gegebenen Blöcke
    for (var block in exerciseBlocks) {
      // initialisiere variablen des übergebenen Blocks für angenehmere Aufrufe
      BlockStatus status = block.status;
      List<Exercise> exercises = block.block;

      // initialisiere ParseObject für den momentanen Block und speichere den Status und den Tag
      ParseObject parseBlock = ParseObject('ExerciseBlock')
        ..set('status', status.toString())
        ..set('day', day.toString());

      // erstelle Liste zur Speicherung aller Exercises in dem momentanen ExersiseBlock
      List exerciseList = List.empty(growable: true);
      // fülle Liste mit Exercises
      for (var exercise in exercises) {
        exerciseList.add(ExerciseBackend.parseExercise(
            exercise)); // TODO: austesten ob ParseObject erst erstellt werden muss
      }

      // füge Exercises zum ParseObject hinzu
      parseBlock.set('exercise', exerciseList);

      // füge den Parse Exercise Block der Liste hinzu
      parseBlockList.add(parseBlock);
    }
    return parseBlockList;
  }
}
