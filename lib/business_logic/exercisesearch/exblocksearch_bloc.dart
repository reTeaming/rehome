import 'package:rehome/domain/models/patient/exercise.dart';
import 'package:rehome/domain/models/patient/homework.dart';

import '../shared/list/list_bloc.dart';

class ExBlockSearchBloc extends ListBloc<ExerciseBlock, ParameterSet> {
  // SearchRepository repository = SearchRepository();

  //  ExerciseSearchBloc({required SearchRepository searchRepository})
  //      : ExerciseSearchBloc(super.initialState);

  //ExerciseSearchBloc(super.initialState);

  @override
  Future<List<ExerciseBlock>> onRefresh() {
    throw UnimplementedError();
  }

  @override
  Future<List<ExerciseBlock>> onSearchQueryChanged(SearchInputChanged event,
      ListState<ExerciseBlock, ParameterSet> state) async {
    String searchInput = event.query.toLowerCase();

    final filteredList = state.list.where((object) {
    return object.name.toLowerCase().contains(searchInput);
    });

    return filteredList.toList();
  }

  @override
  Future<List<ExerciseBlock>> onSearchTagChanged(
      SearchTagChanged<ParameterSet> event,
      ListState<ExerciseBlock, ParameterSet> state) async {
    return [];
    // if (event.tag == null) {
    //   return state.baseList;
    // }
    // return state.list
    //     .where((element) => element.status == element.tag)
    //     .toList();
  }
}
