import 'package:ReHome/domain/models/patient/exercise.dart';
import 'package:const_date_time/const_date_time.dart';
import 'package:equatable/equatable.dart';

class Homework extends Equatable {
  const Homework(this.repeated, this.repeatedSince, this.weeks);

  final WeekHomework repeated;
  final DateTime repeatedSince;
  final Map<Week, WeekHomework> weeks;

  @override
  List<Object> get props => [repeated, repeatedSince, weeks];

  static const mockhomework =
      Homework(WeekHomework.mockweekhomework, ConstDateTime(2000), {});
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

  static const mockweekhomework = WeekHomework({});
}

enum Day { MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY }

class ExerciseBlock extends Equatable {
  const ExerciseBlock(this.name, this.block, this.status);

  final String name;
  final List<Exercise> block;
  final BlockStatus status;

  @override
  List<Object> get props => [name, block, status];
}

enum BlockStatus { FINISHED, UNFINISHED }
