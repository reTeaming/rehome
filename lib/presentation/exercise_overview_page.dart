import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehome/business_logic/default_exercise/default_exercise_bloc.dart';
import 'package:rehome/business_logic/exercisesearch/exblocksearch_bloc.dart';
import 'package:rehome/business_logic/exercisesearch/exercisesearch_bloc.dart';
import 'package:rehome/presentation/exercisesearchwidget.dart';

import 'exblock_page.dart';
import 'exercise_page.dart';

class ExerciseOverviewPage extends StatelessWidget {
  const ExerciseOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExerciseSearchBloc(),
        ),
        BlocProvider(
          create: (context) => ExBlockSearchBloc(),
        ),
        BlocProvider(
          create: (context) => DefaultExerciseBloc(),
        )
      ],
      child: Row(
        children: [
          const Expanded(flex: 1, child: ExerciseSearchWidget()),
          Expanded(
              flex: 3,
              child: BlocBuilder<DefaultExerciseBloc, DefaultExerciseState>(
                  builder: (context, state) {
                switch (state.activeEx) {
                  case ActiveExState
                        .inactive: //Falls keine Übung ausgewählt ist
                    return const Center(
                        child: Text(
                            "Wähle zuerst eine Übung oder Übungsblock aus"));
                  case ActiveExState
                        .activeExblock: // Falls ein Übungsblock ausgewählt ist
                    return ExBlockPage(state.activeExBlock);
                  case ActiveExState
                        .activeExercise: // Falls eine Übung ausgewählt ist
                    return ExercisePage(state.activeExercise);
                  case ActiveExState
                        .activeBlocktoExercise: // Falls eine Übung über einen Block ausgewählt wurde
                    return ExercisePage(state.activeExercise);
                }
              }))
        ],
      ),
    );
  }
}
