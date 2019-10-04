class Appointment {
  String _id;
  String _specialDescription;
  String _date;
  String _time;
  String _place;
  String _type;

  Appointment(this._id, this._specialDescription,this._date,this._time,this._place, this._type);

  Appointment.map(dynamic appointment) {
    this._id = appointment['id'];
    this._specialDescription = appointment['specialDescription'];
    this._date = appointment['date'];
    this._time = appointment['time'];
    this._place = appointment['place'];
    this._type = appointment['type'];
  }

  String get id => _id;
  String get specialDescription => _specialDescription;
  String get date => _date;
  String get time => _time;
  String get place => _place;
  String get type => _type;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['specialDescription'] = _specialDescription;
    map['date'] = _date;
    map['time'] = _time;
    map['place'] = _place;
    map['type'] = _type;

    return map;
  }

  Appointment.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._specialDescription = map['specialDescription'];
    this._date = map['date'];
    this._time = map['time'];
    this._place = map['place'];
    this._type = map['type'];
  }
}
