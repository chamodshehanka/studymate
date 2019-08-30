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
}
