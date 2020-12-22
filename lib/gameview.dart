import 'package:champariz_game/game/models/card.dart' as cards;
import 'package:champariz_game/game/bloc/bloc.dart';
import 'package:champariz_game/player/models/player.dart';
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
          listener: (context, state) {
            if (state is DrinkState) {
              showDialog<void>(
                barrierDismissible: false,
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
              showDialog<void>(
                barrierDismissible: false,
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
            if (state is EveryoneDrinkState) {
              showDialog<void>(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return PersonalAlertDialog(
                    widgetList: [
                      Text(
                          "Tout le monde boit ${state.sips.toString()} gorgées !")
                    ],
                    callback: () {
                      BlocProvider.of<GameBloc>(context)
                          .add(DrankEvent(state.playersList, state.sips));
                    },
                  );
                },
              );
            }
            if (state is GiveDrinkState) {
              showDialog<void>(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  Player dropdownValue;
                  return StatefulBuilder(builder: (context, setState) {
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
                          children: [
                            Text(
                                "${state.actualPlayer.getName()} tu distribues ${state.sips.toString()} gorgées !"),
                            DropdownButton<Player>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(color: Color(0xff4da1a9)),
                              underline: Container(
                                height: 2,
                                color: const Color(0xff4da1a9),
                              ),
                              onChanged: (Player newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: state.playersList
                                  .map<DropdownMenuItem<Player>>(
                                      (Player value) {
                                return DropdownMenuItem<Player>(
                                  value: value,
                                  child: Text(value.getName()),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        Center(
                          child: RaisedButton(
                            splashColor: Colors.white,
                            elevation: 8.0,
                            color: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            onPressed: dropdownValue != null
                                ? () {
                                    Navigator.of(context).pop();
                                    BlocProvider.of<GameBloc>(context).add(
                                        GaveDrinkEvent(
                                            dropdownValue, state.sips));
                                  }
                                : null,
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
                  });
                },
              );
            }
            if (state is StatsState) {
              final List<BarChartGroupData> barGroup = [];
              int count = 0;
              for (final Player player in state.playersList) {
                barGroup.add(
                  BarChartGroupData(
                    x: count,
                    barRods: [
                      BarChartRodData(
                          y: player.getNbGorgees().toDouble(),
                          colors: [Colors.lightBlueAccent, Colors.greenAccent])
                    ],
                    showingTooltipIndicators: [0],
                  ),
                );
                count++;
              }
              showDialog<void>(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'On a bien bu !',
                      style: GoogleFonts.getFont(
                        'Raleway',
                        color: Colors.black,
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: ListBody(children: [
                        AspectRatio(
                          aspectRatio: 1.7,
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            color: const Color(0xff2c4260),
                            child: BarChart(
                              BarChartData(
                                alignment: BarChartAlignment.spaceAround,
                                maxY: 100,
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: SideTitles(
                                    showTitles: true,
                                    getTextStyles: (value) => const TextStyle(
                                        color: Color(0xff7589a2),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                    margin: 20,
                                    getTitles: (double value) {
                                      return state.playersList[value.toInt()]
                                          .getName();
                                    },
                                  ),
                                  leftTitles: SideTitles(showTitles: false),
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                barGroups: barGroup,
                              ),
                            ),
                          ),
                        )
                      ]),
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
                            BlocProvider.of<GameBloc>(context)
                                .add(const StatsSeenEvent());
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
                },
              );
            }
            if (state is EndState) {
              Navigator.pushReplacementNamed(context, homeRoute);
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
                      // Debug buttn to skip the game and go to StatsState
                      // ElevatedButton(
                      //     onPressed: () {
                      //       BlocProvider.of<GameBloc>(context)
                      //           .add(const StatsDebug());
                      //     },
                      //     child: const Text("StatsDebug"))
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
              !state.deck.contains(card) ? "assets/back.png" : card.imagePath,
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
