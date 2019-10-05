class Student {
  String _id;
  String _firstName;
  String _lastName;
  String _email;
  bool _schooling;
  String _schoolName;
  String _phoneNumber;
  String _birthday;

  Student(this._id, this._firstName, this._lastName,this._email, this._schooling,  this._phoneNumber,this._schoolName,
      this._birthday);

  Student.map(dynamic student) {
    this._id = student['id'];
    this._firstName = student['firstName'];
    this._lastName = student['lastName'];
    this._email = student['email'];
    this._schooling = student['schooling'];
    this._schoolName = student['schoolName'];
    this._phoneNumber = student['phoneNumber'];
    this._birthday = student['birthday'];
  }

  String get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
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
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['email'] = _email;
    map['schooling'] = _schooling;
    map['schoolName'] = _schoolName;
    map['phoneNumber'] = _phoneNumber;
    map['birthday'] = _birthday;

    return map;
  }

  Student.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._firstName = map['firstName'];
    this._lastName = map['lastName'];
    this._email = map['email'];
    this._schooling = map['schooling'];
    this._schoolName = map['schoolName'];
    this._phoneNumber = map['phoneNumber'];
    this._birthday = map['birthday'];
  }
}
