import 'dart:ui';
import 'package:ReHome/business_logic/shared/list/list_bloc.dart';
import 'package:ReHome/domain/models/patient/patient.dart';
import 'package:ReHome/domain/repositories/search_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ReHome/domain/models/patient/models.dart';
import 'package:ReHome/business_logic/shared/list/list_bloc.dart';
import 'package:ReHome/domain/models/patient/models.dart';

class SearchBloc extends ListBloc<Patient, PatientStatus> {
  // SearchRepository repository = SearchRepository();

  //  SearchBloc({required SearchRepository searchRepository})
  //      : SearchBloc(super.initialState);

  SearchBloc(super.initialState);

  @override
  Future<List<Patient>> onRefresh() {
    throw UnimplementedError();
  }

  @override
  Future<List<Patient>> onSearchQueryChanged(
      SearchInputChanged event, ListState<Patient, PatientStatus> state) {
    // TODO: implement onSearchQueryChanged
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
    throw UnimplementedError();
  }
}

// class SearchBloc extends Bloc<SearchEvent, SearchState> {
//   SearchRepository repository = SearchRepository();

//   SearchBloc({required SearchRepository searchRepository})
//       : super(SearchInitial()) {
//     on<EmptySearchInput>((event, emit) {
//       emit(SearchChanged(changedList: repository.getList()));
//     }); //Brauch es den überhaupt?

//     on<SearchTextChanged>((event, emit) async {
//       try {
//         final query = event.query.toLowerCase();

//         List<DummyObject>? templist = await repository.getList();

//         final filteredList = templist!.where((object) {
//           return object.name.toLowerCase().contains(query) ||
//               object.active.toString().toLowerCase().contains(query) ||
//               object.birthDate.toString().toLowerCase().contains(query);
//         });
//         final List<DummyObject> finalfiltered = filteredList.toList();

//         emit(SearchChanged(changedList: finalfiltered));
//       } catch (error) {
//         emit(const SearchChanged(changedList: []));
//       }
//     });
//     on<SearchReordered>((event, emit) async {
//       try {
//         int newIndex = event.newIndex;
//         int oldIndex = event.oldIndex;

//         List<DummyObject>? templist = await repository.getList();

//         if (oldIndex < newIndex) {
//           newIndex -= 1;
//         }
//         final DummyObject object = templist!.removeAt(oldIndex);
//         templist.insert(newIndex, object);

//         emit(SearchChanged(changedList: templist));
//       } catch (error) {
//         emit(SearchChanged(changedList: dummyList));
//       }
//     });

//     on<FilterButtonPressed>((event, emit) {
//       final newButtonColor =
//           event.buttonColor == Colors.grey ? Colors.blue : Colors.grey;

//       emit(FilterButtonColor(newButtonColor));
//     });
//   }
// }
