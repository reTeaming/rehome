part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class EmptySearchInput extends SearchEvent{}

class SearchTextChanged extends SearchEvent{
  final String query; 

  const SearchTextChanged(this.query);

  @override
  List<Object> get props => [query]; 
}
class SearchReordered extends SearchEvent{
  final int oldIndex; 
  final int newIndex; 
  
  const SearchReordered(this.oldIndex, this.newIndex); 

  @override
  List<Object> get props => [oldIndex, newIndex]; 
}


