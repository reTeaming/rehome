import 'package:ReHome/domain/models/patient/patient.dart';
import 'package:ReHome/domain/repositories/patient_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'patients_event.dart';
part 'patients_state.dart';

// Bloc für die Patientenseite
class PatientsBloc extends Bloc<PatientsEvent, PatientsState> {
  PatientRepository repository = PatientRepository();

  PatientsBloc({
    required PatientRepository patientRepository,
  }) : super(const PatientsState.nopatientselected()) {
    // Registrierung der Handler
    on<PatientsEvent>((event, emit) async {
      if (event is PatientSelection) {
        emit(const PatientsState.nopatientselected());
        try {
          Patient? patient = await repository.getPatient();

          emit(PatientsState.patientselected(patient!));
        } catch (error) {
          emit(const PatientsState.nopatientselected());
        }
      }
      //erste Idee
      if (event is ExpansionChange) {
        state.expansion
            ? emit(const PatientsState.unexpanded())
            : emit(const PatientsState.expanded());
      }
    });
    //zweite Idee
    // on<ExpansionChange>((event, emit) async {
    //   emit(state.copyWith(expansion: !state.expansion));
    // });
  }
}
