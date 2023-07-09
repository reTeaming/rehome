import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rehome/domain/models/patient/models.dart';
import 'package:rehome/domain/repositories/patient_repository.dart';

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
    });
  }
}
