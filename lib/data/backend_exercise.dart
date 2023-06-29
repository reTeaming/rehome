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

    List parameterList = List.empty();

    // konvertiere jeden Parameter zu einem ParseObject
    for (var parameter in parameters) {
      parameterList.add(parseParameterSet(parameter, results));
    }

    // füge Liste mit Parse Parameter Objekten der Liste hinzu
    parseExercise.set('parameters', parameterList);

    return parseExercise;
  }

  static ParseObject parseParameterSet(
      ParameterSet parameter, Map<DateTime, List<ParameterSet>> results) {
    return ParseObject('ParameterSet');
  }
}
