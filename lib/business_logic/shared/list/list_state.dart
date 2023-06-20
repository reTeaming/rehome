part of 'list_bloc.dart';

// Mögliche Zustände des AuthBlocs
class ListState<ListElement, Tag> extends Equatable {
  final List<ListElement> _baseList;
  final List<ListElement> _currentListView;
  final String currentSearchQuerry;
  final Tag? currentSeachTag;

  const ListState(this._baseList, this._currentListView,
      {this.currentSearchQuerry = "", this.currentSeachTag});

  List<ListElement> get list => _currentListView;
  ListState<ListElement, Tag> copyWith({
    List<ListElement>? baseList,
    List<ListElement>? currentListView,
    String? currentSearchQuerry,
    Tag? currentSeachTag,
  }) {
    return ListState(
        baseList ?? this._baseList, currentListView ?? this._currentListView,
        currentSearchQuerry: currentSearchQuerry ?? this.currentSearchQuerry,
        currentSeachTag: currentSeachTag ?? this.currentSeachTag);
  }

  @override
  List<Object> get props => [];
}
