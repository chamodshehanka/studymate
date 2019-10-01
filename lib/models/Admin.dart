class Admin {
  String _id;
  String _firstName;
  String _lastName;
  String _email;
  String _contactNo;
  String _workPlace;

  Admin(this._id, this._firstName, this._lastName, this._email, this._contactNo, this._workPlace);

  Admin.map(dynamic admin) {
    this._id = admin['id'];
    this._firstName = admin['firstName'];
    this._lastName = admin['lastName'];
    this._email = admin['email'];
    this._contactNo = admin['contactNo'];
    this._workPlace = admin['workPlace'];
  }

  String get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get contactNo => _contactNo;
  String get workPlace => _workPlace;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['email'] = _email;
    map['contactNo'] = _contactNo;
    map['workPlace'] = _workPlace;
    return map;
  }

  Admin.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._firstName = map['firstName'];
    this._lastName = map['lastName'];
    this._email = map['email'];
    this._contactNo = map['contactNo'];
    this._workPlace = map['workPalce'];
  }
}
