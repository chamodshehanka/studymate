class ActivityProgress {
  String _id;
  String _name;
  int _progress;

  ActivityProgress(this._id, this._name, this._progress);

  ActivityProgress.map(dynamic activityProgress) {
    this._id = activityProgress['id'];
    this._name = activityProgress['name'];
    this._progress = activityProgress['progress'];
  }

  String get id => _id;
  String get name => _name;
  int get progress => _progress;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['progress'] = _progress;

    return map;
  }

  ActivityProgress.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._progress = map['progress'];
  }
}
