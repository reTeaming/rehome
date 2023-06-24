import 'dart:ui';
import 'package:ReHome/domain/models/patient/patient.dart';
import 'package:ReHome/domain/repositories/search_repository.dart';
import 'package:ReHome/presentation/searchwidget.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository repository = SearchRepository();

  SearchBloc({required SearchRepository searchRepository})
      : super(SearchInitial()) {
    on<EmptySearchInput>((event, emit) {
      emit(SearchChanged(changedList: repository.getList()));
    }); //Brauch es den überhaupt?

    on<SearchTextChanged>((event, emit) async {
      try {
        final query = event.query.toLowerCase();

        List<DummyObject>? templist = await repository.getList();

        final filteredList = templist!.where((object) {
          return object.name.toLowerCase().contains(query) ||
              object.active.toString().toLowerCase().contains(query) ||
              object.birthDate.toString().toLowerCase().contains(query);
        });
        final List<DummyObject> finalfiltered = filteredList.toList();

        emit(SearchChanged(changedList: finalfiltered));
      } catch (error) {
        emit(const SearchChanged(changedList: []));
      }
    });
    on<SearchReordered>((event, emit) async {
      try {
        int newIndex = event.newIndex;
        int oldIndex = event.oldIndex;

        List<DummyObject>? templist = await repository.getList();

        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        final DummyObject object = templist!.removeAt(oldIndex);
        templist.insert(newIndex, object);

        emit(SearchChanged(changedList: templist));
      } catch (error) {
        emit(SearchChanged(changedList: dummyList));
      }
    });

    on<FilterButtonPressed>((event, emit) {
      final newButtonColor =
          event.buttonColor == Colors.grey ? Colors.blue : Colors.grey;

      emit(FilterButtonColor(newButtonColor));
    });
  }
}
