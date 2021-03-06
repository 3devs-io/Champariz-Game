import 'package:equatable/equatable.dart';

class Card extends Equatable {
  final String imagePath;
  final String value;
  final String family;

  const Card({
    this.imagePath,
    this.value,
    this.family,
  });

  int valueToInt() {
    switch (value) {
      case "ace":
        return 1;
        break;
      case "2":
        return 2;
        break;
      case "3":
        return 3;
        break;
      case "4":
        return 4;
        break;
      case "5":
        return 5;
        break;
      case "6":
        return 6;
        break;
      case "7":
        return 7;
        break;
      case "8":
        return 8;
        break;
      case "9":
        return 9;
        break;
      case "10":
        return 10;
        break;
      case "jack":
        return 11;
        break;
      case "queen":
        return 12;
        break;
      case "king":
        return 13;
        break;
      default:
        return 0;
        break;
    }
  }

  bool isSeven() {
    return value == "7";
  }

  bool pair(Card card) {
    return value == card.value;
  }

  bool sameFamily(Card card) {
    return family == card.family;
  }

  @override
  List<Object> get props => [value, family];
}

class Deck {
  List<Card> _cards = [];

  Deck() {
    final List<String> listeFamille = [];
    listeFamille.add("clubs");
    listeFamille.add("diamonds");
    listeFamille.add("hearts");
    listeFamille.add("spades");
    for (final String family in listeFamille) {
      _cards.add(Card(
          imagePath: "assets/ace_of_$family.png",
          value: "ace",
          family: family));
      _cards.add(Card(
          imagePath: "assets/2_of_$family.png", value: "2", family: family));
      _cards.add(Card(
          imagePath: "assets/3_of_$family.png", value: "3", family: family));
      _cards.add(Card(
          imagePath: "assets/4_of_$family.png", value: "4", family: family));
      _cards.add(Card(
          imagePath: "assets/5_of_$family.png", value: "5", family: family));
      _cards.add(Card(
          imagePath: "assets/6_of_$family.png", value: "6", family: family));
      _cards.add(Card(
          imagePath: "assets/7_of_$family.png", value: "7", family: family));
      _cards.add(Card(
          imagePath: "assets/8_of_$family.png", value: "8", family: family));
      _cards.add(Card(
          imagePath: "assets/9_of_$family.png", value: "9", family: family));
      _cards.add(Card(
          imagePath: "assets/10_of_$family.png", value: "10", family: family));
      _cards.add(Card(
          imagePath: "assets/jack_of_$family.png",
          value: "jack",
          family: family));
      _cards.add(Card(
          imagePath: "assets/queen_of_$family.png",
          value: "queen",
          family: family));
      _cards.add(Card(
          imagePath: "assets/king_of_$family.png",
          value: "king",
          family: family));
    }

    _cards.shuffle();
  }

  Deck.fromCards(List<Card> test) {
    _cards = List<Card>.from(test);
  }

  void shuffle() {
    _cards.shuffle();
  }

  List<Card> getCards() {
    return List.from(_cards);
  }

  void remove(Card cardToRemove) {
    _cards.remove(cardToRemove);
  }
}
