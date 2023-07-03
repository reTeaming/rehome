import 'dart:ui';
import 'package:ReHome/business_logic/shared/list/list_bloc.dart';
import 'package:ReHome/domain/models/patient/patient.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ReHome/domain/models/patient/models.dart';

class PatientSearchBloc extends ListBloc<Patient, PatientStatus> {
  // SearchRepository repository = SearchRepository();

  //  PatientSearchBloc({required SearchRepository searchRepository})
  //      : PatientSearchBloc(super.initialState);

  PatientSearchBloc(super.initialState);

  @override
  Future<List<Patient>> onRefresh() {
    throw UnimplementedError();
  }

  @override
  Future<List<Patient>> onSearchQueryChanged(
      SearchInputChanged event, ListState<Patient, PatientStatus> state) {
    String searchInput = event.query.toLowerCase();

    final filteredList = state.list.where((object) {
      return object.name.surname.toLowerCase().contains(searchInput) ||
          object.name.name.toLowerCase().contains(searchInput) ||
          object.therapyStart.toString().toLowerCase().contains(searchInput) ||
          object.status.toString().toLowerCase().contains(searchInput);
    });
    final List<Patient> finalfiltered = filteredList.toList();

    emit(state.copyWith(currentListView: finalfiltered));

    throw UnimplementedError();
  }

  @override
  Future<List<Patient>> onSearchTagChanged(
      SearchTagChanged<PatientStatus> event,
      ListState<Patient, PatientStatus> state) {
    // TODO: implement onSearchTagChanged
    PatientStatus patientStatus = event.tag == PatientStatus.ACTIVE
        ? PatientStatus.INACTIVE
        : PatientStatus.ACTIVE;

    emit(state.copyWith(currentSearchTag: patientStatus));
    throw UnimplementedError();
  }
}
