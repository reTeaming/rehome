part of 'default_exercise_bloc.dart';

sealed class DefaultExerciseEvent {
  const DefaultExerciseEvent();
}

class ActiveExerciseChanged extends DefaultExerciseEvent {
  const ActiveExerciseChanged(this.activeExercise);
  final DefaultExercise activeExercise;
}

class ActiveExBlockChanged extends DefaultExerciseEvent {
  const ActiveExBlockChanged(this.activeExblock);
  final ExerciseBlock activeExblock;
}

class ActiveBlocktoExercise extends DefaultExerciseEvent {
  final ExerciseBlock previousBlock;
  final DefaultExercise activeExercise;
  const ActiveBlocktoExercise(this.previousBlock, this.activeExercise);
}

class BacktoBlock extends DefaultExerciseEvent {}

class RemoveFocusActiveEx extends DefaultExerciseEvent {}
