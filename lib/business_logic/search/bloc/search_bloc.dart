import 'package:ReHome/domain/models/patient/patient.dart';
import 'package:ReHome/domain/repositories/search_repository.dart';
import 'package:ReHome/presentation/searchwidget.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository repository = SearchRepository(); 
  
  SearchBloc({
    required SearchRepository searchRepository, 
  }) : super(SearchChanged(changedList: dummyList)) {
    
    on<EmptySearchInput>((event, emit)  {
      if (state is SearchChanged) {
        final state = this.state as SearchChanged; 
        
        emit (SearchChanged(changedList: repository.getList())); 
      }
    }); //Brauch es den überhaupt? 

     on<SearchTextChanged>((event, emit) async {
      if (state is SearchChanged) {
       // final state = this.state as SearchChanged; 

        try {
            
        
        final query = event.query.toLowerCase(); 

        List? templist = await repository.getList(); 

        final filteredList = templist!.where((object) {
          return 
            object.name.toLowerCase().contains(query) ||
            object.active.toString().toLowerCase().contains(query) ||
            object.birthDate.toString().toLowerCase().contains(query); 
      }).toList();
        

        emit (SearchChanged(changedList: filteredList)); }
        catch (error) {
          emit(SearchChanged(changedList: dummyList));

        }
      }
    }); 
    on<SearchReordered>((event, emit ) async  {
      if (state is SearchChanged) {
        //final state = this.state as SearchChanged; 
        try{
          int newIndex = event.newIndex; 
          int oldIndex = event.oldIndex; 

          List? templist = await repository.getList(); 
          
          if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final DummyObject object = templist!.removeAt(oldIndex);
                        templist!.insert(newIndex, object);

        emit (SearchChanged(changedList: templist)); }
        catch (error) {
            emit(SearchChanged(changedList: dummyList));
        }
      }
    }); 

  }
}
