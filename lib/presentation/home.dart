import 'package:ReHome/business_logic/navigation/navigation_cubit.dart';
import 'package:ReHome/presentation/exercise.dart';
import 'package:ReHome/presentation/dashboard.dart';
import 'package:ReHome/presentation/patients.dart';
import 'package:ReHome/presentation/settings.dart';
import 'package:ReHome/presentation/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sidebarx/sidebarx.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const Home());
  }

  @override
  Widget build(BuildContext context) {
    final SidebarXController controller =
        context.read<NavigationCubit>().sidebarController;
    return Scaffold(
      body: Row(
        children: [
          Sidebar(controller: controller),
          Expanded(child: BlocBuilder<NavigationCubit, NavigationState>(
              builder: (context, state) {
            switch (state) {
              case NavigationState.dashboard:
                return const Dashboard();
              case NavigationState.patient:
                return const PatientPage();
              case NavigationState.exercise:
                return const ExercisePage();
              case NavigationState.settings:
                return const SettingsPage();
            }
          })),
        ],
      ),
    );
  }
}
