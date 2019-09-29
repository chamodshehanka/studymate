class User {
  String _id;
  String _name;
  String _type;
  String _email;

  User(this._id, this._name, this._type, this._email);

  User.map(dynamic user) {
    this._id = user['id'];
    this._name = user['name'];
    this._type = user['type'];
    this._email = user['email'];
  }

  String get id => _id;
  String get name => _name;
  String get type => _type;
  String get email => _email;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['type'] = _type;
    map['email'] = _email;

    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._type = map['type'];
    this._email = map['email'];
  }
}
