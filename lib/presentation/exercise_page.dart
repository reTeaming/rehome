import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehome/business_logic/exercisesearch/exblocksearch_bloc.dart';
import 'package:rehome/mocks/mock_homework.dart';
import '../business_logic/default_exercise/default_exercise_bloc.dart';
import '../business_logic/shared/list/list_bloc.dart';
import '../domain/models/patient/default_exercise.dart';
import '../domain/models/patient/exercise.dart';
import '../domain/models/patient/homework.dart';

class ExercisePage extends StatelessWidget {
  final DefaultExercise? activeExercise;

  const ExercisePage(this.activeExercise, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BacktoExBlockLogic(),
        Text(activeExercise!.name,
            style: const TextStyle(
              fontSize: 36.0,
              decoration: TextDecoration.underline,
            )),
        Align(
            alignment: const Alignment(-0.90, -0.90),
            child: Text("ID:${activeExercise!.id}")),
        const Align(alignment: Alignment(0.90, 0.90), child: ExBlockPopUp()),
      ],
    );
  }
}

class BacktoExBlockLogic extends StatelessWidget {
  const BacktoExBlockLogic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DefaultExerciseBloc, DefaultExerciseState>(
        builder: (context, state) {
      switch (state.activeEx) {
        case ActiveExState.activeExercise:
          return const SizedBox();
        case ActiveExState.activeBlocktoExercise:
          return Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                onPressed: () =>
                    context.read<DefaultExerciseBloc>().add(BacktoBlock()),
                icon: const Icon(Icons.arrow_back)),
          );
        case ActiveExState.activeExblock:
          return const Text("ERROR");
        case ActiveExState.inactive:
          return const Text("ERROR");
      }
    });
  }
}

class ExBlockPopUp extends StatefulWidget {
  const ExBlockPopUp({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ExBlockPopUpState createState() => _ExBlockPopUpState();
}

class _ExBlockPopUpState extends State<ExBlockPopUp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExBlockSearchBloc,
        ListState<ExerciseBlock, ParameterSet?>>(builder: (context, state) {
      final List<ListTile> listTiles =
          HomeworkMock.blockList2.map((ExerciseBlock e) {
        return ListTile(
          key: Key(e.name),
          title: Text(e.name),
          onTap: () {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (context) {
                  Future.delayed(const Duration(milliseconds: 800), () {
                    Navigator.of(context).pop();
                  });
                  return AlertDialog(
                      title:
                          Text("Übung wurde zu Block ${e.name} hinzugefügt"));
                },
                barrierDismissible: false);
          },
        );
      }).toList();

      //Um die Größe des Popups anzupassen
      var height = MediaQuery.of(context).size.height;
      var width = MediaQuery.of(context).size.width;

      return ExBlockPopUpButton(
          width: width, height: height, listTiles: listTiles);
    });
  }
}

class ExBlockPopUpButton extends StatelessWidget {
  const ExBlockPopUpButton({
    super.key,
    required this.width,
    required this.height,
    required this.listTiles,
  });

  final double width;
  final double height;
  final List<ListTile> listTiles;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showDialog(
            context: context, // use the context from BlocBuilder here
            builder: (BuildContext context) {
              return StatefulBuilder(
                // use StatefulBuilder here
                builder: (context, setState) {
                  // get the setState function here
                  return AlertDialog(
                    title: const Text('Liste der Blöcke'),
                    content: SingleChildScrollView(
                      child: SizedBox(
                        width: width - 400,
                        height: height - 400,
                        child: ListView(
                          children: listTiles,
                        ),
                      ),
                    ),
                    actions: const <Widget>[
                      //Neuen Übungsblock erstellen button:
                      Align(
                        alignment: Alignment.center,
                        child: NewExBlockButton(),
                      ),
                    ],
                  );
                },
              );
            });
      },
      icon: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      label: const Text(
        "Diese Übung zu einem Übungsblock hinzufügen",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class NewExBlockButton extends StatelessWidget {
  const NewExBlockButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
            textStyle:
                MaterialStateProperty.all(const TextStyle(fontSize: 20))),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Name des neuen Übungsblocks:"),
                  content: const TextField(
                    // onChanged: (query) {

                    // },
                    decoration: InputDecoration(
                      hintText: "Hier eingeben",
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Abbrechen'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Speichern'),
                      onPressed: () {
                        //Hier fehlt noch das Abspeichern im Backend
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        },
        child: const Text("neuen Übungsblock erstellen"));
  }
}
