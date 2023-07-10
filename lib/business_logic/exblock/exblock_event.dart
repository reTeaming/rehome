part of 'exblock_bloc.dart';

sealed class ExBlockEvent {
  const ExBlockEvent();
}

class ActiveExBlockChanged extends ExBlockEvent {
  const ActiveExBlockChanged(this.active);
  final ExerciseBlock active;
}

class RemoveFocusActiveExBlock extends ExBlockEvent {}
