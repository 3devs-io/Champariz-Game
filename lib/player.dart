class Player {
  String _nom;
  int _nbGorgees;
  int _culSec;

  Player(String nom) {
    this._nom = nom;
    this._nbGorgees = 0;
    this._culSec = 0;
  }

  addGorgee() {
    _nbGorgees++;
  }

  addCulSec() {
    _culSec++;
  }

  String getName() {
    return _nom;
  }
}
