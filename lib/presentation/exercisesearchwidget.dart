//Implementierung von generischer SearchWidget
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehome/business_logic/exercisesearch/exblocksearch_bloc.dart';
import 'package:rehome/domain/models/patient/default_exercise.dart';
import 'package:rehome/domain/models/patient/exercise.dart';
import 'package:rehome/domain/models/patient/homework.dart';
import 'package:rehome/mocks/mock_exercise.dart';

import '../business_logic/default_exercise/default_exercise_bloc.dart';
import '../business_logic/exercisesearch/exercisesearch_bloc.dart';
import '../business_logic/shared/list/list_bloc.dart';

class ExerciseSearchWidget extends StatefulWidget {
  const ExerciseSearchWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<ExerciseSearchWidget> {
  int isExpanded =
      -1; // der Index welches Panel aktuell expanded ist, -1 heißt keins
  final double _bodyHeight = 50.0; // Grundhöhe

  void setExpansion(int index) {
    setState(() {
      isExpanded = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SearchBar(),
        const Divider(height: 10),
        BlocBuilder<ExerciseSearchBloc, ListState>(builder: (context, state) {
          return RefreshIndicator(
              //key :
              color: Colors.white,
              backgroundColor: Colors.blue,
              strokeWidth: 4.0,
              onRefresh: () async {
                context.read<ExerciseSearchBloc>().add(RefreshList());
              },
              child: SingleChildScrollView(
                child: ExpansionPanelList.radio(
                    initialOpenPanelValue:
                        -1, // alle Panels sind anfangs eingeklappt
                    expansionCallback: (int index, bool isExpanded) {
                      setExpansion(
                          index); // Das richtige Panel auswählen über Index
                    },
                    children: [
                      // Liste mit allen Übungen als Expansion
                      ExpansionPanelRadio(
                        value: 0,
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: const Text("Übungen"),
                            onTap: () {
                              setExpansion(0);
                            },
                          );
                        },
                        body: BlocBuilder<ExerciseSearchBloc,
                                ListState<DefaultExercise, ParameterSet?>>(
                            builder: (context, state) {
                          final List<ListTile> listTiles = state.list
                              .map((DefaultExercise e) => ListTile(
                                    key: Key(e.name),
                                    title: Text(e.name),
                                    onTap: () {
                                      context
                                          .read<DefaultExerciseBloc>()
                                          .add(ActiveExerciseChanged(e));
                                    },
                                  ))
                              .toList();
                          return AnimatedContainer(
                              // um die Höhe der Listen dynamisch anzupassen
                              height: _bodyHeight *
                                  state.list
                                      .length, // Höhe anhand der Listenlänge berechnen
                              duration: const Duration(milliseconds: 500),
                              child: ListView(
                                  shrinkWrap: true, children: listTiles));
                        }),
                      ),
                      // Liste mit allen Übungsblöcken als Expansion
                      ExpansionPanelRadio(
                        value: 1,
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: const Text("Übungsblöcke"),
                            onTap: () {
                              setExpansion(1);
                            },
                          );
                        },
                        body: BlocBuilder<ExBlockSearchBloc,
                                ListState<ExerciseBlock, ParameterSet?>>(
                            builder: (context, state) {
                          final List<ListTile> listTiles = state.list
                              .map((ExerciseBlock e) => ListTile(
                                    key: Key(e.name),
                                    title: Text(e.name),
                                    onTap: () {
                                      context
                                          .read<DefaultExerciseBloc>()
                                          .add(ActiveExBlockChanged(e));
                                    },
                                  ))
                              .toList();
                          return AnimatedContainer(
                              // um die Höhe der Listen dynamisch anzupassen
                              height: _bodyHeight *
                                  state.list
                                      .length, // Höhe anhand der Listenlänge berechnen
                              duration: const Duration(milliseconds: 500),
                              child: ListView(
                                  shrinkWrap: true, children: listTiles));
                        }),
                      )
                    ]),
              ));
        }),
      ],
    );

    //);
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (query) {
        //Weitergabe der Sucheingabe
        context.read<ExerciseSearchBloc>().add(SearchInputChanged(query));
      },
      decoration: const InputDecoration(
        hintText: "Suche...",
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(//color),
                // Farblich muss das ganze noch angepasst werden
                )),
      ),
    );
  }
}
