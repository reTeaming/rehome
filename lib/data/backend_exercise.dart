import 'package:ReHome/domain/models/patient/exercise.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Klasse zur Anbindung von Exercise spezifischen Funktionen an das Backend
class ExerciseBackend {
  // konvertiert gegebenes Exercise Object zu einem ParseObject
  static ParseObject parseExercise(Exercise exercise) {
    return ParseObject('Exercise');
  }
}
