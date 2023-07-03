//Implementierung von generischer SearchWidget
import 'package:ReHome/business_logic/patientsearch/bloc/patientsearch_bloc.dart';
import 'package:ReHome/business_logic/shared/list/list_bloc.dart';
import 'package:ReHome/domain/models/patient/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientSearchBlocSearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (query) {
            //Weitergabe der Sucheingabe
            context.read<PatientSearchBloc>().add(SearchInputChanged(query));
          },
          decoration: const InputDecoration(
            hintText: "Suche...",
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(//color),
                    // Farblich muss das ganze noch angepasst werden
                    )),
          ),
        ),
        const Divider(height: 10),
        Flexible(
          //Filterbuttons eigenem Widget
          flex: 1,
          child: BlocBuilder<PatientSearchBloc, ListState>(
            builder: (context, state) {
              return const Row(children: [
                FilterButtonWidget("Aktive PatientSearchBlocen"),
              ]);
            },
          ),
        ),
        const Divider(height: 10),
        Flexible(
          //Anzeige der Patienten als Liste
          flex: 7,
          child: BlocBuilder<PatientSearchBloc, ListState>(
              builder: (context, state) {
            return RefreshIndicator(
              //key :
              color: Colors.white,
              backgroundColor: Colors.blue,
              strokeWidth: 4.0,
              onRefresh: () async {
                //Logik hinter dem Refreshen
                return Future<void>.delayed(const Duration(milliseconds: 300));
              },
              child: ListView(
                children: <Widget>[
                  // Erstellen der einzelnen Listenelemente :
                  for (int index = 0;
                      index <
                          state
                              .list.length; //Länge von der Liste vom Repository
                      index += 1)
                    ListTile(
                      key: Key('$index'),
                      tileColor: Theme.of(context).focusColor, //random Farbe
                      title: Text(state.list[index].name.toString()),
                      onTap: () {
                        // Hier darf die Weiterleitung zum PatientSearchBloc rein
                      },
                    ),
                ],
              ),
            );
          }),
        ),
      ],
    );

    //);
  }
}

//Eigenes Widget für die Filterbuttons
class FilterButtonWidget extends StatelessWidget {
  final String displayText;
  const FilterButtonWidget(
    this.displayText, {
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientSearchBloc, ListState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            //Wenn der Button gedrückt wird ändert sich der Status zum entgegengesetzten
            PatientStatus patientStatus = state.tag == PatientStatus.ACTIVE
                ? PatientStatus.INACTIVE
                : PatientStatus.INACTIVE;
            context
                .read<PatientSearchBloc>()
                .add(SearchTagChanged(patientStatus));
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10.0), // Rounded corners
            ),
            child: Text(displayText),
          ),
        );
      },
    );
  }
}
