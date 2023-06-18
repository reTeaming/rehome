part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchChanged extends SearchState {
  final dynamic changedList;

  const SearchChanged({required this.changedList});

  @override
  List<Object> get props => [changedList];
}

class FilterButtonColor extends SearchState {
  final Color buttonColor;

  const FilterButtonColor(this.buttonColor);
  @override
  List<Object> get props => [buttonColor];
}
