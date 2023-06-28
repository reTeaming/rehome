part of 'patients_bloc.dart';

// Zustände der Patientenseite
class PatientsState extends Equatable {
  const PatientsState._({this.patient = Patient.mock});

// ein bestimmter Patient wurde ausgewählt
  const PatientsState.patientselected(Patient patient)
      : this._(patient: patient);

// (noch) kein Patient wurde ausgewählt
  const PatientsState.nopatientselected() : this._();

  final Patient patient;

  PatientsState copyWith({Patient? patient, bool? expansion}) {
    return PatientsState._(
      patient: patient ?? this.patient,
    );
  }

  @override
  List<Object> get props => [patient];
}
