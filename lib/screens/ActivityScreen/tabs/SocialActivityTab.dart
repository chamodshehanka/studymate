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
        child: ,
      ),
    );
  }
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
