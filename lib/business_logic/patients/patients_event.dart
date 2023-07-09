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
