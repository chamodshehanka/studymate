class PreferredSubject {
  String _name;
  int _totalHours;

  PreferredSubject(this._name, this._totalHours);

  PreferredSubject.map(dynamic preferredSubject) {
    this._name = preferredSubject['name'];
    this._totalHours = preferredSubject['totalHours'];
  }

  String get name => _name;
  int get totalHours => _totalHours;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_name != null) map['name'] = _name;
    map['totalHours'] = _totalHours;

    return map;
  }

  PreferredSubject.fromMap(Map<String, dynamic> map) {
    this._name = map['name'];
    this._totalHours = map['totalHours'];
  }
}
