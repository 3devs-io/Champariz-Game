import 'package:champariz_game/game/bloc/bloc.dart';
import 'package:champariz_game/player/bloc/bloc.dart';
import 'package:champariz_game/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentValue = 5;
  final TextEditingController _textEditingController = TextEditingController();

  void _submit() {
    BlocProvider.of<PlayerBloc>(context)
        .add(SelectName(_textEditingController.value.text.toString()));
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _formKey = GlobalKey<FormState>();
    return BlocListener<PlayerBloc, PlayerState>(
      listener: (context, state) {
        if (state is GameStart) {
          BlocProvider.of<GameBloc>(context).add(LoadGameEvent(state.game));
          BlocProvider.of<PlayerBloc>(context).add(const NewGame());

          Navigator.pushNamed(context, gameViewRoute);
        }
      },
      child: WillPopScope(
          onWillPop: () => Future.value(false),
          child: Scaffold(
              resizeToAvoidBottomPadding: false,
              backgroundColor: Theme.of(context).primaryColor,
              body: SafeArea(child: BlocBuilder<PlayerBloc, PlayerState>(
                  builder: (context, state) {
                if (state is InputNamesPlayer) {
                  final List<Widget> names = [];
                  for (final player in state.game.playerList) {
                    names.add(Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          player.getName(),
                          style: GoogleFonts.getFont(
                            'Raleway',
                            color: Colors.white,
                          ),
                        )));
                  }
                  return Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: mediaQuery.size.height / 20,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          radius: 50.0,
                          child: const Image(
                            image: AssetImage('assets/logo.png'),
                            width: 75.0,
                          ),
                        ),
                        SizedBox(
                          height: mediaQuery.size.height / 40,
                        ),
                        Text(
                          "Entrez le nom des différents joueurs",
                          style: GoogleFonts.getFont('Raleway',
                              color: Colors.white, fontSize: 22.5),
                        ),
                        SizedBox(
                          height: mediaQuery.size.height / 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: _textEditingController,
                              validator: (submitted) {
                                return submitted.isEmpty
                                    ? 'Veuillez rentrer un prénom'
                                    : null;
                              },
                              textInputAction: TextInputAction.send,
                              decoration: const InputDecoration.collapsed(
                                hintText: "Entrez un nom",
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: RaisedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _submit();
                              }
                            },
                            child: const Text(
                              'Sélectionner',
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            children: names,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (state is SelectingNumberPlayers) {
                  return Stack(children: [
                    Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: mediaQuery.size.height / 10,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.grey[100],
                            radius: 50.0,
                            child: const Image(
                              image: AssetImage('assets/logo.png'),
                              width: 75.0,
                            ),
                          ),
                          SizedBox(
                            height: mediaQuery.size.height / 30,
                          ),
                          Text(
                            "Jouer à Champariz",
                            style: GoogleFonts.getFont('Raleway',
                                color: Colors.white, fontSize: 22.5),
                          ),
                          SizedBox(
                            height: mediaQuery.size.height / 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Icon(Icons.people),
                              SizedBox(
                                width: mediaQuery.size.width / 30,
                              ),
                              Text(
                                "Nombre de joueurs",
                                style: GoogleFonts.getFont('Raleway',
                                    color: Colors.white, fontSize: 12.5),
                              ),
                            ],
                          ),
                          NumberPicker.integer(
                              initialValue: _currentValue,
                              minValue: 3,
                              maxValue: 20,
                              onChanged: (newValue) => setState(
                                  () => _currentValue = newValue.toInt())),
                          RaisedButton(
                            onPressed: () {
                              BlocProvider.of<PlayerBloc>(context)
                                  .add(SelectedNumber(_currentValue));
                            },
                            splashColor: Colors.white,
                            elevation: 8.0,
                            color: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Text(
                              "Jouer",
                              style: GoogleFonts.getFont(
                                'Raleway',
                                color: Colors.white,
                              ),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Règles de Champariz'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                              " - Cartes de la même famille : Tous les joueurs boivent 3 gorgées"),
                                          Text(
                                              " - Paire : Le joueur distribue une quantité de gorgée égale à la valeur des cartes retournées"),
                                          Text(
                                            "- 7 : cul sec",
                                          ),
                                          Text(
                                              "- Aucune des règles ci dessus : Le joueur boit une quantité de gorgée égale à la soustraction des valeurs des deux cartes retournées"),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        Material(
                                          elevation: 5.0,
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          color: const Color(0xff4da1a9),
                                          child: MaterialButton(
                                            minWidth: 50,
                                            //padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Ok",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.getFont(
                                                'Raleway',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            splashColor: Colors.white,
                            elevation: 8.0,
                            color: Theme.of(context).accentColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Text(
                              "Règles",
                              style: GoogleFonts.getFont(
                                'Raleway',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 0,
                      child: Ink(
                          decoration: const ShapeDecoration(
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            iconSize: 20,
                            onPressed: () {
                              showAboutDialog(
                                  applicationLegalese: 'GPL-3.0 License',
                                  context: context,
                                  applicationName: "Champariz",
                                  applicationVersion: "1.0.0",
                                  applicationIcon: const Image(
                                      image: AssetImage('assets/logo.png')),
                                  children: [
                                    Text(
                                      "Cette application est développée par ",
                                      style: GoogleFonts.getFont(
                                        'Raleway',
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          launch("https://github.com/3devs-io");
                                        },
                                        child: Text(
                                          "3devs.io",
                                          style: GoogleFonts.getFont(
                                            'Raleway',
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ))
                                  ]);
                            },
                            icon: const Icon(
                              Icons.info,
                              size: 40,
                              color: Color(0xff4da1a9),
                            ),
                          )),
                    ),
                  ]);
                }
                return Text(
                  'Something went wrong!',
                  style: GoogleFonts.getFont(
                    'Raleway',
                    color: Colors.white,
                  ),
                );
              })))),
    );
  }
}
