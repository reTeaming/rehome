//Implementierung von generischer SearchWidget 
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// Dumme Objekte damit ich iwas anzeigen kann 
class DummyObject {
  const DummyObject(this.name, this.birthDate, this.active); 

  final String name; 
  final DateTime birthDate; 
  final bool active;
}

// Liste aus dummen Objekten 

List<DummyObject> dummyList = [
    DummyObject('John Doe', DateTime(1990, 10, 15), true),
    DummyObject('Jane Smith', DateTime(1985, 5, 20), false),
    DummyObject('Alice Johnson', DateTime(1998, 3, 8), true),
    DummyObject('Bob Williams', DateTime(1979, 12, 1), true),
    DummyObject('Emily Davis', DateTime(2002, 8, 25), false),
  ];



//Bloc Sachen die glaub ich in ne andere Datei müssten (ich checks noch nicht wirklich):
 
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

//Das filtern der liste zum Suchen von Objekten: 
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchTextChanged) {
      final query = event.query.toLowerCase();

      final filteredObjects = objectList.where((object) {
        return
          //Dinge nachdenen gefiltert werden soll 
            object.name.toLowerCase().contains(query) ||
            object.active.toString().toLowerCase().contains(query) ||
            object.birthDate.toString().toLowerCase().contains(query); 
      }).toList();

      yield SearchState(filteredObjects);
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
              BlocProvider.of<SearchBloc>(context).add(SearchTextChanged(query));
            },
              // Suchen mit Bloc 
            decoration: const InputDecoration(
                hintText: "Suche...", 
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(//color),
                )

          ),
        ),
      ),),
      body: BlocBuilder<SearchBloc, SearchState> (
        builder: (context, state) {
          return RefreshIndicator(
            //key : 
            color: Colors.white, 
            backgroundColor: Colors.blue,
            strokeWidth: 4.0,
            onRefresh: () async {
              //Logik hinter dem Refreshen 
              return Future<void>.delayed(const Duration(milliseconds: 300));
            },
            child: ReorderableListView(
              onReorder: (int oldIndex, int newIndex) {
                if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final DummyObject object = objectList.removeAt(oldIndex);
                    objectList.insert(newIndex, object);
          
                    SearchState(objectList);
                },
             children: <Widget> [
                for(int index = 0; index < objectList.length; index +=1)
                  ListTile(
                    key : Key('$index'),
                    tileColor: Theme.of(context).primaryColor, 
                    title: Text(objectList[index].name), 
                  ),
             ],
                  ),
          );
        }
      ,)

      ),
    
    );
   }

}