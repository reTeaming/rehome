//Implementierung von generischer SearchWidget
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehome/business_logic/exblock/exblock_bloc.dart';
import 'package:rehome/business_logic/exercisesearch/exblocksearch_bloc.dart';
import 'package:rehome/domain/models/patient/default_exercise.dart';
import 'package:rehome/domain/models/patient/exercise.dart';
import 'package:rehome/domain/models/patient/homework.dart';

import '../business_logic/default_exercise/default_exercise_bloc.dart';
import '../business_logic/exercisesearch/exercisesearch_bloc.dart';
import '../business_logic/shared/list/list_bloc.dart';

class ExerciseSearchWidget extends StatefulWidget {
  const ExerciseSearchWidget({super.key});

  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<ExerciseSearchWidget> {
  bool isExpanded = false;

  void setExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(),
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
            child: ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setExpansion();
                },
                children: [
                  // Liste mit allen Übungen als Expansion
                  ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text("Übungen"),
                      onTap: () {
                        setExpansion();
                      },
                    );
                  }, body: BlocBuilder<ExerciseSearchBloc,
                              ListState<DefaultExercise, ParameterSet?>>(
                          builder: (context, state) {
                    final List<ListTile> listTiles = state.list
                        .map((DefaultExercise e) => ListTile(
                              key: Key(e.name),
                              title: Text(
                                e.name,
                              ),
                              // TODO: add on tap to change side - probably through bloc
                              onTap: () {
                                context
                                    .read<DefaultExerciseBloc>()
                                    .add(ActiveExerciseChanged(e));
                              },
                            ))
                        .toList();
                    return ListView(children: listTiles);
                  })),
                  // Liste mit allen Übungsblöcken als Expansion
                  ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text("Übungsblöcke"),
                      onTap: () {
                        setExpansion();
                      },
                    );
                  }, body: BlocBuilder<ExBlockSearchBloc,
                              ListState<ExerciseBlock, ParameterSet?>>(
                          builder: (context, state) {
                    final List<ListTile> listTiles = state.list
                        .map((ExerciseBlock e) => ListTile(
                              // key: Key(e.name),
                              title: Text(""
                                  // e.name,
                                  //wartet auf Lenas änderung das Blöcke Namen haben
                                  ),
                              onTap: () {
                                // context.add.dingschanged (e)
                                context
                                    .read<ExBlockBloc>()
                                    .add(ActiveExBlockChanged(e));
                              },
                              // TODO: add on tap to change side - probably through bloc
                            ))
                        .toList();
                    return ListView(children: listTiles);
                  }))
                ]),
          );
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
