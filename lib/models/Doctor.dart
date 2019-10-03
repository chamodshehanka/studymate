class Doctor {
  String _id;
  String _firstName;
  String _lastName;
  String _regNo;
  String _nic;
  String _workPlace;

  Doctor(this._id, this._firstName, this._lastName, this._regNo, this._nic,
      this._workPlace);

  Doctor.map(dynamic doctor) {
    this._id = doctor['id'];
    this._firstName = doctor['firstName'];
    this._lastName = doctor['lastName'];
    this._regNo = doctor['regNo'];
    this._nic = doctor['nic'];
    this._workPlace = doctor['workPlace'];
  }

  String get id => _id;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get regNo => _regNo;
  String get nic => _nic;
  String get workPlace => _workPlace;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['regNo'] = _regNo;
    map['nic'] = _nic;
    map['workPlace'] = _workPlace;

    return map;
  }

  Doctor.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._firstName = map['firstName'];
    this._lastName = map['lastName'];
    this._regNo = map['regNo'];
    this._nic = map['nic'];
    this._workPlace = map['workPlace'];
  }
}
