import 'package:flutter/material.dart';
import 'package:studymate/screens/ActivityScreen/tabs/LeisureActivityTab.dart';
import 'package:studymate/screens/ActivityScreen/tabs/OtherActivityTab.dart';
import 'package:studymate/screens/ActivityScreen/tabs/SocialActivityTab.dart';

class ActivityScreen extends StatefulWidget {
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
   int _selectedIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch(_selectedIndex){
        case 0 : Navigator.pushNamed(context, "/home");
                break;
        case 1 : Navigator.pushNamed(context, "/scheduleManager");
                break;
        case 2 : Navigator.pushNamed(context, "/activity");
                break;
        case 3 : Navigator.pushNamed(context, "/profileUI");                      

      }
    });
  }
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
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepPurple,
            child: Icon(Icons.show_chart),
            onPressed: () => Navigator.pushNamed(context, '/activityProgress'),
          ),
           bottomNavigationBar: BottomNavigationBar(
       items: [
         BottomNavigationBarItem(
           icon: new Icon(Icons.home,color: Colors.deepPurple),
           title: new Text('Home',style: TextStyle(color: Colors.deepPurple)),
         ),
         BottomNavigationBarItem(
           icon: new Icon(Icons.calendar_today,color: Colors.deepPurple),
           title: new Text('Schedule',style: TextStyle(color: Colors.deepPurple)),
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.favorite,color: Colors.deepPurple),
           title: Text('Preferences',style: TextStyle(color: Colors.deepPurple))
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.account_circle,color: Colors.deepPurple),
           title: Text('Profile',style: TextStyle(color: Colors.deepPurple))
         )
       ],
       currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
    ),
        ),
      ),
    );
  }
}
