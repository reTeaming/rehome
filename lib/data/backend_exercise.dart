import 'package:rehome/domain/models/patient/default_exercise.dart';
import 'package:rehome/domain/models/patient/exercise.dart';
import 'package:rehome/domain/models/user/id.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Klasse zur Anbindung von Exercise spezifischen Funktionen an das Backend
class ExerciseBackend {
  // konvertiert gegebenes Exercise Object zu einem ParseObject
  static Future<ParseObject?> parseExercise(Exercise exercise) async {
    // initialisiert variablen des Exercise Objekts zur angenehmeren Benutzung
    DefaultExercise exerciseType = exercise.exerciseType;
    List<ParameterSet> parameters = exercise.parameter;
    Map<DateTime, List<ParameterSet>> results = exercise.results;

    // Erstellung eines Parse Exercise Objects
    ParseObject parseExercise = ParseObject('Exercise');

    // Setzen des exerciseTypes in ParseObject
    var parsedDefaultExercise = await parseDefaultExercise(exerciseType);
    if (parsedDefaultExercise != null) {
      parseExercise.set('exerciseType', parsedDefaultExercise);
    }

    List<ParseObject> parameterList = List.empty(growable: true);

    // konvertiere jeden Parameter zu einem ParseObject
    for (var parameter in parameters) {
      var parsedParameter = await parseParameterSet(parameter, results);
      if (parsedParameter != null) parameterList.add(parsedParameter);
    }

    // füge Liste mit Parse Parameter Objekten der Liste hinzu
    parseExercise.addRelation('parameters', parameterList);

    ParseResponse response = await parseExercise.save();
    ParseObject? savedExercise = response.results?.first;

    return savedExercise;
  }

  // konvertiert gegebenes DefaultExercise Object zu einem ParseObject
  static Future<ParseObject?> parseDefaultExercise(
      DefaultExercise exerciseType) async {
    // initialisiert variablen des DefaultExercise Objekts zur angenehmeren Benutzung
    String name = exerciseType.name;
    Id id = exerciseType.id;

    // Erstellung eines Parse Exercise Objects mit der Id und Namen
    ParseObject parseDefaultExercise = ParseObject('DefaultExercise')
      ..set('typeId', id.id)
      ..set('name', name);

    ParseResponse response = await parseDefaultExercise.save();
    ParseObject? savedExercise = response.results?.first;

    return savedExercise;
  }

  // konvertiert gegebenes ParameterSet Object zu einem ParseObject
  // setzt falls vorhanden das Datum, an welchem die Übung geschafft wurde
  static Future<ParseObject?> parseParameterSet(
      ParameterSet parameter, Map<DateTime, List<ParameterSet>> results) async {
    // initialisiert vairablen des Exercise Objekts zur angenehmeren Benutzung
    int repetition = parameter.repetition;
    String name = parameter.name;

    // Erstellung eines ParameterSet ParseObjects mit dem gegebenem Namen und der Anzahl repetitions
    ParseObject parseParameter = ParseObject('ParameterSet')
      ..set('name', name)
      ..set('repetition', repetition);

    // Durchsuche results Liste nach gegebenem Parameter
    results.forEach((date, parameterList) {
      if (parameterList.contains(parameter)) {
        // Falls vorhanden, setze das Datum ins parseObject
        parseParameter.set('achievedAt', date);
      }
    });

    // schaue nach, welche Kind-Klasse der Abstrakten ParameterSet Klasse implementiert wurde
    // füge je nachdem, dem ParseObject den richtigen Pointer hinzu
    switch (parameter.runtimeType) {
      case Cocontraction:
        parameter as Cocontraction;
        var parsedParameter = await parseCocontraction(parameter);
        if (parsedParameter != null) {
          parseParameter.set('cocontraction', parsedParameter);
        }
        break;
      case Jerk:
        parameter as Jerk;
        var parsedParameter = await parseJerk(parameter);
        if (parsedParameter != null) {
          parseParameter.set('jerk', parsedParameter);
        }
        break;
      case RangeOfMotion:
        parameter as RangeOfMotion;
        var parsedParameter = await parseRangeOfMotion(parameter);
        if (parsedParameter != null) {
          parseParameter.set('rangeOfMotion', parsedParameter);
        }
        break;
      // Hier sollte bestenfalls kein Parameter landen
      default:
    }

    ParseResponse response = await parseParameter.save();
    ParseObject? savedParameter = response.results?.first;
    return savedParameter;
  }

  // konvertiert gegebenes ParameterSet Object zu einem RangeOfMotion ParseObject
  static Future<ParseObject?> parseRangeOfMotion(
      RangeOfMotion parameterSet) async {
    ParseObject parameter = ParseObject('RangeOfMotion')
      ..set('joint', parameterSet.joint.toString())
      ..set('value', parameterSet.value.value);

    ParseResponse response = await parameter.save();
    ParseObject? savedParameter = response.results?.first;
    return savedParameter;
  }

  // konvertiert gegebenes ParameterSet Object zu einem Jerk ParseObject
  static Future<ParseObject?> parseJerk(Jerk parameterSet) async {
    ParseObject parameter = ParseObject('Jerk')
      ..set('value', parameterSet.value.value);

    ParseResponse response = await parameter.save();
    ParseObject? savedParameter = response.results?.first;
    return savedParameter;
  }

  // konvertiert gegebenes ParameterSet Object zu einem Cocontraction ParseObject
  static Future<ParseObject?> parseCocontraction(
      Cocontraction parameterSet) async {
    ParseObject parameter = ParseObject('Cocontraction')
      ..set('extensor1', parameterSet.extensor1.value)
      ..set('extensor2', parameterSet.extensor2.value)
      ..set('extensor3', parameterSet.extensor3.value)
      ..set('flexor1', parameterSet.flexor1.value)
      ..set('flexor2', parameterSet.flexor2.value)
      ..set('flexor3', parameterSet.flexor3.value);

    ParseResponse response = await parameter.save();
    ParseObject? savedParameter = response.results?.first;
    return savedParameter;
  }
}
