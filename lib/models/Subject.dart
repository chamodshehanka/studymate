class Subject {
  String _id;
  String _name;
  String _type;

  Subject(this._id, this._name, this._type);

  Subject.map(dynamic subject) {
    this._id = subject['id'];
    this._name = subject['name'];
    this._type = subject['type'];
  }

  String get id => _id;
  String get name => _name;
  String get type => _type;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['type'] = _type;

    return map;
  }

  Subject.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._type = map['type'];
  }
}
