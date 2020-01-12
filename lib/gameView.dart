import 'package:champariz_game/card.dart' as cards;
import 'package:champariz_game/game.dart';
import 'package:champariz_game/player.dart';
import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  GameView({Key key}) : super(key: key);

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  Game game = Game([Player("Simon"), Player("Théophile")]);

  

  List<Widget> addTestWidgets() {
    List<Widget> tempList = List<Widget>();

    print(game.currentPlayer);

    game.deck.cards.forEach((cards.Card card) {
      tempList.add(GestureDetector(
        onDoubleTap: () {
          setState(() {
            print("revealed");
            card.revealed = true;
            print(card.revealed);
          });
        },
        child: Padding(
          child: Image.asset(
            card.revealed ? card.imagePath : "assets/back.png",
            width: 100,
            height: 50,
          ),
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        ),
      ));
    });

    return tempList;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Container(
            child: Scaffold(
                backgroundColor: Theme.of(context).primaryColor,
                body: SafeArea(
                    child: Column(
                  children: <Widget>[
                    Container(
                      child: Text("C'est à " + game.currentPlayer.getName()),
                    ),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 5,
                        children: addTestWidgets(),
                      ),
                    )
                  ],
                )))));
  }
}
