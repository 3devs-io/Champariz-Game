import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  @override
  PlayerState get initialState => SelectNumberPlayer();

  @override
  Stream<PlayerState> mapEventToState(
    PlayerEvent event,
  ) async* {
    if (event is SelectedNumber) {
      yield* _mapLoadCartToState();
    }
  }

  Stream<PlayerState> _mapLoadCartToState() async* {
    yield SelectNumberPlayer();
    try {
      await Future.delayed(Duration(seconds: 1));
      yield InputNamesPlayer();
    } catch (_) {
      yield PlayerError();
    }
  }
}
