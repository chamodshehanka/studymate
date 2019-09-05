class Student {
  String _id;
  String _name;
  String _patientId;
  DateTime _date;
  String _schoolName;
  int _grade;
  String _address;
  String _email;
  int _phone;
  double _iQLevel;

  Student(this._id, this._name, this._patientId, this._date, this._grade,
      this._address, this._email, this._phone, this._iQLevel);

  Student.map(dynamic student) {
    this._id = student['id'];
    this._name = student['name'];
    this._patientId = student['patientId'];
    this._date = student['date'];
    this._schoolName = student['schoolName'];
    this._grade = student['grade'];
    this._address = student['address'];
    this._email = student['email'];
    this._phone = student['phone'];
    this._iQLevel = student['iQLevel'];
  }

  String get id => _id;
  String get name => _name;
  String get patientId => _patientId;
  DateTime get date => _date;
  String get schoolName => _schoolName;
  int get grade => _grade;
  String get address => _address;
  String get email => _email;
  int get phone => _phone;
  double get iQLevel => _iQLevel;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['patientId'] = _patientId;
    map['date'] = _date;
    map['schoolName'] = _schoolName;
    map['grade'] = _grade;
    map['address'] = _address;
    map['email'] = _email;
    map['phone'] = _phone;
    map['iQLevel'] = _iQLevel;

    return map;
  }

  Student.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._patientId = map['patientId'];
    this._date = map['date'];
    this._schoolName = map['schoolName'];
    this._grade = map['grade'];
    this._address = map['address'];
    this._email = map['email'];
    this._phone = map['phone'];
    this._iQLevel = map['iQLevel'];
  }
}
