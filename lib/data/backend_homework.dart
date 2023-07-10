import 'package:rehome/data/backend_exercise.dart';
import 'package:rehome/domain/models/patient/exercise.dart';
import 'package:rehome/domain/models/patient/homework.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Klasse zur Anbindung von Hausaufgaben spezifischen Funktionen an das Backend
class HomeworkBackend {
  /*
  * Funktionen zum Abrufen von Hausaufgaben
  */

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
    exercises.forEach((day, blockList) async {
      var parsedExerciseBlock = await parseExerciseBlocks(blockList, day);
      if (parsedExerciseBlock != null) {
        exerciseBlockList.addAll(parsedExerciseBlock);
      }
    });

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
      String name = block.name;
      BlockStatus status = block.status;
      List<Exercise> exercises = block.block;

      // initialisiere ParseObject für den momentanen Block und speichere den Status und den Tag
      ParseObject parseBlock = ParseObject('ExerciseBlock')
        ..set('name', name)
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

  /*
  * Funktionen zum Abrufen von Hausaufgaben
  */

  /// konvertiert gegebenes ParseObject zu Hausaufgabe
  static Future<Homework?> parseToHomework(ParseObject parseHomework) async {
    DateTime repeatedSince = parseHomework.get('repeatedSince');

    WeekHomework? repeated =
        await parseToWeekHomework(parseHomework.get('repeatedHomework'));

    ParseRelation<ParseObject> weekHomeworks =
        parseHomework.get('weekHomeworks');

    ParseResponse query = await weekHomeworks.getQuery().query();

    List<dynamic> parseWeekHomeworks = query.results!;

    // Map zur Speicherung von Hausaufgaben mit zugehöriger Woche
    Map<Week, WeekHomework> weeks = {};
    for (var parseWeekHomework in parseWeekHomeworks) {
      Week week =
          Week(parseWeekHomework.get('week'), parseWeekHomework.get('year'));
      WeekHomework? weekHomework = await parseToWeekHomework(parseWeekHomework);
      if (weekHomework != null) {
        weeks.addAll({week: weekHomework});
      }
    }

    // falls repeated nicht null ist, erstelle Hausaufgaben Object
    if (repeated != null) {
      Homework homework = Homework(repeated, repeatedSince, weeks);
      return homework;
    }
    return null;
  }

  /// konvertiert gegebenes ParseObject zu WeekHomework
  static Future<WeekHomework?> parseToWeekHomework(
      ParseObject parseWeekHomework) async {
    ParseRelation<ParseObject> exerciseBlocks =
        parseWeekHomework.get('exercises');

    ParseResponse query = await exerciseBlocks.getQuery().query();

    List<dynamic> parseExerciseBlocks = query.results!;

    // Map zur Speicherung von Hausaufgaben mit zugehöriger Woche
    Map<Day, List<ExerciseBlock>> exercises = {};

    for (var parseExerciseBlock in parseExerciseBlocks) {
      Day? day = switch (parseExerciseBlock.get('day')) {
        'Day.monday' => Day.monday,
        'Day.tuesday' => Day.tuesday,
        'Day.wednesday' => Day.wednesday,
        'Day.thursday' => Day.thursday,
        'Day.friday' => Day.friday,
        'Day.saturday' => Day.saturday,
        'Day.sunday' => Day.sunday,
        _ => null
      };

      ExerciseBlock? exerciseBlock =
          await parseToExerciseBlock(parseExerciseBlock);

      // setze den exerciseBlock falls dieser und der zugehörigige Tag nicht null ist
      if (exerciseBlock != null && day != null) {
        // update die ExerciseBlock Map mit dem neuen Block
        exercises.update(day, (list) => list..add(exerciseBlock),
            // Falls noch kein Eintrag mit Day vorhanden erstelle neue Liste
            ifAbsent: () => List.empty(growable: true)..add(exerciseBlock));
      }
    }

    return WeekHomework(exercises);
  }

  /// konvertiert gegebenes ParseObject zu ExerciseBlock
  static Future<ExerciseBlock?> parseToExerciseBlock(
      ParseObject parseExerciseBlock) async {
    // Speichern des Status aus Backend
    BlockStatus? status = switch (parseExerciseBlock.get('status')) {
      'BlockStatus.finished' => BlockStatus.finished,
      'BlockStatus.unfinished' => BlockStatus.unfinished,
      _ => null
    };
    String name = parseExerciseBlock.get('name');

    // Abrufen der Exercises aus Backend
    ParseRelation<ParseObject> exercises = parseExerciseBlock.get('exercise');
    ParseResponse query = await exercises.getQuery().query();
    List<dynamic> parseExercises = query.results!;

    // liste der konvertierten Exercises
    List<Exercise> block = List.empty(growable: true);

    // parsen und speichern der Exercises in Liste
    for (var parseExercise in parseExercises) {
      Exercise? exercise = await ExerciseBackend.parseToExercise(parseExercise);
      if (exercise != null) {
        block.add(exercise);
      }
    }
    if (status != null) {
      return ExerciseBlock(name, block, status);
    }
    return null;
  }
}
