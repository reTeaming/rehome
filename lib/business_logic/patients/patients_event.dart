part of 'patients_bloc.dart';

sealed class PatientsEvent extends Equatable {
  const PatientsEvent();

  @override
  List<Object> get props => [];
}

// Event für die Auswahl eines bestimmten Patienten
class PatientSelection extends PatientsEvent {
  const PatientSelection(this.patient);

  final Patient patient;

  @override
  List<Object> get props => [patient];
}

//Event für das ein-/ausklappen der vergangenen Ziele
class ExpansionChange extends PatientsEvent {
  const ExpansionChange(this.expansion);

  final bool expansion;

  @override
  List<Object> get props => [expansion];
}
