import 'package:ReHome/domain/models/patient/exercise.dart';
import 'package:equatable/equatable.dart';

class Homework extends Equatable {
  const Homework(this.repeated, this.repeatedSince, this.weeks);

  final WeekHomework repeated;
  final DateTime repeatedSince;
  final Map<Week, WeekHomework> weeks;

  @override
  List<Object> get props => [repeated, repeatedSince, weeks];
}

class Week extends Equatable {
  const Week(this.weekNumber, this.year);

  final int weekNumber;
  final int year;

  @override
  List<Object> get props => [weekNumber, year];
}

class WeekHomework extends Equatable {
  const WeekHomework(this.exercises);

  final Map<Day, List<ExerciseBlock>> exercises;

  @override
  List<Object> get props => [exercises];
}

enum Day { MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY }

class ExerciseBlock extends Equatable {
  const ExerciseBlock(this.block, this.status);

  final List<Exercise> block;
  final BlockStatus status;

  @override
  List<Object> get props => [block, status];
}

enum BlockStatus { FINISHED, UNFINISHED }
