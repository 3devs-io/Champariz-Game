import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameView extends StatefulWidget {
  GameView({Key key}) : super(key: key);

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  List<Widget> listTest = List<Widget>();

  addTestWidgets() {
    for (int i = 0; i < 52; i++) {
      listTest.add(Card(
        child: Image(image: AssetImage('assets/2_of_clubs.png')),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    addTestWidgets();
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Container(
            child: Scaffold(
                backgroundColor: Theme.of(context).primaryColor,
                body: SafeArea(
                    child: Center(
                        child: GridView.count(  //TODO : Need to fix this, layout is currently not working as expected
                  children: listTest,
                  padding: EdgeInsets.all(20),
                  crossAxisCount: 6,
                ))))));
  }
}
