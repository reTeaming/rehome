import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/patient/default_exercise.dart';
import '../../domain/models/patient/homework.dart';

part 'default_exercise_state.dart';
part 'default_exercise_event.dart';

class DefaultExerciseBloc
    extends Bloc<DefaultExerciseEvent, DefaultExerciseState> {
  DefaultExerciseBloc()
      : super(DefaultExerciseState(null, null, ActiveExState.inactive)) {
    on<ActiveExerciseChanged>(_changeActiveExerciseBranch);
    on<ActiveExBlockChanged>(_changeActiveExBlockBranch);
    on<RemoveFocusActiveEx>(_removeFocus);
  }

  void _changeActiveExerciseBranch(
      ActiveExerciseChanged event, Emitter<DefaultExerciseState> emit) {
    emit(DefaultExerciseState(
        null, event.activeExercise, ActiveExState.activeExercise));
  }

  void _changeActiveExBlockBranch(
      ActiveExBlockChanged event, Emitter<DefaultExerciseState> emit) {
    emit(DefaultExerciseState(
        event.activeExblock, null, ActiveExState.activeExercise));
  }

  void _removeFocus(
      RemoveFocusActiveEx event, Emitter<DefaultExerciseState> emit) {
    emit(DefaultExerciseState(null, null, ActiveExState.inactive));
  }
}
