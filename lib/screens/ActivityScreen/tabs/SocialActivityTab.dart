import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SocialActivityTab extends StatefulWidget {
  SocialActivityTab({Key key, this.title});
  final String title;

  @override
  _SocialActivityTabState createState() => _SocialActivityTabState();
}

class _SocialActivityTabState extends State<SocialActivityTab> {
  List socialActivities;

  @override
  void initState(){
    socialActivities = getSocialActivities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Card makeCard(SocialActivity socialActivity) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.deepPurpleAccent),
        child: buildTilesList(socialActivity),
      ),
    );

    final avtivityBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: socialActivities.length,
        itemBuilder: (BuildContext context, int index){
          return makeCard(socialActivities[index]);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white10,
      body: avtivityBody,
    );
  }

  buildTilesList(SocialActivity socialActivity) => ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      decoration: new BoxDecoration(
        border: new Border(
          right: new BorderSide(width: 1.0, color: Colors.white30)
        )
      ),
      child: Text(
        socialActivity.time,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
    title: Text(
      socialActivity.name,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    trailing: Icon(Icons.add_circle_outline, color: Colors.white, size: 30.0),
    onTap: () => {},
  );
}


//Temp Social Activity data
class SocialActivity {
  String name;
  String time;
  SocialActivity(this.name, this.time);
}

List getSocialActivities() {
  return [
    SocialActivity('Speaking', '60 min'),
    SocialActivity('Online Gaming', '30 min'),
    SocialActivity('Community Groups', '10 min'),
  ];
}
