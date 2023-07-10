import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/patient/default_exercise.dart';

part 'default_exercise_state.dart';
part 'default_exercise_event.dart';

class DefaultExerciseBloc
    extends Bloc<DefaultExerciseEvent, DefaultExerciseState> {
  DefaultExerciseBloc() : super(DefaultExerciseState(null)) {
    on<ActiveExerciseChanged>(_changeActiveBranch);
    on<RemoveFocusActiveExercise>(_removeFocus);
  }

  void _changeActiveBranch(
      ActiveExerciseChanged event, Emitter<DefaultExerciseState> emit) {
    emit(DefaultExerciseState(event.active));
  }

  void _removeFocus(
      RemoveFocusActiveExercise event, Emitter<DefaultExerciseState> emit) {
    emit(DefaultExerciseState(null));
  }
}
