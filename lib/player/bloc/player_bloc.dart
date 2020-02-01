import 'dart:async';
import 'package:bloc/bloc.dart';
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
  }

  Stream<PlayerState> _selectNamesOfPlayers(int numberOfPlayer) async* {
    yield SelectingNumberPlayers();
    try {
      yield InputNamesPlayer(numberOfPlayer);
    } catch (_) {
      yield PlayerError();
    }
  }
}
