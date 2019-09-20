class Student {
  String _id;
  String _name;
  String _email;
  String _password;
  bool _schooling;
  String _schoolName;
  String _phoneNumber;
  List _preferedActivitiesList;

  Student(this._id, this._name, this._email, this._password, this._schooling,
      this._schoolName, this._phoneNumber, this._preferedActivitiesList);

  Student.map(dynamic student) {
    this._id = student['id'];
    this._name = student['name'];
    this._email = student['email'];
    this._password = student['password'];
    this._schooling = student['schooling'];
    this._schoolName = student['schoolName'];
    this._phoneNumber = student['phoneNumber'];
    this._preferedActivitiesList = student['preferedActivities'];
  }

  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get password => _password;
  bool get schooling => _schooling;
  String get schoolName => _schoolName;
  List get preferedActivities => _preferedActivitiesList;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['email'] = _email;
    map['password'] = _password;
    map['schooling'] = _schooling;
    map['schoolName'] = _schoolName;
    map['phoneNumber'] = _phoneNumber;
    map['preferedActivities'] = _preferedActivitiesList;

    return map;
  }

  Student.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._email = map['email'];
    this._password = map['password'];
    this._schooling = map['schooling'];
    this._schoolName = map['schoolName'];
    this._phoneNumber = map['phoneNumber'];
    this._preferedActivitiesList = map['preferedActivities'];
  }
}
