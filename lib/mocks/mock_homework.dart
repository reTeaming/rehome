import 'package:rehome/domain/models/patient/homework.dart';
import 'package:rehome/mocks/mock_exercise.dart';

// Mocks zum Testen von Hausaufgaben spezifischen Objekten
// Alle hier implementierten Klassen sind zu finden in 'domain/models/patient/homework.dart'
class HomeworkMock {
  /*
  * Exercise Blocks
  */
  // Exercise Blocks
  static ExerciseBlock block1 = ExerciseBlock(
      "exercise1", ExerciseMock.exerciseList1, BlockStatus.finished);
  static ExerciseBlock block2 = ExerciseBlock(
      "exercise2", ExerciseMock.exerciseList2, BlockStatus.unfinished);
  static ExerciseBlock block3 = ExerciseBlock(
      "exercise3", ExerciseMock.exerciseList3, BlockStatus.finished);
  static ExerciseBlock block4 = ExerciseBlock(
      "exercise4", ExerciseMock.exerciseList4, BlockStatus.unfinished);
  static ExerciseBlock block5 = ExerciseBlock(
      "exercise5", ExerciseMock.exerciseList5, BlockStatus.finished);
  static ExerciseBlock block6 = ExerciseBlock(
      "exercise6", ExerciseMock.exerciseList3, BlockStatus.unfinished);

  /*
  * Week Homeworks
  */
  // Exercise Block Lists
  static List<ExerciseBlock> blockList1 = List.empty(growable: true)
    ..add(block1)
    ..add(block2);
  static List<ExerciseBlock> blockList2 = List.empty(growable: true)
    ..add(block3)
    ..add(block4)
    ..add(block5);
  static List<ExerciseBlock> blockList3 = List.empty(growable: true)
    ..add(block1)
    ..add(block3)
    ..add(block4)
    ..add(block5);
  static List<ExerciseBlock> blockList4 = List.empty(growable: true)
    ..add(block2);

  // exerciseBlock Maps
  static Map<Day, List<ExerciseBlock>> exerciseMap1 = {
    Day.monday: blockList1,
    Day.wednesday: blockList2
  };
  static Map<Day, List<ExerciseBlock>> exerciseMap2 = {
    Day.tuesday: blockList3,
    Day.friday: blockList4
  };
  static Map<Day, List<ExerciseBlock>> exerciseMap3 = {
    Day.thursday: blockList2,
    Day.saturday: blockList4,
    Day.sunday: blockList1
  };

  // WeekHomeworks
  static WeekHomework weekHomework1 = WeekHomework(exerciseMap1);
  static WeekHomework weekHomework2 = WeekHomework(exerciseMap2);
  static WeekHomework weekHomework3 = WeekHomework(exerciseMap3);

  /*
  * Homeworks
  */
  // Weeks
  static const Week week1 = Week(12, 2023);
  static const Week week2 = Week(13, 2023);
  static const Week week3 = Week(14, 2023);
  static const Week week4 = Week(23, 2023);
  static const Week week5 = Week(41, 2023);

  // WeekHomework Maps
  static Map<Week, WeekHomework> weekHomeMap1 = {
    week1: weekHomework1,
    week2: weekHomework2
  };
  static Map<Week, WeekHomework> weekHomeMap2 = {week1: weekHomework1};
  static Map<Week, WeekHomework> weekHomeMap3 = {
    week1: weekHomework1,
    week2: weekHomework2,
    week3: weekHomework2,
    week4: weekHomework2
  };
  static Map<Week, WeekHomework> weekHomeMap4 = {
    week1: weekHomework3,
    week4: weekHomework2,
    week5: weekHomework2
  };

  // Homeworks
  // DateTimes aus ExerciseMock werden hier wiederverwendet um keine neuen erstellen zu müssen
  static Homework homework1 =
      Homework(weekHomework3, ExerciseMock.date1_23, weekHomeMap1);
  static Homework homework2 =
      Homework(weekHomework1, ExerciseMock.date3_31, weekHomeMap3);
  static Homework homework3 =
      Homework(weekHomework2, ExerciseMock.date4_20, weekHomeMap2);
  static Homework homework4 =
      Homework(weekHomework1, ExerciseMock.date8_4, weekHomeMap4);
  static Homework homework5 =
      Homework(weekHomework2, ExerciseMock.date9_11, weekHomeMap3);
}
