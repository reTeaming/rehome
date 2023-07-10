part of 'default_exercise_bloc.dart';

sealed class DefaultExerciseEvent {
  const DefaultExerciseEvent();
}

class ActiveExerciseChanged extends DefaultExerciseEvent {
  const ActiveExerciseChanged(this.active);
  final DefaultExercise active;
}

class RemoveFocusActiveExercise extends DefaultExerciseEvent {}
