import 'package:flutter/material.dart';
import 'package:basic_app/theme.dart';
import 'package:basic_app/screens/home.dart';
import 'package:basic_app/screens/information.dart';

/// This library contains all custom widgets of the ReHome app

class _RehomeAppBarState extends State<RehomeAppBar> {
  late ScrollController _scrollController;
  final List<Widget> menuItems;
  final expandedHeight = 200.0;
  bool showCalendarIcon = false;

  _RehomeAppBarState(this.menuItems);

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >
        this.expandedHeight - kToolbarHeight) {
      setState(() => this.showCalendarIcon = true);
    } else {
      setState(() => this.showCalendarIcon = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(controller: _scrollController, slivers: [
      SliverAppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(impulsBorderRadius),
                  bottomRight: Radius.circular(impulsBorderRadius))),
          pinned: true,
          expandedHeight: this.expandedHeight,
          flexibleSpace: ClipRRect(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(impulsBorderRadius)),
            child: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "Mein ReHome",
                  style: Theme.of(context).textTheme.headline1,
                ),
                background: Image.asset(
                  'assets/background.png',
                  width: 600,
                  height: 200,
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.bottomCenter,
                )),
          ),
          actions: [
            Visibility(
                visible: this.showCalendarIcon,
                child: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () =>
                        Navigator.of(context).pushNamed('/calendar')))
          ]),
      SliverPadding(
          padding: EdgeInsets.all(16),
          sliver:
              SliverList(delegate: SliverChildListDelegate(this.menuItems))),
    ]));
  }
}

/// The AppBar that includes the header and the list of menu items on the main
/// screen
/// The AppBar has an ephemeral state to control the state of scrolling
/// (appbar expanded or not)
class RehomeAppBar extends StatefulWidget {
  final menuItems;

  RehomeAppBar(this.menuItems);

  @override
  _RehomeAppBarState createState() => _RehomeAppBarState(this.menuItems);
}

/// Menu item base class for the items of the main menu
abstract class MainMenuItem extends Widget {}

/// The items of the main menu that identify each section
/// In Material design including InkWell but with custom rounded rectangle
class SectionItem extends StatelessWidget implements MainMenuItem {
  final String title;
  final Widget icon;
  final double fontSize = 24;
  final String targetRoute;

  SectionItem(this.title, this.icon, this.targetRoute);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Card(
        shape: impulsBorderShape,
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(this.targetRoute);
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(child: this.icon, flex: 1),
                Expanded(
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          this.title,
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                    flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Insert vertical empty space
/// Useful for menu items, for example
class CustomSpacer extends StatelessWidget implements MainMenuItem {
  final double space;

  CustomSpacer(this.space);

  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.symmetric(vertical: this.space));
  }
}

/// # Abstract class for default screens of the RehomeApp
/// Provide a title [title] and a list of icons/images [icons] to display at the
/// right end of the bar. The provided [body] is the widget representing the
/// contents of the screen below the app bar.
abstract class DefaultScreen extends Widget {
  final String title;

  DefaultScreen(this.title);
}

/// # Default AppBar shown on the section screens
AppBar buildImpulsAppBar(BuildContext context, String title) {
  return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline1,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(impulsBorderRadius),
              bottomRight: Radius.circular(impulsBorderRadius))),
      actions: null);
}

/// Static functions for globally named routing in the App
class ImpRouter {
  /// Specify all routes using strings
  // MaterialApp's onGenerateRoute needs static access to this function
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/information':
        return createRoute(infoScreen);
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }

  /// Creates route with animation
  /// The end of the route is [targetScreen]
  static Route createRoute(DefaultScreen targetScreen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => targetScreen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
