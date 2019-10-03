class PreferredActivity {
  String _name;
  int _totalHours;

  PreferredActivity(this._name, this._totalHours);

  PreferredActivity.map(dynamic preferredActivity) {
    this._name = preferredActivity['name'];
    this._totalHours = preferredActivity['totalHours'];
  }

  String get name => _name;
  int get totalHours => _totalHours;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_name != null) map['name'] = _name;
    map['totalHours'] = _totalHours;

    return map;
  }

  PreferredActivity.fromMap(Map<String, dynamic> map) {
    this._name = map['name'];
    this._totalHours = map['totalHours'];
  }
}
