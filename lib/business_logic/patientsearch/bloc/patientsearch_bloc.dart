import 'package:rehome/business_logic/shared/list/list_bloc.dart';
import 'package:rehome/domain/models/patient/patient.dart';
import 'package:rehome/domain/repositories/patient_repository.dart';

class PatientSearchBloc extends ListBloc<Patient, PatientStatus?> {
  final PatientRepository repository;

  PatientSearchBloc({required this.repository});

  // Wird bei jeder aktualliserung sowie der initialen Erstellung des Blocs aufgerufen.
  @override
  Future<List<Patient>> onRefresh() async {
    return await repository.getPatients();
  }

  @override
  Future<List<Patient>> onSearchQueryChanged(SearchInputChanged event,
      ListState<Patient, PatientStatus?> state) async {
    String searchInput = event.query.toLowerCase();

    final filteredList = state.baseList.where((object) {
      return object.name.surname.toLowerCase().contains(searchInput) ||
          object.name.name.toLowerCase().contains(searchInput) ||
          object.therapyStart.toString().toLowerCase().contains(searchInput) ||
          object.status.toString().toLowerCase().contains(searchInput);
    });

    return filteredList.toList();
  }

  @override
  Future<List<Patient>> onSearchTagChanged(
      SearchTagChanged<PatientStatus?> event,
      ListState<Patient, PatientStatus?> state,
      Function() removeTag) async {
    if (event.tag == null) {
      return state.baseList;
    }

    if (event.tag == state.tag) {
      removeTag();
      return state.baseList;
    }
    // filtert die List nach Patienten Status
    return state.baseList
        .where((element) => element.status == event.tag)
        .toList();
  }
}
