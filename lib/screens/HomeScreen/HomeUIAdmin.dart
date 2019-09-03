import 'package:flutter/material.dart';
import 'package:studymate/widgets/DrawerTile.dart';
import 'package:studymate/widgets/HomeTile.dart';

class HomeScreenAdmin extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenAdmin> {
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
            HomeTile(Icons.verified_user, "User Manager", Colors.red, ""),
            HomeTile(Icons.calendar_today, "Appointments", Colors.amber, ""),
            HomeTile(Icons.local_activity, "Activity Manager", Colors.deepPurpleAccent, "/adminActivity"),
            HomeTile(Icons.book, "Subject Manager", Colors.lightBlue, ""),
            HomeTile(Icons.calendar_today, "Schedules", Colors.cyan, ""),
            HomeTile(Icons.supervised_user_circle, "Profile", Colors.red,
                "/accounttype"),
            HomeTile(Icons.stars, "Rewards", Colors.pink, "/rewards"),
          ],
        ));
  }
}
