import 'package:champariz_game/game/models/card.dart';
import 'package:champariz_game/player/models/player.dart';
import 'package:champariz_game/game/models/card.dart' as cards;

class Game {
  int numberOfPlayers;
  List<Player> playerList;
  Deck deck;
  Player currentPlayer;
  Deck actualDeck;
  cards.Card lastCardPlayed;

  Game(int numberOfPlayers) {
    numberOfPlayers = numberOfPlayers;
    playerList = [];
    deck = Deck();
    actualDeck = Deck.fromCards(deck.cards);
  }

  void addPlayer(Player playerToAdd) {
    playerList.add(playerToAdd);
  }

  void initGame() {
    currentPlayer = playerList[0]; //Setting up first player
    deck.cards.shuffle(); //Randomizing cards
  }

  void nextPlayer() {
    final int index = playerList.indexOf(currentPlayer);
    if (index == playerList.length - 1) {
      currentPlayer = playerList[0];
    } else {
      currentPlayer = playerList[index + 1];
    }
  }

  void play(cards.Card cardToRemove, {bool rememberLastCard}) {
    actualDeck.cards.remove(cardToRemove);
    if (rememberLastCard) {
      lastCardPlayed = null;
    } else {
      lastCardPlayed = cardToRemove;
    }
  }
}
