class MedicalRecord {
  String _id;
  String _name;
  String _date;
  String _url;

  MedicalRecord(this._id, this._name, this._date, this._url);

  MedicalRecord.map(dynamic medicalRecord) {
    this._id = medicalRecord['id'];
    this._name = medicalRecord['name'];
    this._date = medicalRecord['date'];
    this._url = medicalRecord['url'];
  }

  String get id => _id;
  String get name => _name;
  String get date => _date;
  String get url => _url;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['date'] = _date;
    map['url'] = _url;

    return map;
  }

  MedicalRecord.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._date = map['date'];
    this._url = map['url'];
  }
}
