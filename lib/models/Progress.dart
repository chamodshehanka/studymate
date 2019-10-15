
class Progress {
  int _completed;
  String _remarks;
  int _scheduled;

 


  Progress(this._completed, this._remarks,this._scheduled);

  Progress.map(dynamic scheduleTask) {
    this._completed = scheduleTask['completed'];
    this._remarks = scheduleTask['remarks'];
    this._scheduled = scheduleTask['scheduled'];
 
  }

  int get completed => _completed;
  String get remarks => _remarks;
  int get scheduled => _scheduled;



  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['completed'] = _completed;
    map['remarks'] = _remarks;
    map['scheduled'] = _scheduled;


    return map;
  }

  Progress.fromMap(Map<String, dynamic> map) {
    this._completed = map['completed'];
    this._remarks = map['remarks'];
    this._scheduled = map['scheduled'];

  }
}
