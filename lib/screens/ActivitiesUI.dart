import 'package:flutter/material.dart';
import 'package:studymate/models/Activity.dart';

class ActivitiesUI extends StatefulWidget {
  final String title;

  ActivitiesUI({Key key, this.title}) : super(key: key);

  @override
  _ActivitiesUIState createState() => _ActivitiesUIState();
}

class _ActivitiesUIState extends State<ActivitiesUI> {
  List activities;
  Activity activity;

  @override
  void initState() {
    activities = activity.getActivities();
    super.initState();
  }

  @override
  Widget build(BuildContext buildContext) {
    Card makeCard(Activity activity) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(activity),
          ),
        );
  }
}

ListTile makeListTile(Activity activity) => ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Text(
          activity.time,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        activity.title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.add_circle_outline, color: Colors.white, size: 30.0),
      onTap: () {},
    );
