part of 'list_bloc.dart';

// Mögliche Zustände des AuthBlocs
class ListState<ListElement, Tag> extends Equatable {
  final List<ListElement> _baseList;
  final List<ListElement> _currentListView;
  final String currentSearchQuery;
  final Tag? currentSearchTag;

  const ListState(this._baseList, this._currentListView,
      {this.currentSearchQuery = "", this.currentSearchTag});

  List<ListElement> get list => _currentListView;
  Tag? get tag => currentSearchTag;
  ListState<ListElement, Tag> copyWith({
    List<ListElement>? baseList,
    List<ListElement>? currentListView,
    String? currentSearchQuery,
    Tag? currentSearchTag,
  }) {
    return ListState(
        baseList ?? this._baseList, currentListView ?? this._currentListView,
        currentSearchQuery: currentSearchQuery ?? this.currentSearchQuery,
        currentSearchTag: currentSearchTag ?? this.currentSearchTag);
  }

  @override
  List<Object> get props => [];
}
