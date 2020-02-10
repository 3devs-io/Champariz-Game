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
      game.play(card);
      if (card.isSeven()) {
        //Faire boire cul sec au joueur actuel
        yield DrinkingGame("Cul sec", game.currentPlayer);
        game.nextPlayer();
      } else {
        if (game.lastCardPlayed.pair(card)) {
          yield DrinkingGame(card.value, game.currentPlayer);
          game.nextPlayer();
        } else {
          if (game.lastCardPlayed.sameFamily(card)) {
            yield DrinkingGame("3", game.currentPlayer);
            game.nextPlayer();
          }
        }
      }

      yield LoadingGame(game);
    } catch (_) {
      yield GameError();
    }
  }
}
