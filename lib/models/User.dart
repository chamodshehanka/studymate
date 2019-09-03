class User {
  String _id;
  String _type;
  String _userName;
  String _email;
  String _password;

  User(this._id, this._type, this._userName, this._email, this._password);

  User.map(dynamic user) {
    this._id = user['id'];
    this._type = user['type'];
    this._userName = user['userName'];
    this._password = user['password'];
  }

  String get id => _id;
  String get type => _type;
  String get userName => _userName;
  String get email => _email;
  String get password => _password;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['type'] = _type;
    map['userName'] = _userName;
    map['email'] = _email;
    map['password'] = _password;

    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._type = map['type'];
    this._userName = map['userName'];
    this._password = map['password'];
  }
}
