part of 'patient_bloc.dart';

sealed class PatientEvent {
  const PatientEvent();
}

class ActivePatientChanged extends PatientEvent {
  const ActivePatientChanged(this.active);
  final Patient active;
}

class RemoveFocusActivePatient extends PatientEvent {}
