import 'dart:async';
import 'package:champariz_game/bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//TODO : Need to implement this class to talk with the databse and run the game

class CounterBloc extends BloC {
  //Valeur de début
  int _counter = 0;
  DatabaseReference _gamesRef;

  //Constructeur de la classe
  CounterBloc() {
    //Ici nous pouvons effectuer toutes les actions qui permettent de données la valeur par défaut de nos attributs
    //Appels d'API, appels de bases de données... etc.
    sink.add(_counter);

    _gamesRef = FirebaseDatabase.instance.reference().child('games');
    //Ici on donne juste la valeur du début de notre compteur
    _gamesRef.reference().child('counter').once().then((DataSnapshot snapshot) {
      print('Connected to second database and read ${snapshot.value}');
      //Ici on donne juste la valeur du début de notre compteur
    });
  }
  //Notre StreamController, c'est lui qui permet la communication entre l'interface et le BloC
  final _streamController = StreamController<int>();

  //Les entrées et les sorties doivent correspondrent au type donné par le StreamController

  //Entrées
  Sink<int> get sink {
    return _streamController.sink;
  }

  //Sorties
  Stream<int> get stream {
    return _streamController.stream;
  }

  //Logique de travail
  incrementCounter() {
    _counter++;
    sink.add(_counter);
  }

  //Fermeture : on nettoie tout, fermeture de notre stream, mais aussi de nos ouvertures de bases de données ou autres
  @override
  dispose() {
    _streamController.close();
  }
}

class Interface extends StatelessWidget {
  final String title;
  final CounterBloc counterBloc = CounterBloc();
  Interface({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: StreamBuilder(
        stream: counterBloc.stream,
        builder: (context, snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Vous avez appuyé sur ce bouton :'),
                Text("${snapshot.data}"),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          counterBloc.incrementCounter();
        },
      ),
    );
  }
}
