class Player {
  String _nom;
  int _nbGorgees;

  Player(String nom) {
    _nom = nom;
    _nbGorgees = 0;
  }

  String getName() {
    return _nom;
  }

  void drink(int sips) {
    _nbGorgees = _nbGorgees + sips;
  }

  int getNbGorgees() {
    return _nbGorgees;
  }
}
