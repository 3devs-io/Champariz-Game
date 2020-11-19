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
    final ScrollController _scrollController = ScrollController();
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: BlocListener<GameBloc, GameState>(
          listener: (context, state) async {
            if (state is EndedGame) {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  List<BarChartGroupData> barGroup = [];
                  int count = 0;
                  state.playerList.forEach((player) {
                    barGroup.add(
                      BarChartGroupData(
                        x: count,
                        barRods: [
                          BarChartRodData(
                              y: player.getNbGorgees().toDouble(),
                              colors: [
                                Colors.lightBlueAccent,
                                Colors.greenAccent
                              ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                    );
                    count++;
                  });
                  return AlertDialog(
                    title: Text(
                      'Récapitulatif de partie',
                      style: GoogleFonts.getFont(
                        'Raleway',
                        color: Colors.black,
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
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
                                  maxY: 20,
                                  barTouchData: BarTouchData(
                                    enabled: false,
                                    touchTooltipData: BarTouchTooltipData(
                                      tooltipBgColor: Colors.transparent,
                                      tooltipPadding: const EdgeInsets.all(0),
                                      tooltipBottomMargin: 8,
                                      getTooltipItem: (
                                        BarChartGroupData group,
                                        int groupIndex,
                                        BarChartRodData rod,
                                        int rodIndex,
                                      ) {
                                        return BarTooltipItem(
                                          rod.y.round().toString(),
                                          TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
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
                                        return state.playerList[value.toInt()]
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
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      Center(
                        child: RaisedButton(
                          splashColor: Colors.white,
                          elevation: 8.0,
                          child: Text(
                            "Ok",
                            style: GoogleFonts.getFont(
                              'Raleway',
                              color: Colors.white,
                            ),
                          ),
                          color: Theme.of(context).accentColor,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          onPressed: () {
                            Navigator.pushNamed(context, homeRoute);
                          },
                        ),
                      )
                    ],
                  );
                },
              );
            }
            if (state is DrinkingGame) {
              await showDialog<void>(
                context: context,
                builder: (BuildContext context) {
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
                            state.toDrink,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      Center(
                        child: RaisedButton(
                          splashColor: Colors.white,
                          elevation: 8.0,
                          child: Text(
                            "Ok",
                            style: GoogleFonts.getFont(
                              'Raleway',
                              color: Colors.white,
                            ),
                          ),
                          color: Theme.of(context).accentColor,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      )
                    ],
                  );
                },
              ).then((value) {
                if (state.isFinished) {
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      List<BarChartGroupData> barGroup = [];
                      int count = 0;
                      state.players.forEach((player) {
                        barGroup.add(
                          BarChartGroupData(
                            x: count,
                            barRods: [
                              BarChartRodData(
                                  y: player.getNbGorgees().toDouble(),
                                  colors: [
                                    Colors.lightBlueAccent,
                                    Colors.greenAccent
                                  ])
                            ],
                            showingTooltipIndicators: [0],
                          ),
                        );
                        count++;
                      });
                      return AlertDialog(
                        title: Text(
                          'Récapitulatif de partie',
                          style: GoogleFonts.getFont(
                            'Raleway',
                            color: Colors.black,
                          ),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
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
                                      maxY: 20,
                                      barTouchData: BarTouchData(
                                        enabled: false,
                                        touchTooltipData: BarTouchTooltipData(
                                          tooltipBgColor: Colors.transparent,
                                          tooltipPadding:
                                              const EdgeInsets.all(0),
                                          tooltipBottomMargin: 8,
                                          getTooltipItem: (
                                            BarChartGroupData group,
                                            int groupIndex,
                                            BarChartRodData rod,
                                            int rodIndex,
                                          ) {
                                            return BarTooltipItem(
                                              rod.y.round().toString(),
                                              TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      titlesData: FlTitlesData(
                                        show: true,
                                        bottomTitles: SideTitles(
                                          showTitles: true,
                                          getTextStyles: (value) =>
                                              const TextStyle(
                                                  color: Color(0xff7589a2),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                          margin: 20,
                                          getTitles: (double value) {
                                            return state.players[value.toInt()]
                                                .getName();
                                          },
                                        ),
                                        leftTitles:
                                            SideTitles(showTitles: false),
                                      ),
                                      borderData: FlBorderData(
                                        show: false,
                                      ),
                                      barGroups: barGroup,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          Center(
                            child: RaisedButton(
                              splashColor: Colors.white,
                              elevation: 8.0,
                              child: Text(
                                "Ok",
                                style: GoogleFonts.getFont(
                                  'Raleway',
                                  color: Colors.white,
                                ),
                              ),
                              color: Theme.of(context).accentColor,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              onPressed: () {
                                Navigator.pushNamed(context, homeRoute);
                              },
                            ),
                          )
                        ],
                      );
                    },
                  );
                }
              });
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
                              height: MediaQuery.of(context).size.width / 7,
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                      text: "C'est à ",
                                      style: GoogleFonts.getFont('Raleway',
                                          color: Colors.white, fontSize: 22),
                                      children: [
                                        TextSpan(
                                          text: state.game.currentPlayer
                                              .getName(),
                                          style: GoogleFonts.getFont('Raleway',
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text: " de jouer",
                                          style: GoogleFonts.getFont('Raleway',
                                              color: Colors.white,
                                              fontSize: 22),
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
                              children: cards(state.game),
                            ),
                          )),
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
                  .add(CardRevealEvent(widget.card));
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
