import 'package:flutter/material.dart';

class PatientsPage extends StatelessWidget {
  const PatientsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const PatientsPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            onStretchTrigger: () {
              // Function callback for stretch
              return Future<void>.value();
            },
            expandedHeight: 250.0,
            flexibleSpace: const FlexibleSpaceBar(
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              centerTitle: false,
              title: Text('Patient X, geb. am, in Therapie seit:'),
              background: FlutterLogo(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              const <Widget>[
                Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(
                          height: 400,
                          width: 600,
                          child: Card(child: Text('HausaufgabenPlan'))),
                      SizedBox(
                          height: 400,
                          width: 600,
                          child: Card(child: Text('Übungen'))),
                    ]),
                    SizedBox(
                        height: 400,
                        width: 1200,
                        child: Card(child: Text('Ziele'))),
                  ],
                ),
                // ListTiles++
              ],
            ),
          ),
        ],
      ),
    );
  }
}
