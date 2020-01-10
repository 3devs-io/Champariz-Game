import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  GameView({Key key}) : super(key: key);

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: SafeArea(
              child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: mediaQuery.size.height / 10,
                ),
                FlutterLogo(
                  size: 250,
                ),
                SizedBox(
                  height: mediaQuery.size.height / 30,
                ),
                Text(
                  "Jouer à Champariz",
                  style: TextStyle(fontSize: 22.5),
                ),
                SizedBox(
                  height: mediaQuery.size.height / 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.people),
                    Text(
                      "Nombre de joueurs",
                      style: TextStyle(fontSize: 12.5),
                    ),
                  ],
                ),
              ],
            ),
          ))),
    );
  }
}
