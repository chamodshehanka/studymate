import 'package:flutter/material.dart';
import 'package:studymate/services/Authentication.dart';
import 'package:studymate/widgets/DrawerTile.dart';
import 'package:studymate/widgets/HomeTile.dart';

class HomeScreenAdmin extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenAdmin> {
  BaseAuthentication _authentication = Authentication();

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
          HomeTile(Icons.verified_user, "Student Manager", Colors.red,
              "/studentManage"),
          HomeTile(
              Icons.calendar_today, "Admin Manager", Colors.amber, "/adminManage"),
          HomeTile(Icons.calendar_today, "Doctor Manager", Colors.amber,
              "/doctorManage"),
          HomeTile(Icons.local_activity, "Activity Manager",
              Colors.deepPurpleAccent, "/adminActivityDashboard"),
          HomeTile(
              Icons.book, "Subject Manager", Colors.lightBlue, "/adminSubjectList"),
          HomeTile(Icons.supervised_user_circle, "Profile", Colors.red,
              "/forgotPassword"),
          HomeTile(Icons.stars, "Rewards Manager", Colors.pink, "/adminBadgeList"),
          HomeTile(
              Icons.settings, "Admin Test", Colors.black, "/medicalRecord"),
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
