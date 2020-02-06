import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:champariz_game/game/models/game.dart';
import './bloc.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  @override
  GameState get initialState => GameLoaded();

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    if (event is Init) {
      yield* _mapInit(event.game);
    }
    if (event is LoadGame) {
      yield* _mapLoadCartToState();
    }
  }

  Stream<GameState> _mapInit(Game game) async* {
    yield GameLoading(game);
    try {
      yield GameLoading(game);
    } catch (_) {
      yield GameError();
    }
  }

  Stream<GameState> _mapLoadCartToState() async* {
    try {
      await Future.delayed(Duration(seconds: 1));
      yield GameLoaded();
    } catch (_) {
      yield GameError();
    }
  }
}
