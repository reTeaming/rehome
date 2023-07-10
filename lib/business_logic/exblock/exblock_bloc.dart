import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehome/domain/models/patient/homework.dart';

part 'exblock_state.dart';
part 'exblock_event.dart';

class ExBlockBloc extends Bloc<ExBlockEvent, ExBlockState> {
  ExBlockBloc() : super(ExBlockState(null)) {
    on<ActiveExBlockChanged>(_changeActiveBranch);
    on<RemoveFocusActiveExBlock>(_removeFocus);
  }

  void _changeActiveBranch(
      ActiveExBlockChanged event, Emitter<ExBlockState> emit) {
    emit(ExBlockState(event.active));
  }

  void _removeFocus(
      RemoveFocusActiveExBlock event, Emitter<ExBlockState> emit) {
    emit(ExBlockState(null));
  }
}
