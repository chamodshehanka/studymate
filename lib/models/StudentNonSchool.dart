class Student {
  String _id;
  String _name;
  String _patientId;
  String _birthday;
  String _email;
  String _password;
  String _phone;
  String _address;
  

  Student(this._id, this._name, this._patientId, this._birthday, 
       this._email,this._password, this._phone, this._address,);

  Student.map(dynamic student) {
    this._id = student['id'];
    this._name = student['name'];
    this._patientId = student['parentId'];
    this._birthday = student['bithday'];
    this._address = student['address'];
    this._email = student['email'];
    this._password = student['password'];
    this._phone = student['phone'];
    
  }

  String get id => _id;
  String get name => _name;
  String get patientId => _patientId;
  String get birthday => _birthday;
  String get address => _address;
  String get email => _email;
  String get phone => _phone;


  get parentID => null;



  get password => null;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['patientId'] = _patientId;
    map['birthday'] = _birthday;
    map['email'] = _email;
    map['phone'] = _phone;
    map['address'] = _address;

    return map;
  }

  Student.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._patientId = map['patientId'];
    this._birthday = map['birthday'];
    this._email = map['email'];
    this._phone = map['phone'];
    this._address = map['address'];
    
  }
}
