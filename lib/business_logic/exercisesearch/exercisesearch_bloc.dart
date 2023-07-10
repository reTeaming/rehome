import 'package:rehome/domain/models/patient/exercise.dart';

import '../../domain/models/patient/default_exercise.dart';
import '../shared/list/list_bloc.dart';

class ExerciseSearchBloc extends ListBloc<DefaultExercise, ParameterSet> {
  // SearchRepository repository = SearchRepository();

  //  ExerciseSearchBloc({required SearchRepository searchRepository})
  //      : ExerciseSearchBloc(super.initialState);

  //ExerciseSearchBloc(super.initialState);

  @override
  Future<List<DefaultExercise>> onRefresh() {
    throw UnimplementedError();
  }

  @override
  Future<List<DefaultExercise>> onSearchQueryChanged(SearchInputChanged event,
      ListState<DefaultExercise, ParameterSet> state) async {
    String searchInput = event.query.toLowerCase();

    final filteredList = state.list.where((object) {
      return object.id.toString().toLowerCase().contains(searchInput) ||
          object.name.toLowerCase().contains(searchInput);
    });
    return filteredList.toList();
  }

  @override
  Future<List<DefaultExercise>> onSearchTagChanged(
      SearchTagChanged<ParameterSet> event,
      ListState<DefaultExercise, ParameterSet> state) async {
    return [];
    // if (event.tag == null) {
    //   return state.baseList;
    // }
    // return state.list
    //     .where((element) => element.status == element.tag)
    //     .toList();
  }
}
