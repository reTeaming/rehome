//Implementierung von generischer SearchWidget 
import 'dart:ui';
import 'package:ReHome/business_logic/search/bloc/search_bloc.dart';
import 'package:ReHome/domain/repositories/search_repository.dart';
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


class SearchWidget extends StatelessWidget{
  final List<DummyObject> objectList; 

  const SearchWidget(this.objectList); 

  
  @override
   Widget build (BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
         create: (context) => SearchBloc(searchRepository: SearchRepository()), 
         ),
         

      ],
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
                  // Farblich muss das ganze noch angepasst werden 
                )

          ),
        ),
      ),),
      body: 
      BlocBuilder<SearchBloc, SearchState> (
        builder: (context, state) {
      
          if (state is SearchChanged){
          //   final searchList = context.select(
          //   (SearchBloc bloc) => bloc.state.changedList, 
          // ); 

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
              // Um die Listenelemente neu anzuordnen per drag & drop 
              onReorder:  (int oldIndex, int newIndex) {
                context.read<SearchBloc>().add(SearchReordered(oldIndex, newIndex)); 
                },

             children: <Widget> [
              // Erstellen der einzelnen Listenelemente :
                for(int index = 0; index < state.changedList.length; index +=1)
                  ListTile(
                    key : Key('$index'),
                    tileColor: Theme.of(context).primaryColor, 
                    title: Text(state.changedList.name), 
                  ),
             ],
                  ),
          );
          };
          return const SizedBox(); // damit nich Null 
        }
      ,)

      ),
    
    );
   }

}