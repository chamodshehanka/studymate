import 'package:flutter/material.dart';
import 'package:studymate/screens/ActivityScreen/tabs/LeisureActivityTab.dart';
import 'package:studymate/screens/ActivityScreen/tabs/OtherActivityTab.dart';
import 'package:studymate/screens/ActivityScreen/tabs/SocialActivityTab.dart';

class ActivityListScreen extends StatefulWidget {
  _ActivityListScreenState createState() => _ActivityListScreenState();
}

class _ActivityListScreenState extends State<ActivityListScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Activities'),
            backgroundColor: Colors.deepPurple,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(icon: Icon(Icons.nature_people)),
                Tab(icon: Icon(Icons.accessibility_new)),
                Tab(icon: Icon(Icons.videogame_asset))
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              SocialActivityTab(),
              LeisureActivityTab(),
              OtherActivityTab(),
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   backgroundColor: Colors.deepPurple,
          //   child: Icon(Icons.show_chart),
          //   onPressed: () => Navigator.pushNamed(context, '/activityProgress'),
          // ),
        ),
      ),
    );
  }
}
