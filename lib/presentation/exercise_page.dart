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
  _ExBlockPopUpState createState() => _ExBlockPopUpState();
}

class _ExBlockPopUpState extends State<ExBlockPopUp> {
  int selectedIndex = -1; // initialize with -1 to indicate no selection

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExBlockSearchBloc,
        ListState<ExerciseBlock, ParameterSet?>>(builder: (context, state) {
      final List<ListTile> listTiles = HomeworkMock.blockList2
          .asMap() // use asMap to get the index of each element
          .map((int index, ExerciseBlock e) => MapEntry(
                index,
                ListTile(
                  key: Key(e.name),
                  title: Text(e.name),
                  onTap: () {
                    // setState(() {
                    //   selectedIndex = index; // update the selected index
                    // });
                    Navigator.of(context).pop();
                  },
                ),
              ))
          .values
          .toList();

      //Um die Größe des Popups anzupassen
      var height = MediaQuery.of(context).size.height;
      var width = MediaQuery.of(context).size.width;

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
                      content: SizedBox(
                        width: width - 400,
                        height: height - 400,
                        child: ListView(
                          children: listTiles,
                        ),
                      ),
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
    });
  }
}
