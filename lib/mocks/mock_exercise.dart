import 'package:rehome/domain/models/patient/exercise.dart';
import 'package:rehome/domain/models/user/id.dart';

import '../domain/models/patient/default_exercise.dart';

// Mocks zum Testen von Exercise spezifischen Objekten
// Alle hier implementierten Klassen sind zu finden in 'domain/models/patient/exercise.dart'
class ExerciseMock {
  /*
  * ParameterSets
  */
  // ParameterSet - Cocontraction Objekte
  static const ParameterSet cocontractionWrist = Cocontraction(
      ParameterValue(0.2),
      ParameterValue(0.1),
      ParameterValue(0.4),
      ParameterValue(0.12),
      ParameterValue(0.9),
      ParameterValue(0.7),
      "cocontractionWrist",
      2);
  static const ParameterSet cocontractionShoulder = Cocontraction(
      ParameterValue(0.2),
      ParameterValue(0.3),
      ParameterValue(0.7),
      ParameterValue(0.12),
      ParameterValue(0.4),
      ParameterValue(0.2),
      "cocontractionShoulder",
      3);
  static const ParameterSet cocontractionEllbow = Cocontraction(
      ParameterValue(0.4),
      ParameterValue(0.123),
      ParameterValue(0.444),
      ParameterValue(0.231),
      ParameterValue(0.48),
      ParameterValue(0.2002),
      "cocontractionEllbow",
      1);

  // ParameterSet - Jerk Objekte
  static const ParameterSet jerkShoulder =
      Jerk(ParameterValue(0.1), "jerkShoulder", 4);
  static const ParameterSet jerkWrist =
      Jerk(ParameterValue(0.833), "jerkWrist", 5);
  static const ParameterSet jerkEllbow =
      Jerk(ParameterValue(0.241), "jerkEllbow", 1);

  // ParameterSet - RangeOfMotion Objekte
  static const ParameterSet romShoulder =
      RangeOfMotion(Joint.shoulder, ParameterValue(0.7), "romShoulder", 2);
  static const ParameterSet romEllbow =
      RangeOfMotion(Joint.ellbow, ParameterValue(0.1), "romEllbow", 5);
  static const ParameterSet romWrist =
      RangeOfMotion(Joint.wrist, ParameterValue(0.4), "romWrist", 3);

  // ParameterSet - Objekt Listen
  static List<ParameterSet> parameterListShoulder = List.empty(growable: true)
    ..add(cocontractionShoulder)
    ..add(jerkShoulder)
    ..add(romShoulder);
  static List<ParameterSet> parameterListEllbow = List.empty(growable: true)
    ..add(cocontractionEllbow)
    ..add(jerkEllbow)
    ..add(romEllbow);
  static List<ParameterSet> parameterListWrist = List.empty(growable: true)
    ..add(cocontractionWrist)
    ..add(jerkWrist)
    ..add(romWrist);
  static List<ParameterSet> parameterListMix1 = List.empty(growable: true)
    ..add(cocontractionWrist)
    ..add(cocontractionEllbow)
    ..add(jerkWrist)
    ..add(romWrist);
  static List<ParameterSet> parameterListMix2 = List.empty(growable: true)
    ..add(cocontractionShoulder)
    ..add(jerkShoulder)
    ..add(cocontractionWrist);
  static List<ParameterSet> parameterListMix3 = List.empty(growable: true)
    ..add(romEllbow)
    ..add(jerkShoulder)
    ..add(cocontractionWrist);
  static List<ParameterSet> parameterListResults1 = List.empty(growable: true)
    ..add(romEllbow);
  static List<ParameterSet> parameterListResults2 = List.empty(growable: true)
    ..add(jerkShoulder)
    ..add(cocontractionWrist);
  static List<ParameterSet> parameterListResults3 = List.empty(growable: true)
    ..add(cocontractionEllbow)
    ..add(jerkWrist);

  /*
  * Exercises
  */
  // Results Maps - DateTimes
  static DateTime date3_31 = DateTime.utc(2023, 3, 31, 7, 23, 30, 11, 9);
  static DateTime date1_23 = DateTime.utc(2023, 1, 23, 19, 44, 17, 5, 55);
  static DateTime date4_20 = DateTime.utc(2023, 4, 20, 16, 20, 00, 4, 20);
  static DateTime date8_4 = DateTime.utc(2022, 8, 4, 17, 14, 2, 23, 1);
  static DateTime date9_11 = DateTime.utc(2022, 9, 11, 14, 46, 30, 49, 22);

  // Results Maps
  static Map<DateTime, List<ParameterSet>> results1 = {
    date3_31: parameterListResults1, // rowEllbow
    date1_23: parameterListResults2, // jerkShoulder, cocontractionWrist
    date4_20: parameterListResults3 // cocontractionEllbow, jerkWrist
  };
  static Map<DateTime, List<ParameterSet>> results2 = {
    date4_20: parameterListResults1, // rowEllbow
    date8_4: parameterListResults2 // jerkShoulder, cocontractionWrist
  };
  static Map<DateTime, List<ParameterSet>> results3 = {
    date4_20: parameterListResults3 // cocontractionEllbow, jerkWrist
  };
  static Map<DateTime, List<ParameterSet>> results4 = {
    date9_11: parameterListResults1, // rowEllbow
    date8_4: parameterListResults3 // cocontractionEllbow, jerkWrist
  };

  // DefaultExercises
  static const DefaultExercise exerciseType1 =
      DefaultExercise(Id("11"), "Schulter Mobilität");
  static const DefaultExercise exerciseType2 =
      DefaultExercise(Id("420"), "Handgelenk-Ellenbogen Streckung");
  static const DefaultExercise exerciseType3 =
      DefaultExercise(Id("21"), "Arm Streckung");
  static const DefaultExercise exerciseType4 =
      DefaultExercise(Id("512"), "Ellenbogen Mobilität");
  static const DefaultExercise exerciseType5 =
      DefaultExercise(Id("69"), "allgemeine Handgelenks Übung ");
  static const DefaultExercise exerciseType6 =
      DefaultExercise(Id("23"), "Bewegung des gesamten Arms");

  // Exercises
  static Exercise exercise1 =
      Exercise(exerciseType1, parameterListShoulder, results1);
  static Exercise exercise2 =
      Exercise(exerciseType2, parameterListMix1, results2);
  static Exercise exercise3 =
      Exercise(exerciseType1, parameterListMix2, results3);
  static Exercise exercise4 =
      Exercise(exerciseType1, parameterListEllbow, results4);
  static Exercise exercise5 =
      Exercise(exerciseType1, parameterListWrist, results1);
  static Exercise exercise6 =
      Exercise(exerciseType1, parameterListMix3, results3);

  // Exercise Lists
  static List<Exercise> exerciseList1 = List.empty(growable: true)
    ..add(exercise1)
    ..add(exercise2);
  static List<Exercise> exerciseList2 = List.empty(growable: true)
    ..add(exercise6);
  static List<Exercise> exerciseList3 = List.empty(growable: true)
    ..add(exercise1)
    ..add(exercise3);
  static List<Exercise> exerciseList4 = List.empty(growable: true)
    ..add(exercise1)
    ..add(exercise2)
    ..add(exercise3)
    ..add(exercise4)
    ..add(exercise5)
    ..add(exercise6);
  static List<Exercise> exerciseList5 = List.empty(growable: true)
    ..add(exercise4)
    ..add(exercise5);
}
