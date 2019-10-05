class Appointment {
  String _id;
  String _specialDescription;
  String _date;
  String _time;
  String _place;
  //String _status;

  Appointment(this._id, this._specialDescription,this._date,this._time,this._place,/*this._status */);

  Appointment.map(dynamic appointment) {
    this._id = appointment['id'];
    this._specialDescription = appointment['specialDescription'];
    this._date = appointment['date'];
    this._time = appointment['time'];
    this._place = appointment['place'];
    //this._status = appointment['status'];
  }

  String get id => _id;
  String get specialDescription => _specialDescription;
  String get date => _date;
  String get time => _time;
  String get place => _place;

 
  //String get status => _status;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['specialDescription'] = _specialDescription;
    map['date'] = _date;
    map['time'] = _time;
    map['place'] = _place;
   // map['status'] = _status;

    return map;
  }

  Appointment.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._specialDescription = map['specialDescription'];
    this._date = map['date'];
    this._time = map['time'];
    this._place = map['place'];
   // this._status = map['status'];
  }
}
