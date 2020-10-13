import 'package:champariz_game/game/models/card.dart' as cards;
import 'package:champariz_game/game/bloc/bloc.dart';
import 'package:champariz_game/game/models/game.dart';
import 'package:champariz_game/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class GameView extends StatefulWidget {
  GameView({Key key}) : super(key: key);

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  List<Widget> cards(Game game) {
    List<Widget> tempList = List<Widget>();

    game.deck.cards.forEach((card) {
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
        child: BlocListener<GameBloc, GameState>(
          listener: (context, state) {
            if (state is EndedGame) {
              Navigator.pushNamed(context, HomeRoute);
            }
            if (state is DrinkingGame) {
              showDialog<void>(
                context: context,
                barrierDismissible: false, // user must tap button!
                builder: (BuildContext context) {
                  String players;
                  state.players.forEach((player) {
                    players = player.getName() + " ";
                  });
                  return AlertDialog(
                    title: Text(
                      'Il est temps de boire !',
                      style: GoogleFonts.getFont(
                        'Raleway',
                        color: Colors.black,
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text(
                            "Joueur(s) : " + players,
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            state.toDrink,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                            'Regretter de jouer à des jeux d\'alcool et boire pour oublier'),
                        onPressed: () {
                          if (state.isFinished) {
                            Navigator.pushNamed(context, HomeRoute);
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: BlocBuilder<GameBloc, GameState>(builder: (context, state) {
            if (state is LoadingGame) {
              return Container(
                  child: Scaffold(
                      backgroundColor: Theme.of(context).primaryColor,
                      body: SafeArea(
                          child: Column(
                        children: <Widget>[
                          Container(
                            child: Text(
                              "C'est à " +
                                  state.game.currentPlayer.getName() +
                                  " de jouer",
                              style: GoogleFonts.getFont(
                                'Raleway',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 5,
                              children: cards(state.game),
                            ),
                          ),
                        ],
                      ))));
            }

            return Text(
              "An error has occured",
              style: GoogleFonts.getFont(
                'Raleway',
                color: Colors.white,
              ),
            );
          }),
        ));
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
        return Container(
            child: GestureDetector(
          onDoubleTap: () {
            if (state.game.actualDeck.cards.contains(widget.card)) {
              BlocProvider.of<GameBloc>(context)
                  .add(CardTappedGame(state.game, widget.card));
            }
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

      return Text("An error has occured");
    });
  }
}
