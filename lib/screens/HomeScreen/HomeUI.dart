import 'package:flutter/material.dart';
import 'package:studymate/services/Authentication.dart';
import 'package:studymate/widgets/DrawerTile.dart';
import 'package:studymate/widgets/HomeTile.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BaseAuthentication _auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.deepPurpleAccent,
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
                  color: Colors.white54,
                ),
                decoration: BoxDecoration(color: Colors.deepPurple),
              ),
              DrawerTile(Icons.person, 'Profile',
                  () => {Navigator.pushNamed(context, '/profileUI')}),
              DrawerTile(Icons.note, 'Reminders', () => {}),
              DrawerTile(Icons.info, 'About Us', () => {}),
              DrawerTile(Icons.settings, 'Settings', () => {}),
              DrawerTile(Icons.exit_to_app, 'Logout', () {
                _auth.signOut();
                Navigator.pushNamed(context, '/signin');
              }),
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
            HomeTile(Icons.timeline, "Progress Tracking", Colors.cyan,
                "/medicalRecord"),
            HomeTile(Icons.book, "Subject Manager", Colors.green, "/subject"),
            HomeTile(Icons.local_activity, "Activity Manager",
                Colors.deepPurpleAccent, "/activity"),
            HomeTile(Icons.calendar_today, "Schedule Manager", Colors.cyan,
                "/scheduleManager"),
            HomeTile(Icons.supervised_user_circle, "Profile", Colors.red,
                "/accounttype"),
            HomeTile(Icons.calendar_today, "Appointments", Colors.amber,
                "/appointment"),
            HomeTile(Icons.stars, "Reward Manager", Colors.pink, "/s_rewards"),
            HomeTile(Icons.chat, "Chat", Colors.blueAccent, "/chat"),
            HomeTile(Icons.build, 'Test UIs', Colors.black, '/testUI'),
          ],
        ));
  }
}
