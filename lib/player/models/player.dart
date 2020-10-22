class Player {
  String _nom;
  int _nbGorgees;
  int _nbCulsSecs;

  Player(String nom) {
    this._nom = nom;
    this._nbGorgees = 0;
    this._nbCulsSecs = 0;
  }

  String getName() {
    return _nom;
  }

  void drink(int sips) {
    _nbGorgees = _nbGorgees + sips;
  }

  void drinkFinish() {
    _nbCulsSecs++;
  }

  int getNbGorgees() {
    return _nbGorgees;
  }

  int getNbCulsSecs() {
    return _nbCulsSecs;
  }
}
