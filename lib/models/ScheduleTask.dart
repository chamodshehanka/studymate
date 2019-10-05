
class ScheduleTask {
  String _name;
  String _type;
  String _start;
  String _end;
  String _id;
 

  void setId(String id){
    this._id = id;
  }
  ScheduleTask(this._name, this._type,this._start,this._end,[this._id]);

  ScheduleTask.map(dynamic scheduleTask) {
    this._name = scheduleTask['name'];
    this._type = scheduleTask['type'];
    this._start = scheduleTask['start'];
    this._end = scheduleTask['end'];
    this._id = scheduleTask['id'];
  }

  String get name => _name;
  String get type => _type;
  String get start => _start;
  String get end => _end;
  String get id => _id;


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = _name;
    map['type'] = _type;
    map['start'] = _start;
    map['end'] = _end;
    map['id'] = _id;

    return map;
  }

  ScheduleTask.fromMap(Map<String, dynamic> map) {
    this._name = map['name'];
    this._type = map['type'];
    this._start = map['start'];
    this._end = map['end'];
    this._id = map['id'];
  }
}
