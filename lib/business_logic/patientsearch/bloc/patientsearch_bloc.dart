import 'package:rehome/business_logic/shared/list/list_bloc.dart';
import 'package:rehome/domain/models/patient/patient.dart';

class PatientSearchBloc extends ListBloc<Patient, PatientStatus?> {
  // SearchRepository repository = SearchRepository();

  //  PatientSearchBloc({required SearchRepository searchRepository})
  //      : PatientSearchBloc(super.initialState);

  @override
  Future<List<Patient>> onRefresh() {
    throw UnimplementedError();
  }

  @override
  Future<List<Patient>> onSearchQueryChanged(SearchInputChanged event,
      ListState<Patient, PatientStatus?> state) async {
    String searchInput = event.query.toLowerCase();

    final filteredList = state.list.where((object) {
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
      ListState<Patient, PatientStatus?> state) async {
    if (event.tag == null) {
      return state.baseList;
    }
    // filtert die List nach Patienten Status
    return state.list.where((element) => element.status == event.tag).toList();
  }
}
