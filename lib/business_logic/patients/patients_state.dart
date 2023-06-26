part of 'patients_bloc.dart';

// Zustände der Patientenseite
class PatientsState extends Equatable {
  const PatientsState._({this.patient = Patient.mock, this.expansion = false});

// ein bestimmter Patient wurde ausgewählt
  const PatientsState.patientselected(Patient patient)
      : this._(patient: patient);

// (noch) kein Patient wurde ausgewählt
  const PatientsState.nopatientselected() : this._();

  final Patient patient;

// nicht ausgeklappte Ziele
  const PatientsState.unexpanded() : this._(expansion: false);

  final bool expansion;

//ausgeklappte Ziele
  const PatientsState.expanded() : this._(expansion: true);

  PatientsState copyWith({Patient? patient, bool? expansion}) {
    return PatientsState._(
      patient: patient ?? this.patient,
      expansion: expansion ?? this.expansion,
    );
  }

  @override
  List<Object> get props => [patient, expansion];
}
