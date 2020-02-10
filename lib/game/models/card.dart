import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Card extends Equatable {
  String imagePath;
  String value;
  String family;

  Card({
    this.imagePath,
    this.value,
    this.family,
  });

  Widget toWidget() {
    return Padding(
      child: Image.asset(
        this.imagePath,
        width: 100,
        height: 50,
      ),
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
    );
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
  List<Card> cards = List<Card>();

  Deck.fromCards(List<Card> test) {
    cards = List<Card>.from(test);
  }

  Deck() {
    List<String> listeFamille = List<String>();
    listeFamille.add("clubs");
    listeFamille.add("diamonds");
    listeFamille.add("hearts");
    listeFamille.add("spades");

    listeFamille.forEach((String family) {
      cards.add(Card(
          imagePath: "assets/" + "ace_of_" + family + ".png",
          value: "ace",
          family: family));
      cards.add(Card(
          imagePath: "assets/" + "2_of_" + family + ".png",
          value: "2",
          family: family));
      cards.add(Card(
          imagePath: "assets/" + "3_of_" + family + ".png",
          value: "3",
          family: family));
      cards.add(Card(
          imagePath: "assets/" + "4_of_" + family + ".png",
          value: "4",
          family: family));
      cards.add(Card(
          imagePath: "assets/" + "5_of_" + family + ".png",
          value: "5",
          family: family));
      cards.add(Card(
          imagePath: "assets/" + "6_of_" + family + ".png",
          value: "6",
          family: family));
      cards.add(Card(
          imagePath: "assets/" + "7_of_" + family + ".png",
          value: "7",
          family: family));
      cards.add(Card(
          imagePath: "assets/" + "8_of_" + family + ".png",
          value: "8",
          family: family));
      cards.add(Card(
          imagePath: "assets/" + "9_of_" + family + ".png",
          value: "9",
          family: family));
      cards.add(Card(
          imagePath: "assets/" + "10_of_" + family + ".png",
          value: "10",
          family: family));
      cards.add(Card(
          imagePath: "assets/" + "jack_of_" + family + ".png",
          value: "jack",
          family: family));
      cards.add(Card(
          imagePath: "assets/" + "queen_of_" + family + ".png",
          value: "queen",
          family: family));
      cards.add(Card(
          imagePath: "assets/" + "king_of_" + family + ".png",
          value: "king",
          family: family));
    });

    cards.shuffle();
  }
}
