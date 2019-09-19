class Task {
  String _taskappointmentID;
  String _taskname;
  String _taskSpecialDescription;
  String _taskdate;
  String _tasktime;
  String _taskplace;

  Task(this._taskappointmentID, this._taskname, this._taskSpecialDescription,
      this._taskdate, this._tasktime, this._taskplace);

  Task.map(dynamic obj) {
    this._taskappointmentID = obj['taskappointmentID'];
    this._taskname = obj['taskname'];
    this._taskSpecialDescription = obj['taskSpecialDescription'];
    this._taskdate = obj['taskdate'];
    this._tasktime = obj['tasktime'];
    this._taskplace = obj['taskplace'];
  }
  String get taskappointmentID => _taskappointmentID;
  String get taskname => _taskname;
  String get taskSpecialDescription => _taskSpecialDescription;

  String get taskdate => _taskdate;
  String get tasktime => _tasktime;

  String get taskplace => _taskplace;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['taskappointmentID'] = _taskappointmentID;
    map['taskname'] = _taskname;
    map['taskSpecialDescription'] = _taskSpecialDescription;
    map['taskdate'] = _taskdate;
    map['tasktime'] = _tasktime;
    map['taskplace'] = _taskplace;

    return map;
  }

  Task.fromMap(Map<String, dynamic> map) {
    this._taskappointmentID = map['taskappointmentID'];
    this._taskname = map['taskname'];
    this._taskSpecialDescription = map['taskSpecialDescription'];
    this._taskdate = map['taskdate'];
    this._tasktime = map['tasktime'];
    this._taskplace = map['taskplace'];
  }
}
