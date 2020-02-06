import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:champariz_game/game/models/game.dart';
import './bloc.dart';

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
    if (event is LoadedGame) {
      yield* _mapLoadCartToState();
    }
  }

  Stream<GameState> _mapInit(Game game) async* {
    yield LoadingGame(game);
    try {
      yield LoadingGame(game);
    } catch (_) {
      yield GameError();
    }
  }

  Stream<GameState> _mapLoadCartToState() async* {
    try {
      yield LoadedGame();
    } catch (_) {
      yield GameError();
    }
  }
}
