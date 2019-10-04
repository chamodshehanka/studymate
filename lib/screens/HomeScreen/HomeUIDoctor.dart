import 'package:flutter/material.dart';
import 'package:studymate/services/Authentication.dart';
import 'package:studymate/widgets/DrawerTile.dart';
import 'package:studymate/widgets/HomeTile.dart';

class HomeScreenDoctor extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenDoctor> {
  BaseAuthentication _authentication = Authentication();

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
          HomeTile(Icons.calendar_today, "Appointments", Colors.amber,
              "/DashboardAppointment"),
          HomeTile(Icons.healing, "Medical Records", Colors.lightBlue, "/medicalRecord"),
          HomeTile(Icons.timeline, "Progress Tracker", Colors.cyan, ""),
          HomeTile(
              Icons.calendar_today, "Schedule", Colors.cyan, "/createSchedule"),
          HomeTile(Icons.supervised_user_circle, "Profile", Colors.red,
              "/accounttype"),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.close, color: Colors.white),
        onPressed: () {
          _authentication.signOut();
          Navigator.pushNamed(context, '/welcome');
        },
      ),
    );
  }
}
