class Student {
  String _id;
  String _fullName;
  String _email;
  String _password;
  String _schoolName;
  String _phoneNumber;

  
  

  Student(this._id, this._fullName, 
     this._email, this._password, this._schoolName, this._phoneNumber);

  Student.map(dynamic student) {
    this._id = student['id'];
    this._fullName = student['name'];
    this._email = student['email'];
    this._password = student['password'];
    this._schoolName = student['school name'];
    this._phoneNumber = student['phone number'];
 
    
    
    
  }

  String get id => _id;
  String get name => _fullName;
  String get email => _email;
  String get password => _password;
  String get schoolName => _schoolName;
  
 

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _fullName;
    map['email'] = _email;
    map['password'] = _password;
    map['school name'] = _schoolName;
    map['phone number'] = _phoneNumber;
    
    
    

    return map;
  }

  Student.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._fullName = map['full name'];
    this._email = map['email'];
    this._password = map['password'];
    this._schoolName = map['school name'];
    this._phoneNumber = map['phone number'];
    
    
    
  }
}
