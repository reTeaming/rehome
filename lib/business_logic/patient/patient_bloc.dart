import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehome/domain/models/patient/models.dart';

part 'patient_state.dart';
part 'patient_event.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  PatientBloc() : super(PatientState(null)) {
    on<ActivePatientChanged>(_changeActiveBranch);
    on<RemoveFocusActivePatient>(_removeFocus);
  }

  void _changeActiveBranch(
      ActivePatientChanged event, Emitter<PatientState> emit) {
    emit(PatientState(event.active));
  }

  void _removeFocus(
      RemoveFocusActivePatient event, Emitter<PatientState> emit) {
    emit(PatientState(null));
  }
}
