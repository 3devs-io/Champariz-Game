import 'package:champariz_game/game/models/game.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CardEvent extends Equatable {
  const CardEvent();
}

class ShowCard extends CardEvent {
  @override
  List<Object> get props => [];
}