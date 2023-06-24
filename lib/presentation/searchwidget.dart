//Implementierung von generischer SearchWidget
import 'dart:ui';

import 'package:ReHome/business_logic/search/bloc/search_bloc.dart';
import 'package:ReHome/domain/repositories/search_repository.dart';
import 'package:equatable/equatable.dart';

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

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Column(
          children: [
            TextField(
              onChanged: (query) {
                BlocProvider.of<SearchBloc>(context)
                    .add(SearchTextChanged(query));
              },
              // Suchen mit Bloc
              decoration: const InputDecoration(
                hintText: "Suche...",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(//color),
                        // Farblich muss das ganze noch angepasst werden
                        )),
              ),
            ),
          ],
        )),
        body: Column(
          children: [
            const Divider(height: 10),
            Flexible(
              flex: 1,
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return const Row(children: [
                    FilterButtonWidget("Aktive Patienten"),
                    SizedBox(
                      width: 10,
                    ),
                    FilterButtonWidget("Inaktive Patienten"),
                    SizedBox(
                      width: 10,
                    ),
                    FilterButtonWidget("Alle die John heißen"),
                  ]);
                },
              ),
            ),
            const Divider(height: 10),
            Flexible(
              flex: 7,
              child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                context.read<SearchBloc>().add(EmptySearchInput());
                if (state is SearchChanged) {
                  return RefreshIndicator(
                    //key :
                    color: Colors.white,
                    backgroundColor: Colors.blue,
                    strokeWidth: 4.0,
                    onRefresh: () async {
                      //Logik hinter dem Refreshen
                      return Future<void>.delayed(
                          const Duration(milliseconds: 300));
                    },
                    child: ReorderableListView(
                      // Um die Listenelemente neu anzuordnen per drag & drop
                      onReorder: (int oldIndex, int newIndex) {
                        context
                            .read<SearchBloc>()
                            .add(SearchReordered(oldIndex, newIndex));
                      },

                      children: <Widget>[
                        // Erstellen der einzelnen Listenelemente :
                        for (int index = 0;
                            index < 5; //Länge von der Liste vom Repository
                            index += 1)
                          ListTile(
                            key: Key('$index'),
                            tileColor: Theme.of(context).focusColor,
                            title: Text(state.changedList.name),
                            onTap: () {
                              // Hier darf die Weiterleitung zum Patienten rein
                            },
                          ),
                      ],
                    ),
                  );
                } else {
                  return const Text("Error");
                }
              }),
            ),
          ],
        ));

    //);
  }
}

class FilterButtonWidget extends StatelessWidget {
  final String displayText;
  const FilterButtonWidget(
    this.displayText, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<SearchBloc>().add(const FilterButtonPressed(Colors.blue));
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
        ),
        child: Text(displayText),
      ),
    );
  }
}
