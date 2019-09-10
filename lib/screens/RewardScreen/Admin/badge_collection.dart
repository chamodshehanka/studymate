import 'package:flutter/material.dart';
//import 'package:studymate/screens/RewardScreen/Admin/subject_badges.dart';
//import 'package:studymate/screens/RewardScreen/Admin/activity_badges.dart';
import 'package:studymate/services/custom/BadgeService.dart';


class BadgesScreen extends StatefulWidget {
  @override
  _BadgesScreenState createState() => _BadgesScreenState();
}

class   _BadgesScreenState extends State<BadgesScreen> {
  final BadgeService badgeService = BadgeService();

  
  void initState(){
          super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
      child: Scaffold(
       appBar: AppBar(
        title: Text(
          "Badge Collection",
          style: TextStyle(fontWeight: FontWeight.bold),
          
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Color(0xFF18D191), size: 10.0),

        bottom: TabBar(
              tabs: <Widget>[
                Tab(icon: Icon(Icons.book)),
                Tab(icon: Icon(Icons.local_activity)),
                
              ],
            ),
      ),
      body:
      TabBarView(
            children: <Widget>[
             //  SubjectBadge (),
               // ActivityBadge(),
            
            ],
          ),
      floatingActionButton: FloatingActionButton(
       
        child: Icon(Icons.add),
        tooltip: 'Add New Badge',
         onPressed:() => Navigator.pushNamed(context, '/new_badge'),
        
      ),
     )
     )
      );
  }
}
