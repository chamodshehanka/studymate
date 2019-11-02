class Badge{
  String _id;
  String _name;
  String _type;
  String _task;
  String  _milestone;
  String _description;

  


Badge(this._id, this._name, this._type, this._task,this._milestone, this._description);

 Badge.map(dynamic badge) {
    this._id = badge['id'];
    this._name = badge['name'];
    this._type = badge['type'];
    this._task = badge['task'];
    this._milestone = badge['milestone'];
    this._description= badge['description'];
  
  }

  String get id => _id;
  String get name => _name;
  String get type => _type;
  String get task => _task;
  String get milestone => _milestone;
  String get description => _description;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['type'] = _type;
    map['task'] = _task;
    map['milestone'] = _milestone;
    map['description'] = _description;

    return map;
  }

  Badge.fromMap(Map<String, dynamic> map) {
    
    this._name = map['name'];
    this._type = map['type'];
    this._task = map['task'];
    this._milestone = map['milestone'];
    this._description = map['description'];
  }

  toList() {}
}

