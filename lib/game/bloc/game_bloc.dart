import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:champariz_game/game/models/card.dart';
import 'package:champariz_game/game/models/game.dart';
import './bloc.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  @override
  GameBloc() : super(UnloadedGame());

  Game game;

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    if (event is LoadGameEvent) {
      yield* _mapInit(event.game);
    }
    if (event is CardRevealEvent) {
      yield* _cardReveal(event.tapped);
    }
  }

  Stream<GameState> _mapInit(Game game) async* {
    this.game = game;
    game.initGame();
    yield PlayingState(game.currentPlayer, game.deck.getCards());
  }

  Stream<GameState> _cardReveal(Card card) async* {
    game.play(card);
    if (card.isSeven()) {
      //Send State
    } else {
      if (game.isLastCardNotNull()) {
        //Send State
        if (game.lastCardPlayed.pair(card)) {
          yield GiveDrinkState(
              game.currentPlayer.getName(), card.valueToInt().toString());
        } else {
          if (game.lastCardPlayed.sameFamily(card)) {
            yield const EveryoneDrinkState();
          } else {
            yield DrinkState(
                game.currentPlayer.getName(),
                sqrt((game.lastCardPlayed.valueToInt() - card.valueToInt()) *
                        (game.lastCardPlayed.valueToInt() - card.valueToInt()))
                    .toInt()
                    .toString());
          }
        }
      }
    }
  }
}
