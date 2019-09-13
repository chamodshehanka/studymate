class Student {
  String _id;
  String _name;
  String _parentID;
  String _birthday;
  String _schoolName;
  String _grade;
  String _email;
  String _password;
  String _phone;
  String _address;

  Student(this._id, this._name, this._parentID, this._birthday, this._grade,
     this._email, this._phone, this._address, String phone, String address);

  Student.map(dynamic student) {
    this._id = student['id'];
    this._name = student['name'];
    this._parentID = student['parentID'];
    this._birthday = student['date'];
    this._schoolName = student['schoolName'];
    this._grade = student['grade'];
    this._email = student['email'];
    this._password = student['password'];
    this._phone = student['phone'];
    this._address = student['address'];
    
  }

  String get id => _id;
  String get name => _name;
  String get parentID => _parentID;
  String get birthday => _birthday;
  String get schoolName => _schoolName;
  String get grade => _grade;
  String get email => _email;
  String get password => _password;
  String get phone => _phone;
  String get address => _address;
  

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['parentID'] = _parentID;
    map['birthday'] = _birthday;
    map['schoolName'] = _schoolName;
    map['grade'] = _grade;
    map['email'] = _email;
    map['password'] = _password;
    map['phone'] = _phone;
    map['address'] = _address;
    

    return map;
  }

  Student.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._parentID = map['parentID'];
    this._birthday = map['birthday'];
    this._schoolName = map['schoolName'];
    this._grade = map['grade'];
    this._email = map['email'];
    this._password = map['password'];
    this._phone = map['phone'];
    this._address = map['address'];
  }
}
