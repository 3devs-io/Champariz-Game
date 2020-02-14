import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:champariz_game/game/models/game.dart';
import 'package:champariz_game/player/models/player.dart';
import './bloc.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  @override
  PlayerState get initialState => SelectingNumberPlayers();

  @override
  Stream<PlayerState> mapEventToState(
    PlayerEvent event,
  ) async* {
    if (event is SelectedNumber) {
      yield* _selectNamesOfPlayers(event.number);
    }
    if (event is SelectName) {
      yield* _selectedNameOfPlayer(event.name);
    }
    if (event is NewGame) {
      yield* _newGame();
    }
  }

  Stream<PlayerState> _selectNamesOfPlayers(int numberOfPlayer) async* {
    yield SelectingNumberPlayers();
    try {
      Game game = new Game(numberOfPlayer);
      yield InputNamesPlayer(game);
    } catch (_) {
      yield PlayerError();
    }
  }

  Stream<PlayerState> _newGame() async* {
    yield PlayerError();
    print("NEW GAME");
    try {
      yield SelectingNumberPlayers();
    } catch (_) {
      print(_);
      yield PlayerError();
    }
  }

  Stream<PlayerState> _selectedNameOfPlayer(String name) async* {
    yield SelectingNumberPlayers();
    try {
      final InputNamesPlayer currentState = state;
      Game currentGame = currentState.game;
      currentGame.addPlayer(Player(name));
      if (currentGame.numberOfPlayers == currentGame.playerList.length) {
        yield GameStart(currentGame);
      } else {
        yield InputNamesPlayer(currentGame);
      }
    } catch (_) {
      yield PlayerError();
    }
  }
}
