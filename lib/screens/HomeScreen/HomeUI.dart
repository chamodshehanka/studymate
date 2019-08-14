import 'package:flutter/material.dart';
import 'package:studymate/widgets/HomeTile.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.deepPurple,
        ),
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Icon(
                  Icons.account_circle,
                  size: 90.0,
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                  Colors.deepOrange,
                  Colors.orangeAccent,
                  Colors.yellow,
                ])),
              ),
              HomeTile(Icons.person, 'Profile', () => {}),
              HomeTile(Icons.note, 'Reminders', () => {}),
              HomeTile(Icons.info, 'About Us', () => {}),
              HomeTile(Icons.settings, 'Settings', () => {}),
              HomeTile(Icons.exit_to_app, 'Logout', () => {}),
            ],
          ),
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20.0),
          crossAxisSpacing: 10.0,
          crossAxisCount: 2,
          children: <Widget>[
            makeCardTile(Icons.calendar_today, "Daily Schedule",
                Colors.lightBlue, "/daily"),
            makeCardTile(Icons.timeline, "Progress Tracking", Colors.cyan, ""),
            makeCardTile(
                Icons.book, "Subject Manager", Colors.green, "/subject"),
            makeCardTile(Icons.local_activity, "Activity Manager",
                Colors.deepPurpleAccent, "/activity"),
            makeCardTile(Icons.calendar_today, "Schedule Manager", Colors.cyan,
                "/createSchedule"),
            makeCardTile(Icons.supervised_user_circle, "Profile", Colors.red,
                "/accounttype"),
            makeCardTile(Icons.calendar_today, "Appointments",
                Colors.amber, "/Appointment"),
            makeCardTile(Icons.stars, "Reward Manager", Colors.pink, "/rewards")
          ],
        ));
  }

  makeCardTile(IconData icon, String title, Color background, String path) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(50),
        child: Container(
          width: 300,
          height: 300,
          child: RaisedButton(
              elevation: 10.0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              onPressed: () => Navigator.pushNamed(context, path),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                        color: background,
                      ),
                      width: 100,
                      height: 100,
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 60.0,
                      )),
                  SizedBox(height: 10.0),
                  Text(
                    title,
                    style: TextStyle(
                      color: background,
                      decoration: TextDecoration.none,
                      fontSize: 16.0,
                      fontFamily: "OpenSans",
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
