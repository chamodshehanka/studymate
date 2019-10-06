class MedicalRecord {
  String _id;
  String _name;
  String _date;
  String _doctorName;
  String _studentName;
  String _url;

  MedicalRecord(this._id, this._name, this._date, this._doctorName,
      this._studentName, this._url);

  MedicalRecord.map(dynamic medicalRecord) {
    this._id = medicalRecord['id'];
    this._name = medicalRecord['name'];
    this._date = medicalRecord['date'];
    this._doctorName = medicalRecord['doctorName'];
    this._studentName = medicalRecord['studentName'];
    this._url = medicalRecord['url'];
  }

  String get id => _id;
  String get name => _name;
  String get date => _date;
  String get doctorName => _doctorName;
  String get studentName => _studentName;
  String get url => _url;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['date'] = _date;
    map['doctorName'] = _doctorName;
    map['studentName'] = _studentName;
    map['url'] = _url;

    return map;
  }

  MedicalRecord.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._date = map['date'];
    this._doctorName = map['doctorName'];
    this._studentName = map['studentName'];
    this._url = map['url'];
  }
}
