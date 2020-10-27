import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:champariz_game/game/models/game.dart';
import './bloc.dart';
import 'package:champariz_game/game/models/card.dart' as cards;

class GameBloc extends Bloc<GameEvent, GameState> {
  @override
  GameBloc() : super(UnloadedGame());

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    if (event is GameLoading) {
      yield* _mapInit(event.game);
    }
    if (event is CardTappedGame) {
      yield* _mapCardTapped(event.game, event.tapped);
    }
  }

  Stream<GameState> _mapInit(Game game) async* {
    game.initGame();
    yield LoadingGame(game);
    try {
      yield LoadingGame(game);
    } catch (_) {
      yield GameError();
    }
  }

  Stream<GameState> _mapCardTapped(Game game, cards.Card card) async* {
    yield GameError(); //Yield GameError to change the old state, preventing from sending the same state twice
    try {
      bool isFinished = game.actualDeck.cards.length == 1;
      bool isFinishedAndSupported = false;
      bool last = false;
      if (card.isSeven()) {
        last = true;
        game.currentPlayer.drink(10);
        yield FinishDrinkState(game.currentPlayer);
        yield DrinkingGame(game.currentPlayer,
            isFinished); //game.currentPlayer.getName() + ", prends cul sec",
        isFinished
            ? isFinishedAndSupported = true
            : isFinishedAndSupported = false;
      } else {
        if ((game.lastCardPlayed != null)) {
          if (game.lastCardPlayed.pair(card)) {
            last = true;
            yield GiveDrinkState(
                game.playerList, game.currentPlayer, card.valueToInt());
            game.nextPlayer();
            yield DrinkingGame(game.currentPlayer, isFinished);
            /*  game.currentPlayer.getName() +
                    ", distribue " +
                    card.valueToInt().toString() +
                    " gorgées",*/
            isFinished
                ? isFinishedAndSupported = true
                : isFinishedAndSupported = false;
          } else {
            if (game.lastCardPlayed.sameFamily(card)) {
              last = true;
              yield EveryoneDrinkState();
              game.playerList.forEach((element) {
                element.drink(3);
              });
              game.nextPlayer();
              /* "Vous buvez tous 3 gorgées ! "*/
              yield DrinkingGame(game.currentPlayer, isFinished);
              isFinished
                  ? isFinishedAndSupported = true
                  : isFinishedAndSupported = false;
            } else {
              last = true;
              yield SoloDrinkState(
                  game.currentPlayer,
                  sqrt((game.lastCardPlayed.valueToInt() - card.valueToInt()) *
                          (game.lastCardPlayed.valueToInt() -
                              card.valueToInt()))
                      .toInt());
              game.currentPlayer.drink(sqrt((game.lastCardPlayed.valueToInt() -
                          card.valueToInt()) *
                      (game.lastCardPlayed.valueToInt() - card.valueToInt()))
                  .toInt());
              game.nextPlayer();
              yield DrinkingGame(game.currentPlayer, isFinished);
              isFinished
                  ? isFinishedAndSupported = true
                  : isFinishedAndSupported = false;
            }
          }
        }
      }

      game.play(card, last);
      if (isFinished && !isFinishedAndSupported) {
        yield EndedGame(game.playerList);
      }
      yield LoadingGame(game);
    } catch (_) {
      print(_);
      yield GameError();
    }
  }
}
