import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:champariz_game/game/models/card.dart';
import 'package:champariz_game/game/models/game.dart';
import 'package:champariz_game/player/models/player.dart';
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
    if (event is GaveDrinkEvent) {
      yield* _gaveDrink(event.player, event.sips);
    }
    if (event is DrankEvent) {
      yield* _drank(event.playersList, event.sips);
    }
  }

  Stream<GameState> _mapInit(Game game) async* {
    this.game = game;
    game.initGame();
    yield PlayingState(game.currentPlayer, game.deck.getCards());
  }

  Stream<GameState> _cardReveal(Card card) async* {
    if (card.isSeven()) {
      yield FinishDrinkState(game.currentPlayer);
    } else {
      if (game.isLastCardNotNull()) {
        if (game.lastCardPlayed.pair(card)) {
          yield GiveDrinkState(game.currentPlayer, card.valueToInt());
        } else {
          if (game.lastCardPlayed.sameFamily(card)) {
            yield EveryoneDrinkState(List.from(game.playerList));
          } else {
            yield DrinkState(
                game.currentPlayer,
                sqrt((game.lastCardPlayed.valueToInt() - card.valueToInt()) *
                        (game.lastCardPlayed.valueToInt() - card.valueToInt()))
                    .toInt());
          }
        }
      }
    }
    game.play(card);
  }

  Stream<GameState> _gaveDrink(Player player, int sips) async* {
    yield DrinkState(player, sips);
  }

  Stream<GameState> _drank(List<Player> playerList, int sips) async* {
    for (final Player player in playerList) {
      player.drink(sips);
    }
    if (game.isGameEnded()) {
      yield StatsState(List.from(game.playerList));
    } else {
      yield PlayingState(game.currentPlayer, game.deck.getCards());
    }
  }

  @override
  void onTransition(Transition<GameEvent, GameState> transition) {
    print(transition);
    super.onTransition(transition);
  }
}
