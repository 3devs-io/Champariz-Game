import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  @override
  GameState get initialState => GameLoading();

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    if (event is LoadGame) {
      yield* _mapLoadCartToState();
    }
  }

  Stream<GameState> _mapLoadCartToState() async* {
    yield GameLoading();
    try {
      await Future.delayed(Duration(seconds: 1));
      yield GameLoaded();
    } catch (_) {
      yield GameError();
    }
  }
}
