import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeisureActivityTab extends StatefulWidget {
  LeisureActivityTab({Key key, this.title});
  final String title;

  @override
  _LeisureActivityTabState createState() => _LeisureActivityTabState();
}

class _LeisureActivityTabState extends State<LeisureActivityTab> {
  List leisureActivities;

  @override
  void initState() {
    leisureActivities = getLeisureActivities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Card makeCard(LeisureActivity leisureActivity) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            child: buildTilesList(leisureActivity),
          ),
        );

    final avtivityBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: leisureActivities.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(leisureActivities[index]);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white10,
      body: avtivityBody,
    );
  }

  buildTilesList(LeisureActivity leisureActivity) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white30))),
          child: Text(
            leisureActivity.time,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          leisureActivity.name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        trailing:
            Icon(Icons.add_circle_outline, color: Colors.white, size: 30.0),
        onTap: () => {},
      );
}

// Temp Leisure Activity data
class LeisureActivity {
  String name;
  String time;

  LeisureActivity(this.name, this.time);
}

List getLeisureActivities() {
  return [
    LeisureActivity('Painting', '45 min'),
    LeisureActivity('Drawing', '25 min'),
    LeisureActivity('Sudoku', '15 min'),
    LeisureActivity('Snake & Ladder', '35 min'),
  ];
}
