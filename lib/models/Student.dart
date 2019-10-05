class Student {
  String _id;
  String _name;
  String _email;
  bool _schooling;
  String _schoolName;
  String _phoneNumber;
  String _birthday;

  Student(this._id, this._name, this._email, this._schooling, this._schoolName,
      this._phoneNumber, this._birthday);

  Student.map(dynamic student) {
    this._id = student['id'];
    this._name = student['name'];
    this._email = student['email'];
    this._schooling = student['schooling'];
    this._schoolName = student['schoolName'];
    this._phoneNumber = student['phoneNumber'];
    this._birthday = student['birthday'];
  }

  String get id => _id;
  String get name => _name;
  String get email => _email;
  bool get schooling => _schooling;
  String get schoolName => _schoolName;
  String get phoneNumber => _phoneNumber;
  String get birthday => _birthday;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['email'] = _email;
    map['schooling'] = _schooling;
    map['schoolName'] = _schoolName;
    map['phoneNumber'] = _phoneNumber;
    map['birthday'] = _birthday;

    return map;
  }

  Student.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._email = map['email'];
    this._schooling = map['schooling'];
    this._schoolName = map['schoolName'];
    this._phoneNumber = map['phoneNumber'];
    this._birthday = map['birthday'];
  }
}
