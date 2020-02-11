import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:champariz_game/game/models/game.dart';
import './bloc.dart';
import 'package:champariz_game/game/models/card.dart' as cards;

class GameBloc extends Bloc<GameEvent, GameState> {
  @override
  GameState get initialState => UnloadedGame();

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
      bool last = false;
      if (card.isSeven()) {
        last = true;
        yield DrinkingGame("cul sec", game.currentPlayer);
      } else {
        if ((game.lastCardPlayed != null)) {
          if (game.lastCardPlayed.pair(card)) {
            last = true;
            yield DrinkingGame("une paire", game.currentPlayer);
          } else {
            if (game.lastCardPlayed.sameFamily(card)) {
              last = true;
              yield DrinkingGame("une famille", game.currentPlayer);
            } else {
              last = true;
              yield DrinkingGame(
                  "un montant qu'il est encore nécessaire de calculer",
                  game.currentPlayer);
            }
          }
        }
      }

      print(last.toString());
      game.nextPlayer();
      game.play(card, last);
      yield LoadingGame(game);
    } catch (_) {
      print(_);
      yield GameError();
    }
  }
}
