import 'package:flutter/material.dart';


class DailyLeisure extends StatefulWidget {
  DailyLeisure({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DailyLeisureState createState() => _DailyLeisureState();
}

class _DailyLeisureState extends State<DailyLeisure> {
  List activities;

  @override
  void initState() {
    activities = getActivities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Card makeCard(Activity activity) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(activity),
          ),
  );





    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: activities.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(activities[index]);
        },
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: makeBody,
    );
  }
  makeListTile(Activity activity) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Text(activity.time,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            activity.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing:
              Icon(Icons.add_circle_outline, color: Colors.white, size: 30.0),
          onTap: () =>{
                      showDialog(context: context,builder:(context){
                  return AlertDialog(
                    
                    title: Text("Rate Performance"),
                    content: TextField(
                      controller: TextEditingController(),
                    ),
                    actions: <Widget>[
                      MaterialButton(
                        elevation: 5.0,
                        child: Text("Submit",style: TextStyle(color: Colors.blueAccent)),
                        onPressed:(){
                          Navigator.of(context).pop(TextEditingController().text.toString());
                        },
                        )
                    ],
                  );
                })
                        });
}

class Activity {
  String title;
  String time;
  Activity(this.title,this.time);
}



List getActivities() {
  return [
  
  Activity("Listening To Music","9.45 - 10.00"),
  Activity("Play A Sport","17.00 - 18.00"),
  Activity("Watching Television","18.30 - 19.00"),
  ];
}


  
  ListTile makeListTile(Activity activity) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Text(activity.time,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            activity.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing:
              Icon(Icons.add_circle_outline, color: Colors.white, size: 30.0),
          onTap: () {

            
          },
        );