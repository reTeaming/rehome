import 'package:rehome/data/backend_exercise.dart';
import 'package:rehome/domain/models/patient/exercise.dart';
import 'package:rehome/domain/models/patient/homework.dart';
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
      ..set('repeatedHomework', await parseWeekHomework(weekHomework, null))
      ..set('repeatedSince', repeatedSince);

    // erstelle Liste zur Speicherung aller WeekHomeworks in der weeks map
    List<ParseObject> weeksHomeworkList = List.empty(growable: true);

    // fülle Liste mit WeekHomeworks
    weeks.forEach((week, mapHomework) async {
      var parsedWeekHomework = await parseWeekHomework(weekHomework, week);
      if (parsedWeekHomework != null) weeksHomeworkList.add(parsedWeekHomework);
    });

    // füge WeekHomeworks zum ParseObject hinzu
    parseHomework.addRelation('weekHomeworks', weeksHomeworkList);

    // speichere Homework Objekt im Backend
    ParseResponse response = await parseHomework.save();

    return response;
  }

  // konvertiert gegebene WeekHomework in ein Backend ParseObject
  // falls Week mitgegeben wird, wird diese mit abgespeichert
  static Future<ParseObject?> parseWeekHomework(
      WeekHomework weekHomework, Week? week) async {
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
    List<ParseObject> exerciseBlockList = List.empty(growable: true);

    // fülle Liste mit Exercise Blöcken
    for (var entry in exercises.entries) {
      var day = entry.key;
      var blockList = entry.value;
      var parsedExerciseBlock = await parseExerciseBlocks(blockList, day);
      if (parsedExerciseBlock != null) {
        exerciseBlockList += parsedExerciseBlock;
      }
    }

    // füge ExerciseBlocks zum ParseObject hinzu
    parseWeekHomework.addRelation('exercises', exerciseBlockList);

    ParseResponse response = await parseWeekHomework.save();
    ParseObject savedWeekHomework = response.results?.first;

    return savedWeekHomework;
  }

  // konvertiert gegebenen ExerciseBlock in ein Backend ParseObject
  static Future<List<ParseObject>?> parseExerciseBlocks(
      List<ExerciseBlock> exerciseBlocks, Day day) async {
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
      List<ParseObject> exerciseList = List.empty(growable: true);
      // fülle Liste mit Exercises
      for (var exercise in exercises) {
        var parsedExercise = await ExerciseBackend.parseExercise(exercise);
        if (parsedExercise != null) {
          exerciseList.add(parsedExercise);
        }
      }

      // füge Exercises zum ParseObject hinzu
      parseBlock.addRelation('exercise', exerciseList);

      ParseResponse response = await parseBlock.save();

      // füge den Parse Exercise Block der Liste hinzu
      if (response.success) parseBlockList.add(response.results!.first);
    }

    return parseBlockList;
  }
}
