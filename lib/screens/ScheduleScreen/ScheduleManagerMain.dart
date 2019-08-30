import 'package:flutter/material.dart';
import 'package:studymate/screens/ScheduleScreen/createSchedule.dart';
import 'package:studymate/widgets/DrawerTile.dart';

class ScheduleManagerHome extends StatefulWidget {
  _ScheduleManagerHomeState createState() => _ScheduleManagerHomeState();
}

class _ScheduleManagerHomeState extends State<ScheduleManagerHome> {
  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>[
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
    final List<int> colorCodes = <int>[600, 500, 100, 600, 500, 100, 600];

    return Scaffold(
        appBar: AppBar(
          title: Text("Schedule Manager"),
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
        body: ListView.separated(
          padding: const EdgeInsets.all(8.0),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateSchedule(id: index)));
              },
              child: Container(
                height: 50,
                color: Colors.amber[colorCodes[index]],
                child: Center(
                  child: Text('${entries[index]}'),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ));
  }
}
