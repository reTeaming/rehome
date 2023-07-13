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
        const BacktoExBlockLogic(), //Button zum zurückgehen, wenn man von einem Block kommt
        Text(activeExercise!.name, //Name der Übung als Überschrift
            style: const TextStyle(
              fontSize: 36.0,
              decoration: TextDecoration.underline,
            )),
        Align(
            //ID der Übung bzw Details
            alignment: const Alignment(-0.90, -0.90),
            child: Text("ID:${activeExercise!.id}")),
        const Align(
            alignment: Alignment(0.90, 0.90),
            child:
                ExBlockPopUp()), //Button zum hinzufügen der Übung zu einem Block
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
        //Switch-Case um zu entscheiden, ob man von einem Block kommt
        case ActiveExState.activeExercise:
          return const SizedBox();
        case ActiveExState.activeBlocktoExercise:
          return Align(
            alignment: Alignment.topLeft,
            child: IconButton(
                //Button zum zurückgehen
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

class ExBlockPopUp extends StatelessWidget {
  //PopUp zum hinzufügen der Übung zu einem Block
  const ExBlockPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExBlockSearchBloc,
        ListState<ExerciseBlock, ParameterSet?>>(builder: (context, state) {
      final List<ListTile> listTiles =
          HomeworkMock.blockList2.map((ExerciseBlock e) {
        return ListTile(
          //ListTile aus den Exercises für jeden Block
          key: Key(e.name),
          title: Text(e.name),
          onTap: () {
            //TODO: Übung zu Block hinzufügen in Backend und abspeichern
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (context) {
                  Future.delayed(const Duration(milliseconds: 800), () {
                    //Popup schließt sich nach 0.8 Sekunden
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
  //Button zum öffnen des Popups
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
            context: context,
            builder: (BuildContext context) {
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
  //Button zum erstellen eines neuen Übungsblocks
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
          //Popup zum erstellen eines neuen Übungsblocks
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Name des neuen Übungsblocks:"),
                  content: const TextField(
                    //Eingabe vom Textfeld an Backend weitergeben und dort abspeichern
                    // onChanged: (query) {

                    // },
                    decoration: InputDecoration(
                      hintText: "Hier eingeben",
                    ),
                  ),
                  actions: <Widget>[
                    //Buttons zum abbrechen und speichern
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
                        //TODO: neuen Übungsblock in Backend speichern
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
