import 'package:ReHome/domain/models/patient/exercise.dart';
import 'package:ReHome/domain/models/user/id.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Klasse zur Anbindung von Exercise spezifischen Funktionen an das Backend
class ExerciseBackend {
  // konvertiert gegebenes Exercise Object zu einem ParseObject
  static ParseObject parseExercise(Exercise exercise) {
    Id id = exercise.id;
    List<ParameterSet> parameters = exercise.parameter;
    Map<DateTime, List<ParameterSet>> results = exercise.results;

    ParseObject parseExercise = ParseObject('Exercise')..set('id', id);

    List parameterList = List.empty();

    for (var parameter in parameters) {
      parameterList.add(parseParameterSet(parameter));
    }

    parseExercise.set('parameters', parameterList);

    return parseExercise;
  }

  static ParseObject parseParameterSet(ParameterSet parameter) {
    return ParseObject('ParameterSet');
  }
}
