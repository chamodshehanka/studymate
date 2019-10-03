import 'package:flutter/material.dart';
import 'package:studymate/screens/ScheduleScreen/CreateSchedule.dart';




class ScheduleManagerHome extends StatefulWidget {
  
  _ScheduleManagerHomeState createState() => _ScheduleManagerHomeState();
  
}

class _ScheduleManagerHomeState extends State<ScheduleManagerHome> {

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

        

);
  }
}

