class SubjectProgress {
  String _id;
  String _name;
  int _progress;

  SubjectProgress(this._id, this._name, this._progress);

  SubjectProgress.map(dynamic subjectProgress) {
    this._id = subjectProgress['id'];
    this._name = subjectProgress['name'];
    this._progress = subjectProgress['progress'];
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

  SubjectProgress.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._progress = map['progress'];
  }
}
