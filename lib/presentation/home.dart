import 'package:rehome/business_logic/navigation/navigation_cubit.dart';
import 'package:rehome/business_logic/patient/patient_bloc.dart';
import 'package:rehome/business_logic/patientsearch/bloc/patientsearch_bloc.dart';
import 'package:rehome/domain/repositories/patient_repository.dart';
import 'package:rehome/presentation/exercise.dart';
import 'package:rehome/presentation/dashboard.dart';
import 'package:rehome/presentation/patient_overview_page.dart';
import 'package:rehome/presentation/settings.dart';
import 'package:rehome/presentation/sidebar.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PatientBloc()),
        BlocProvider(
            create: (context) =>
                PatientSearchBloc(repository: PatientRepository()))
      ],
      child: Scaffold(
        body: Row(
          children: [
            Sidebar(controller: controller),
            Expanded(child: BlocBuilder<NavigationCubit, NavigationState>(
                builder: (context, state) {
              switch (state) {
                case NavigationState.dashboard:
                  return const DashBoard();
                case NavigationState.patient:
                  return const PatientOverviewPage();
                case NavigationState.exercise:
                  return const ExercisePage();
                case NavigationState.settings:
                  return const SettingsPage();
              }
            })),
          ],
        ),
      ),
    );
  }
}
