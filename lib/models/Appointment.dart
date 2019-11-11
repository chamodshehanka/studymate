class Appointment {
  String _id;
  String _description;
  String _date;
  String _time;
  String _place;
  String _doctorName;
  String _studentName;
  bool _isApproved;

  Appointment(this._id, this._description, this._date, this._time, this._place,
      this._doctorName, this._studentName, this._isApproved);

  Appointment.map(dynamic appointment) {
    this._id = appointment['id'];
    this._description = appointment['description'];
    this._date = appointment['date'];
    this._time = appointment['time'];
    this._place = appointment['place'];
    this._doctorName = appointment['doctorName'];
    this._studentName = appointment['studentName'];
    this._isApproved = appointment['isApproved'];
  }

  String get id => _id;
  String get description => _description;
  String get date => _date;
  String get time => _time;
  String get place => _place;
  String get doctorName => _doctorName;
  String get studentName => _studentName;
  bool get isApproved => _isApproved;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['description'] = _description;
    map['date'] = _date;
    map['time'] = _time;
    map['place'] = _place;
    map['doctorName'] = _doctorName;
    map['studentName'] = _studentName;
    map['isApproved'] = _isApproved;

    return map;
  }

  Appointment.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._description = map['description'];
    this._date = map['date'];
    this._time = map['time'];
    this._place = map['place'];
    this._doctorName = map['doctorName'];
    this._studentName = map['studentName'];
    this._isApproved = map['isApproved'];
  }
}
