class Admin {
  String _id;
  String _name;
  String _email;
  String _contactNo;
  String _workPlace;

  Admin(this._id, this._name, this._email, this._contactNo, this._workPlace);

  Admin.map(dynamic admin) {
    this._id = admin['id'];
    this._name = admin['name'];
    this._email = admin['email'];
    this._contactNo = admin['contactNo'];
    this._workPlace = admin['workPlace'];
  }

  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get contactNo => _contactNo;
  String get workPlace => _workPlace;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['email'] = _email;
    map['contactNo'] = _contactNo;
    map['workPlace'] = _workPlace;
    return map;
  }

  Admin.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._email = map['email'];
    this._contactNo = map['contactNo'];
    this._workPlace = map['workPalce'];
  }
}
