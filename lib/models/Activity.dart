class Activity {
  String _id;
  String _name;
  String _type;

  Activity(this._id, this._name, this._type);

  Activity.map(dynamic activity) {
    this._id = activity['id'];
    this._name = activity['name'];
    this._type = activity['type'];
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

  Activity.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._type = map['type'];
  }
}
