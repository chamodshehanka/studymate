import 'package:flutter/material.dart';
import 'package:studymate/widgets/DrawerTile.dart';
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
              DrawerTile(Icons.person, 'Profile', () => {}),
              DrawerTile(Icons.note, 'Reminders', () => {}),
              DrawerTile(Icons.info, 'About Us', () => {}),
              DrawerTile(Icons.settings, 'Settings', () => {}),
              DrawerTile(Icons.exit_to_app, 'Logout', () => {}),
            ],
          ),
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20.0),
          crossAxisSpacing: 10.0,
          crossAxisCount: 2,
          children: <Widget>[
            HomeTile(Icons.calendar_today, "Daily Schedule", Colors.lightBlue,
                "/daily"),
            HomeTile(Icons.timeline, "Progress Tracking", Colors.cyan, ""),
            HomeTile(Icons.book, "Subject Manager", Colors.green, "/subject"),
            HomeTile(Icons.local_activity, "Activity Manager",
                Colors.deepPurpleAccent, "/activity"),
            HomeTile(Icons.calendar_today, "Schedule Manager", Colors.cyan,
                "/createSchedule"),
            HomeTile(Icons.supervised_user_circle, "Profile", Colors.red,
                "/accounttype"),
            HomeTile(Icons.calendar_today, "Appointments", Colors.amber,
                "/Appointment"),
            HomeTile(Icons.stars, "Reward Manager", Colors.pink, "/rewards"),
            HomeTile(Icons.build, 'Test UIs', Colors.black, '/testUI'),
          ],
        ));
  }
}
