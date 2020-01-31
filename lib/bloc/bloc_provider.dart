import 'package:champariz_game/bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class BloCProvider<T extends BloC> extends StatefulWidget {
  //BloC
  final T bloc;
  //Widgets appartenants au BloC
  final Widget child;
  //Constructeur
  BloCProvider({@required this.bloc, @required this.child});
  //Valeur du type
  static Type _providerType<T>() => T;
  //Configurer le BloC
  static T of<T extends BloC>(BuildContext context) {
    final type = _providerType<BloCProvider<T>>();
    final BloCProvider provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }
  //On récupère le BloC présent plus haut dans l'arborescence des Widgets (dans le context)

  State createState() => _BloCProviderState();
}

class _BloCProviderState extends State<BloCProvider> {

  //ON retourne le Widget associé au BloC
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  //Fermeture des ressources utilisées par le BloC
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
