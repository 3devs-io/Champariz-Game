import 'package:champariz_game/player/bloc/bloc.dart';
import 'package:champariz_game/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentValue = 5;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: SafeArea(child:
                BlocBuilder<PlayerBloc, PlayerState>(builder: (context, state) {
              if (state is InputNamesPlayer) {
                return Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: mediaQuery.size.height / 10,
                      ),
                      FlutterLogo(
                        size: 250,
                      ),
                      SizedBox(
                        height: mediaQuery.size.height / 30,
                      ),
                      Text(
                        "Entrez le nom des différents joueurs",
                        style: TextStyle(fontSize: 22.5),
                      ),
                      SizedBox(
                        height: mediaQuery.size.height / 30,
                      ),
                    ],
                  ),
                );
              }

              if (state is SelectingNumberPlayers) {
                return Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: mediaQuery.size.height / 10,
                      ),
                      FlutterLogo(
                        size: 250,
                      ),
                      SizedBox(
                        height: mediaQuery.size.height / 30,
                      ),
                      Text(
                        "Jouer à Champariz",
                        style: TextStyle(fontSize: 22.5),
                      ),
                      SizedBox(
                        height: mediaQuery.size.height / 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.people),
                          SizedBox(
                            width: mediaQuery.size.width / 30,
                          ),
                          Text(
                            "Nombre de joueurs",
                            style: TextStyle(fontSize: 12.5),
                          ),
                        ],
                      ),
                      NumberPicker.integer(
                          initialValue: _currentValue,
                          minValue: 3,
                          maxValue: 20,
                          onChanged: (newValue) =>
                              setState(() => _currentValue = newValue)),
                      RaisedButton(
                        onPressed: () {
                          BlocProvider.of<PlayerBloc>(context)
                              .add(SelectedNumber(_currentValue));
                        },
                        splashColor: Colors.white,
                        elevation: 8.0,
                        child: Text("Jouer"),
                        color: Theme.of(context).accentColor,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                      ),
                    ],
                  ),
                );
              }
            }))));
  }
}
