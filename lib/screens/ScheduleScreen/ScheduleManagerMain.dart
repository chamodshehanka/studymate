import 'package:flutter/material.dart';
import 'package:studymate/screens/ScheduleScreen/CreateSchedule.dart';




class ScheduleManagerHome extends StatefulWidget {
  
  _ScheduleManagerHomeState createState() => _ScheduleManagerHomeState();
  
}

class _ScheduleManagerHomeState extends State<ScheduleManagerHome> {

    int _selectedIndex = 1;
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
            final List<String> entries = <String>['Sunday', 'Monday', 'Tuesday','Wednesday','Thursday','Friday','Saturday'];

    return Scaffold(
       
        backgroundColor: Colors.white,
        body: 
          ListView.separated(
  padding: const EdgeInsets.all(8.0),
  itemCount: entries.length,
  itemBuilder: (BuildContext context, int index) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder:(context)=>CreateSchedule(id: index)));
      },
      child: Container(
        height: 70,
        color: Colors.amber,
        child: Center(child: Text('${entries[index]}'),),
      ),
    );
  },
  separatorBuilder: (BuildContext context, int index) => const Divider(),
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

