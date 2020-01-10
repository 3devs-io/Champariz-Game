import 'package:flutter/material.dart';
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
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
            child: Center(
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
                onPressed: () {print(_currentValue);},
                splashColor: Colors.white,
                elevation: 8.0,
                child: Text("Jouer"),
                color: Theme.of(context).accentColor,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
              ),
            ],
          ),
        )));
  }
}
