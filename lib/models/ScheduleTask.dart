class ScheduleTask {
  String _id;
  String _name;
  String _type;
  DateTime _start;
  DateTime _end;

  ScheduleTask(this._id, this._name, this._type,this._start,this._end);

  ScheduleTask.map(dynamic scheduleTask) {
    this._id = scheduleTask['id'];
    this._name = scheduleTask['name'];
    this._type = scheduleTask['type'];
    this._start = scheduleTask['start'];
    this._end = scheduleTask['end'];
  }

  String get id => _id;
  String get name => _name;
  String get type => _type;
  DateTime get start => _start;
  DateTime get end => _end;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['type'] = _type;
    map['start'] = _start;
    map['end'] = _end;

    return map;
  }

  ScheduleTask.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._type = map['type'];
    this._start = map['start'];
    this._end = map['end'];
  }
}
