part of 'default_exercise_bloc.dart';

class DefaultExerciseState {
  final DefaultExercise? activeExercise;
  final ExerciseBlock? activeExBlock;
  final ActiveExState activeEx;

  DefaultExerciseState(this.activeExBlock, this.activeExercise, this.activeEx);
}

enum ActiveExState {
  activeExercise,
  activeExblock,
  activeBlocktoExercise,
  inactive
}
