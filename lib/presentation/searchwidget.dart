//Implementierung von generischer SearchWidget 
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DummyObject {
  const DummyObject(this.name, this.birthDate, this.active); 

  final String name; 
  final DateTime birthDate; 
  final bool active;
}


List<DummyObject> dummyList = [
    DummyObject('John Doe', DateTime(1990, 10, 15), true),
    DummyObject('Jane Smith', DateTime(1985, 5, 20), false),
    DummyObject('Alice Johnson', DateTime(1998, 3, 8), true),
    DummyObject('Bob Williams', DateTime(1979, 12, 1), true),
    DummyObject('Emily Davis', DateTime(2002, 8, 25), false),
  ];



abstract class SearchEvent {}

class SearchTextChanged extends SearchEvent {
  final String query;

  SearchTextChanged(this.query);
}

class SearchState {
  final List<DummyObject> filteredObjects;

  SearchState(this.filteredObjects);
}


class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final List<DummyObject> objectList;

  SearchBloc(this.objectList) : super(SearchState(objectList));

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchTextChanged) {
      final query = event.query.toLowerCase();

      final filteredItems = objectList.where((object) {
        return
            object.name.toLowerCase().contains(query) ||
            object.active.toString().toLowerCase().contains(query) ||
            object.birthDate.toString().toLowerCase().contains(query); 
      }).toList();

      yield SearchState(filteredItems);
    }
  }
}



class SearchWidget extends StatelessWidget{
  final List<DummyObject> objectList; 

  const SearchWidget(this.objectList); 

  
  @override
   Widget build (BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(objectList),
      child: Scaffold (
        appBar: AppBar(
          title: TextField(
            onChanged: (query) {
              //BlocProvider.of<SearchBloc>(context).add(SearchTextChanged(query));
            },
              // Suchen mit Bloc 
            decoration: const InputDecoration(
                hintText: "Suche...", 
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(//color),
                )

          ),
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState> (
        builder: (context, state) {
          return ReorderableListView(
            onReorder: (int oldIndex, int newIndex) {
            
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final DummyObject object = objectList.removeAt(oldIndex);
                  objectList.insert(newIndex, object);
                  
        },
           children: <Widget> [
              for(int index = 0; index < objectList.length; index +=1)
                ListTile(
                  key : Key('$index'),
                  tileColor: Theme.of(context).primaryColor, 
                  title: Text(objectList[index].name), 
                ),

           ],
        
        
        );
            
            

        }
      
      
      
      ,)

      ),
    );
   }

}