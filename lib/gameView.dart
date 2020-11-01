import 'package:champariz_game/game/models/card.dart' as cards;
import 'package:champariz_game/game/bloc/bloc.dart';
import 'package:champariz_game/game/models/game.dart';
import 'package:champariz_game/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

import 'game/bloc/game_state.dart';

class GameView extends StatefulWidget {
  const GameView({Key key}) : super(key: key);

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  List<Widget> generateCards(List<cards.Card> deck) {
    final List<Widget> tempList = [];
    for (final cards.Card card in deck) {
      tempList.add(CardW(
        card: card,
      ));
    }

    return tempList;
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: BlocListener<GameBloc, GameState>(
          listener: (context, state) async {
            if (state is DrinkState) {
              await showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return PersonalAlertDialog(
                    widgetList: [
                      Text(
                          "${state.actualPlayer.getName()} tu bois ${state.sips.toString()} gorgées !")
                    ],
                    callback: () {
                      BlocProvider.of<GameBloc>(context)
                          .add(DrankEvent([state.actualPlayer], state.sips));
                    },
                  );
                },
              );
            }
            if (state is FinishDrinkState) {
              await showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return PersonalAlertDialog(
                    widgetList: [
                      Text("${state.actualPlayer.getName()} tu bois cul sec !")
                    ],
                    callback: () {
                      BlocProvider.of<GameBloc>(context)
                          .add(DrankEvent([state.actualPlayer], 10));
                    },
                  );
                },
              );
            }
            if (state is GiveDrinkState) {
              await showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return PersonalAlertDialog(
                    widgetList: [
                      Text(
                          "${state.actualPlayer.getName()} tu distribues ${state.sips.toString()} gorgées !")
                    ],
                    callback: () {
                      BlocProvider.of<GameBloc>(context)
                          .add(GaveDrinkEvent(state.actualPlayer, state.sips));
                    },
                  );
                },
              );
            }
          },
          child: BlocBuilder<GameBloc, GameState>(builder: (context, state) {
            if (state is PlayingState) {
              return Scaffold(
                  backgroundColor: Theme.of(context).primaryColor,
                  body: SafeArea(
                      child: Column(
                    children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).size.width / 7,
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                  text: "C'est à ",
                                  style: GoogleFonts.getFont('Raleway',
                                      color: Colors.white, fontSize: 22),
                                  children: [
                                    TextSpan(
                                      text: state.actualPlayer.getName(),
                                      style: GoogleFonts.getFont('Raleway',
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: " de jouer",
                                      style: GoogleFonts.getFont('Raleway',
                                          color: Colors.white, fontSize: 22),
                                    )
                                  ]),
                            ),
                          )),
                      Expanded(
                          child: Scrollbar(
                        isAlwaysShown: true,
                        controller: _scrollController,
                        thickness: 5,
                        child: GridView.count(
                          controller: _scrollController,
                          crossAxisCount: 5,
                          children: generateCards(state.fullDeck),
                        ),
                      )),
                    ],
                  )));
            }

            return Scaffold(
                backgroundColor: Theme.of(context).primaryColor,
                body: Container());
          }),
        ));
  }
}

class CardW extends StatelessWidget {
  final cards.Card card;
  const CardW({Key key, @required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(builder: (context, state) {
      if (state is PlayingState) {
        return SizedBox(
            child: GestureDetector(
          onDoubleTap: () {
            if (state.deck.contains(card)) {
              BlocProvider.of<GameBloc>(context).add(CardRevealEvent(card));
            }
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Image.asset(
              !state.deck.contains(card) ? card.imagePath : "assets/back.png",
              width: 100,
              height: 50,
            ),
          ),
        ));
      }

      return const Text("An error has occured");
    });
  }
}

class PersonalAlertDialog extends StatelessWidget {
  final List<Widget> widgetList;
  final void Function() callback;

  const PersonalAlertDialog(
      {Key key, @required this.widgetList, @required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Il est temps de boire !',
        style: GoogleFonts.getFont(
          'Raleway',
          color: Colors.black,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(children: widgetList),
      ),
      actions: <Widget>[
        Center(
          child: RaisedButton(
            splashColor: Colors.white,
            elevation: 8.0,
            color: Theme.of(context).accentColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            onPressed: () {
              Navigator.of(context).pop();
              callback();
            },
            child: Text(
              "Ok",
              style: GoogleFonts.getFont(
                'Raleway',
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
