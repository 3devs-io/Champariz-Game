import 'package:champariz_game/card/bloc/bloc.dart';
import 'package:champariz_game/card/models/card.dart' as cards;
import 'package:champariz_game/game/bloc/bloc.dart';
import 'package:champariz_game/game/models/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameView extends StatefulWidget {
  GameView({Key key}) : super(key: key);

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  List<Widget> cards(LoadingGame state) {
    List<Widget> tempList = List<Widget>();

    state.game.deck.cards.forEach((card) {
      tempList.add(WardW(
        card: card,
      ));
    });

    return tempList;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: BlocBuilder<GameBloc, GameState>(builder: (context, state) {
          if (state is LoadingGame) {
            print("test");
            return Container(
                child: Scaffold(
                    backgroundColor: Theme.of(context).primaryColor,
                    body: SafeArea(
                        child: Column(
                      children: <Widget>[
                        Container(
                          child: Text("C'est à "),
                        ),
                        BlocProvider(
                          create: (BuildContext context) => CardBloc(),
                          child: Expanded(
                            child: GridView.count(
                              crossAxisCount: 5,
                              children: cards(state),
                            ),
                          ),
                        )
                      ],
                    ))));
          }

          return Text("An error has occured");
        }));
  }
}

class WardW extends StatefulWidget {
  final cards.Card card;
  WardW({Key key, @required this.card}) : super(key: key);

  @override
  _WardWState createState() => _WardWState();
}

class _WardWState extends State<WardW> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(builder: (context, state) {
      if (state is LoadingGame) {
        print(state.game.actualDeck.cards.length.toString() + " lol");
        return Container(
            child: GestureDetector(
          onDoubleTap: () {
            BlocProvider.of<GameBloc>(context)
                .add(CardTappedGame(state.game, widget.card));
          },
          child: Padding(
            child: Image.asset(
              !state.game.actualDeck.cards.contains(widget.card)
                  ? widget.card.imagePath
                  : "assets/back.png",
              width: 100,
              height: 50,
            ),
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          ),
        ));
      }
    });
  }
}
