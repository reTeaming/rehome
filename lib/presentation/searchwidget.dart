//Implementierung von generischer SearchWidget
import 'dart:ui';

import 'package:ReHome/business_logic/search/bloc/search_bloc.dart';
import 'package:ReHome/business_logic/shared/list/list_bloc.dart';
import 'package:ReHome/domain/models/patient/models.dart';
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
    return Column(
      children: [
        TextField(
          onChanged: (query) {
            context.read<SearchBloc>().add(SearchInputChanged(query));
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
        const Divider(height: 10),
        Flexible(
          flex: 1,
          child: BlocBuilder<SearchBloc, ListState>(
            builder: (context, state) {
              return const Row(children: [
                FilterButtonWidget("Aktive Patienten"),
              ]);
            },
          ),
        ),
        const Divider(height: 10),
        Flexible(
          flex: 7,
          child: BlocBuilder<SearchBloc, ListState>(builder: (context, state) {
            return RefreshIndicator(
              //key :
              color: Colors.white,
              backgroundColor: Colors.blue,
              strokeWidth: 4.0,
              onRefresh: () async {
                //Logik hinter dem Refreshen
                return Future<void>.delayed(const Duration(milliseconds: 300));
              },
              child: ListView(
                children: <Widget>[
                  // Erstellen der einzelnen Listenelemente :
                  for (int index = 0;
                      index <
                          state
                              .list.length; //Länge von der Liste vom Repository
                      index += 1)
                    ListTile(
                      key: Key('$index'),
                      tileColor: Theme.of(context).focusColor,
                      title: Text(state.list[index].name.toString()),
                      onTap: () {
                        // Hier darf die Weiterleitung zum Patienten rein
                      },
                    ),
                ],
              ),
            );
          }),
        ),
      ],
    );

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
    return BlocBuilder<SearchBloc, ListState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            PatientStatus patientTag = state.tag == PatientStatus.ACTIVE
                ? PatientStatus.INACTIVE
                : PatientStatus.INACTIVE;

            context.read<SearchBloc>().add(SearchTagChanged(patientTag));
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
      },
    );
  }
}
