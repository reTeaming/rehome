import 'package:bloc/bloc.dart';
import 'package:sidebarx/sidebarx.dart';

enum NavigationState { dashboard, patient, exercise, settings }

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState.dashboard) {
    _controller = SidebarXController(selectedIndex: 0, extended: false);
    _controller.addListener(_sidebarListener);
  }

  late final SidebarXController _controller;

  SidebarXController get sidebarController => _controller;

  void _updateController(NavigationState state) {
    late final int index;
    switch (state) {
      case NavigationState.dashboard:
        index = 0;
        break;
      case NavigationState.patient:
        index = 1;
        break;
      case NavigationState.exercise:
        index = 2;
        break;
      case NavigationState.settings:
        index = 3;
        break;
    }
    //calls notify listeners internally
    _controller.selectIndex(index);
  }

  void _sidebarListener() {
    late final NavigationState state;
    switch (_controller.selectedIndex) {
      case 0:
        state = NavigationState.dashboard;
        break;
      case 1:
        state = NavigationState.patient;
        break;
      case 2:
        state = NavigationState.exercise;
        break;
      case 3:
        state = NavigationState.settings;
        break;
    }
    emit(state);
  }

  void _changePage(NavigationState state) {
    _updateController(state);
    emit(state);
  }

  void openDashboard() {
    _changePage(NavigationState.dashboard);
  }

  void openPatients() {
    _changePage(NavigationState.patient);
  }

  void openExercises() {
    _changePage(NavigationState.exercise);
  }

  void openSettings() {
    _changePage(NavigationState.settings);
  }
}
