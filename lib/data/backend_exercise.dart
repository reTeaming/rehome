import 'package:rehome/domain/models/patient/default_exercise.dart';
import 'package:rehome/domain/models/patient/exercise.dart';
import 'package:rehome/domain/models/user/id.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// Klasse zur Anbindung von Exercise spezifischen Funktionen an das Backend
class ExerciseBackend {
  /*
  * Funktionen zum Speichern von Übungen
  */

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

  /*
  * Funktionen zum Abrufen von Übungen
  */

  /// konvertiert gegebenes ParseObject zu Exercise
  static Future<Exercise?> parseToExercise(ParseObject parseExercise) async {
    // Abrufen der Exercises aus Backend
    ParseRelation<ParseObject> parameters = parseExercise.get('parameters');
    ParseResponse query = await parameters.getQuery().query();
    List<dynamic> parseParameters = query.results!;

    // liste der konvertierten Parameter
    List<ParameterSet> parameterList = List.empty(growable: true);
    Map<DateTime, List<ParameterSet>> results = {};

    // parsen und speichern der Parameter in Liste
    for (ParseObject parseParameter in parseParameters) {
      ParameterSet? parameter = await parseToParameterSet(parseParameter);
      if (parameter != null) {
        parameterList.add(parameter);
      }
      // Abrufen von achievedAt aus ParseParameter object und Füllen der Map
      DateTime? achievedAt = parseParameter.get('achievedAt');
      if (achievedAt != null && parameter != null) {
        results.update(achievedAt, (list) => list..add(parameter),
            // Falls noch kein Eintrag mit DateTime vorhanden, erstelle neue Liste
            ifAbsent: () => List.empty(growable: true)..add(parameter));
      }
    }

    // Abrufen der Id aus backend TODO: muss noch geändet werden, wenn statt id neue Klasse DefaultExercise verwendet wird
    Id id = Id(parseExercise.get('exerciseType').get('typeId'));

    return Exercise(id, parameterList, results);
  }

  /// konvertiert gegebenes ParseObject zu Exercise
  static Future<ParameterSet?> parseToParameterSet(
      ParseObject parseParameterSet) async {
    // Abrufen des Namen und der Anzahl Wiederholungen aus Backend
    String name = parseParameterSet.get('name');
    int repetition = parseParameterSet.get('repetition');

    // Versuche alle 3 Parameter Arten aus backend abzurufen (1 sollte gesetzt sein)
    ParseObject? jerk = parseParameterSet.get('jerk');
    ParseObject? rangeOfMotion = parseParameterSet.get('rangeOfMotion');
    ParseObject? cocontraction = parseParameterSet.get('cocontraction');

    // Wähle gesetzte Parameter Art und rufe die jeweiligen Parameter ab
    if (jerk != null) {
      // für jerk: rufe value ab und erstelle Jerk Objekt
      double value = jerk.get('value');
      return Jerk(ParameterValue(value), name, repetition);
    }
    if (rangeOfMotion != null) {
      // für RangeOfMotion: rufe Value und joint ab und erstelle RangeOfMotion Objekt
      double value = rangeOfMotion.get('value');
      String jointString = rangeOfMotion.get('joint');
      Joint? joint = switch (jointString) {
        'ellbow' => Joint.ellbow,
        'shoulder' => Joint.shoulder,
        'wrist' => Joint.wrist,
        _ => null
      };
      return RangeOfMotion(joint!, ParameterValue(value), name, repetition);
    }
    if (cocontraction != null) {
      // für RangeOfMotion: rufe alle ParameterValues ab und erstelle Cocontraction Objekt
      double extensor1 = cocontraction.get('extensor1');
      double extensor2 = cocontraction.get('extensor2');
      double extensor3 = cocontraction.get('extensor3');
      double flexor1 = cocontraction.get('flexor1');
      double flexor2 = cocontraction.get('flexor2');
      double flexor3 = cocontraction.get('flexor3');
      return Cocontraction(
          ParameterValue(extensor1),
          ParameterValue(extensor2),
          ParameterValue(extensor3),
          ParameterValue(flexor1),
          ParameterValue(flexor2),
          ParameterValue(flexor3),
          name,
          repetition);
    }
    // Hier sollte das Programm nur landen, falls kein Parameter Typ gesetzt wurde
    return null;
  }
}
