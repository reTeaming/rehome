part of 'list_bloc.dart';

// Events für den AuthBloc
sealed class ListEvent {
  const ListEvent();
}

final class SearchInputChanged extends ListEvent {
  final String querry;

  const SearchInputChanged(this.querry);
}

final class SearchTagChanged<T> extends ListEvent {
  final T tag;

  const SearchTagChanged(this.tag);
}

final class RefreshList extends ListEvent {}
