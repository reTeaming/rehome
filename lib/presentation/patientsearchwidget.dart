//Implementierung von generischer SearchWidget
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rehome/business_logic/patientsearch/bloc/patientsearch_bloc.dart';
import 'package:rehome/business_logic/shared/list/list_bloc.dart';
import 'package:rehome/domain/models/patient/models.dart';

class PatientSearchWidget extends StatelessWidget {
  const PatientSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SeachBar(),
        const Divider(height: 20),
        BlocBuilder<PatientSearchBloc, ListState<Patient, PatientStatus?>>(
            buildWhen: (prev, curr) => prev.tag != curr.tag,
            builder: (context, state) {
              return Row(
                children: [
                  FilterButtonWidget(
                      PatientStatus.active, state.currentSearchTag),
                  const SizedBox(width: 10),
                  FilterButtonWidget(
                      PatientStatus.inactive, state.currentSearchTag),
                  const SizedBox(width: 10),
                  FilterButtonWidget(
                      PatientStatus.archived, state.currentSearchTag),
                ],
              );
            }),
        const Divider(height: 20),
        Expanded(
          child: RefreshIndicator(
              //key :
              color: Colors.white,
              backgroundColor: Colors.blue,
              strokeWidth: 4.0,
              onRefresh: () async {
                context.read<PatientSearchBloc>().add(RefreshList());
              },
              child: BlocBuilder<PatientSearchBloc,
                      ListState<Patient, PatientStatus?>>(
                  builder: (context, state) {
                final List<ListTile> listTiles = state.list
                    .map((Patient e) => ListTile(
                        key: Key('${e.name}'), title: Text("${e.name}")))
                    .toList();
                return ListView(children: listTiles);
              })),
        )
      ],
    );

    //);
  }
}

class SeachBar extends StatelessWidget {
  const SeachBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (query) {
        context.read<PatientSearchBloc>().add(SearchInputChanged(query));
      },
      decoration: const InputDecoration(
        hintText: "Suche...",
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(//color),
                // Farblich muss das ganze noch angepasst werden
                )),
      ),
    );
  }
}

//Eigenes Widget für die Filterbuttons
class FilterButtonWidget extends StatelessWidget {
  final PatientStatus tag;
  final PatientStatus? currentTag;

  const FilterButtonWidget(
    this.tag,
    this.currentTag, {
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    bool active = tag == currentTag;
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => context.read<PatientSearchBloc>().add(SearchTagChanged(tag)),
      child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: active ? theme.focusColor : const Color.fromRGBO(0, 0, 0, 0),
          ),
          child: Text(tagToString(tag))),
    );
  }

  String tagToString(PatientStatus tag) {
    switch (tag) {
      case PatientStatus.active:
        return "aktiv";
      case PatientStatus.inactive:
        return "inaktiv";
      case PatientStatus.archived:
        return "archiviert";
    }
  }
}
