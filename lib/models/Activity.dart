class Activity {
  final String id;
  final String name;
  final String type;

  Activity(this.name, this.type, this.id);

  Activity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = json['type'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'type': type
  };

  List getActivities() {
    return [
      // Activity("eventQuery.toString()", "9.45 - 10.00"),
      // Activity("Play A Sport", "17.00 - 18.00"),
      // Activity("Watching Television", "18.30 - 19.00"),
    ];
  }
}
