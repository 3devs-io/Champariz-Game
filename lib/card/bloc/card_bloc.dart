import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:champariz_game/game/models/game.dart';
import './bloc.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  @override
  CardState get initialState => HiddenCard();

  @override
  Stream<CardState> mapEventToState(
    CardEvent event,
  ) async* {}
}
