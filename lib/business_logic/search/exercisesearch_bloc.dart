import 'package:rehome/domain/models/patient/exercise.dart';

import '../shared/list/list_bloc.dart';

class ExerciseSearchBloc extends ListBloc<Exercise, ParameterSet> {
  // SearchRepository repository = SearchRepository();

  //  ExerciseSearchBloc({required SearchRepository searchRepository})
  //      : ExerciseSearchBloc(super.initialState);

  ExerciseSearchBloc(super.initialState);

  @override
  Future<List<Exercise>> onRefresh() {
    throw UnimplementedError();
  }

  @override
  Future<List<Exercise>> onSearchQueryChanged(
      SearchInputChanged event, ListState<Exercise, ParameterSet> state) {
    // String searchInput = event.query.toLowerCase();

    final filteredList = state.list.where((object) {
      // return object.name.surname.toLowerCase().contains(searchInput) ||
      //     object.name.name.toLowerCase().contains(searchInput) ||
      //     object.therapyStart.toString().toLowerCase().contains(searchInput) ||
      //     object.status.toString().toLowerCase().contains(searchInput);
    });
    final List<Exercise> finalfiltered = filteredList.toList();

    emit(state.copyWith(currentListView: finalfiltered));

    throw UnimplementedError();
  }

  @override
  Future<List<Exercise>> onSearchTagChanged(
      SearchTagChanged<ParameterSet> event,
      ListState<Exercise, ParameterSet> state) {
    // TODO: implement onSearchTagChanged

    emit(state.copyWith(currentSearchTag: ParameterSet));
    throw UnimplementedError();
  }
}
