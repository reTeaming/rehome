import 'package:ReHome/domain/models/patient/exercise.dart';
import 'package:ReHome/domain/models/user/id.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Klasse zur Anbindung von Exercise spezifischen Funktionen an das Backend
class ExerciseBackend {
  // konvertiert gegebenes Exercise Object zu einem ParseObject
  static ParseObject parseExercise(Exercise exercise) {
    // initialisiert vairablen des Exercise Objekts zur angenehmeren Benutzung
    Id id = exercise.id;
    List<ParameterSet> parameters = exercise.parameter;
    Map<DateTime, List<ParameterSet>> results = exercise.results;

    // Erstellung eines Parse Exercise Objects mit der Id
    ParseObject parseExercise = ParseObject('Exercise')..set('id', id);

    List parameterList = List.empty(growable: true);

    // konvertiere jeden Parameter zu einem ParseObject
    for (var parameter in parameters) {
      parameterList.add(parseParameterSet(parameter, results));
    }

    // füge Liste mit Parse Parameter Objekten der Liste hinzu
    parseExercise.set('parameters', parameterList);

    return parseExercise;
  }

  // konvertiert gegebenes ParameterSet Object zu einem ParseObject
  // setzt falls vorhanden das Datum, an welchem die Übung geschafft wurde
  static ParseObject parseParameterSet(
      ParameterSet parameter, Map<DateTime, List<ParameterSet>> results) {
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
        parseParameter.set('cocontraction', parseCocontraction(parameter));
        break;
      case Jerk:
        parameter as Jerk;
        parseParameter.set('jerk', parseJerk(parameter));
        break;
      case RangeOfMotion:
        parameter as RangeOfMotion;
        parseParameter.set('rangeOfMotion', parseRangeOfMotion(parameter));
        break;
      // Hier sollte bestenfalls kein Parameter landen
      default:
    }
    return parseParameter;
  }

  // konvertiert gegebenes ParameterSet Object zu einem RangeOfMotion ParseObject
  static ParseObject parseRangeOfMotion(RangeOfMotion parameterSet) {
    ParseObject parameter = ParseObject('RangeOfMotion')
      ..set('joint', parameterSet.joint)
      ..set('value', parameterSet.value);

    return parameter;
  }

  // konvertiert gegebenes ParameterSet Object zu einem Jerk ParseObject
  static ParseObject parseJerk(Jerk parameterSet) {
    ParseObject parameter = ParseObject('Jerk')
      ..set('value', parameterSet.value);

    return parameter;
  }

  // konvertiert gegebenes ParameterSet Object zu einem Cocontraction ParseObject
  static ParseObject parseCocontraction(Cocontraction parameterSet) {
    ParseObject parameter = ParseObject('Cocontraction')
      ..set('extensor1', parameterSet.extensor1)
      ..set('extensor2', parameterSet.extensor2)
      ..set('extensor3', parameterSet.extensor3)
      ..set('flexor1', parameterSet.flexor1)
      ..set('flexor2', parameterSet.flexor2)
      ..set('flexor3', parameterSet.flexor3);

    return parameter;
  }
}
