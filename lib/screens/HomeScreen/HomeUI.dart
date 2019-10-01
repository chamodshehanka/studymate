import 'package:flutter/material.dart';
import 'package:studymate/widgets/RadialProgress.dart';
import 'package:studymate/widgets/TopBar.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    int _selectedIndex = 0;
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
    return Scaffold(
       
        backgroundColor: Colors.white,
      
        body:
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TopBar(),
            RadialProgress(),
            Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 200.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                width: 160.0,
                color: Colors.red,
              ),
              Container(
                width: 160.0,
                color: Colors.blue,
              ),
              Container(
                width: 160.0,
                color: Colors.green,
              ),
              Container(
                width: 160.0,
                color: Colors.yellow,
              ),
              Container(
                width: 160.0,
                color: Colors.orange,
              ),
            ],
          ),
        ),
            ],
          ),
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
    );
  }
}
