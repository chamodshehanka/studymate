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
        backgroundColor: Colors.blueAccent,
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
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: Container(
                  width: 300,
                  height: 100,
                  child: FlatButton(
                      onPressed: () => Navigator.pushNamed(context, '/daily'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.calendar_today,
                            color: Colors.blueGrey,
                            size: 70.0,
                          ),
                          Text(
                            "Daily Schedule",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              decoration: TextDecoration.none,
                              fontSize: 17.0,
                              fontFamily: "OpenSans",
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: Container(
                  width: 300,
                  height: 100,
                  child: FlatButton(
                      onPressed: () => {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.timeline,
                            color: Colors.blueGrey,
                            size: 70.0,
                          ),
                          Text(
                            "Progress Tracking",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              decoration: TextDecoration.none,
                              fontSize: 17.0,
                              fontFamily: "OpenSans",
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: Container(
                  width: 300,
                  height: 100,
                  child: FlatButton(
                      onPressed: () => {
                            Navigator.pushNamed(context, '/subject'),
                          },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.book,
                            color: Colors.blueGrey,
                            size: 70.0,
                          ),
                          Text(
                            "Subject Manager",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                              fontFamily: "OpenSans",
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: Container(
                  width: 300,
                  height: 100,
                  child: FlatButton(
                      onPressed: () => {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.games,
                            color: Colors.blueGrey,
                            size: 70.0,
                          ),
                          Text(
                            "Activity Manager",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                              fontFamily: "OpenSans",
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: Container(
                  width: 300,
                  height: 100,
                  child: FlatButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/createSchedule'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.calendar_today,
                            color: Colors.blueGrey,
                            size: 70.0,
                          ),
                          Text(
                            "Weekly Schedule",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                              fontFamily: "OpenSans",
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: Container(
                  width: 300,
                  height: 100,
                  child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/accounttype");
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.supervised_user_circle,
                            color: Colors.blueGrey,
                            size: 70.0,
                          ),
                          Text(
                            "Profile",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                              fontFamily: "OpenSans",
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: Container(
                  width: 300,
                  height: 100,
                  child: FlatButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/Appointment'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.calendar_today,
                            color: Colors.blueGrey,
                            size: 70.0,
                          ),
                          Text(
                            "Appointment Management",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                              fontFamily: "OpenSans",
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: Container(
                  width: 300,
                  height: 100,
                  child: FlatButton(
                      onPressed: () => Navigator.pushNamed(context, '/rewards'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.stars,
                            color: Colors.blueGrey,
                            size: 70.0,
                          ),
                          Text(
                            "Reward Management",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              decoration: TextDecoration.none,
                              fontSize: 18.0,
                              fontFamily: "OpenSans",
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ],
        ));
  }
}
