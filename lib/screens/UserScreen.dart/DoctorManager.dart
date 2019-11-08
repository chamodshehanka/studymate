

import 'package:flutter/material.dart';
import 'package:studymate/screens/UserScreen.dart/DoctorAddForm.dart';
import 'package:studymate/screens/UserScreen.dart/DoctorListView.dart';


class DoctorManagerScreen extends StatefulWidget {
  _DoctorManagerScreenState createState() => _DoctorManagerScreenState();
  
}



class _DoctorManagerScreenState extends State<DoctorManagerScreen> {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Doctor Manager",
            ),
            backgroundColor: Colors.deepPurple,
            centerTitle:true,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: "Add Doctor"),
                Tab(text: "View Doctors"),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              DoctorAddScreen(),
              DoctorListView(),
            ],
          ),
      
         ),
      ),
    );
  }
}
