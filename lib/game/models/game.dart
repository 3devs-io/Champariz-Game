import 'package:champariz_game/card.dart';
import 'package:champariz_game/player.dart';

class Game {
  List<Player> playerList;
  Deck deck;
  Player currentPlayer;

  Game(List<Player> playerList) {
    this.playerList = playerList;
    this.deck = Deck();
  }
}
