import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameView extends StatefulWidget {
  GameView({Key key}) : super(key: key);

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  List<Widget> listTest = List<Widget>();

  addTestWidgets() {
    for (int i = 0; i < 52; i++) {
      listTest.add(Padding(
        child: Image.asset(
          "assets/king_of_diamonds2.png",
          width: 100,
          height: 50,
        ),
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                    child: Column(
                  children: <Widget>[
                    Text("C'est au tour de " + "Simon"),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 5,
                        //TODO : Need to fix this, layout is currently not working as expected
                        children: listTest,
                      ),
                    )
                  ],
                )))));
  }
}
