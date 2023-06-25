library auth_bloc;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'list_event.dart';
part 'list_state.dart';

abstract class ListBloc<ListElement, SearchTag>
    extends Bloc<ListEvent, ListState<ListElement, SearchTag>> {
  ListBloc(super.initialState) {
    on<SearchInputChanged>(_onSearchQuerryChanged);
    on<SearchTagChanged>(_onSearchTagChanged);
    on<RefreshList>(_onRefresh);
  }

  Future<void> _onRefresh(
      ListEvent event, Emitter<ListState<ListElement, SearchTag>> emit) async {
    final newBase = await onRefresh();
    emit(ListState(newBase, state._currentListView));
    add(SearchInputChanged(state.currentSearchQuerry));
    add(SearchTagChanged(state.currentSeachTag));
  }

  Future<void> _onSearchQuerryChanged(
      ListEvent event, Emitter<ListState<ListElement, SearchTag>> emit) async {
    final SearchInputChanged searchEvent = event as SearchInputChanged;
    final List<ListElement> list =
        await onSearchQuerryChanged(searchEvent, state);

    final newState = state.copyWith(
        currentListView: list, currentSearchQuerry: searchEvent.querry);

    emit(newState);
  }

  Future<void> _onSearchTagChanged(
      ListEvent event, Emitter<ListState<ListElement, SearchTag>> emit) async {
    final SearchTagChanged<SearchTag> searchEvent =
        event as SearchTagChanged<SearchTag>;
    final List<ListElement> list = await onSearchTagChanged(searchEvent, state);

    final newState =
        state.copyWith(currentListView: list, currentSeachTag: event.tag);
    emit(newState);
  }

  Future<List<ListElement>> onSearchQueryChanged(
      SearchInputChanged event, ListState<ListElement, SearchTag> state);

  Future<List<ListElement>> onSearchTagChanged(
      SearchTagChanged<SearchTag> event,
      ListState<ListElement, SearchTag> state);

  Future<List<ListElement>> onRefresh();
}
