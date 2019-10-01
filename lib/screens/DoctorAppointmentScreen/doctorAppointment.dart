import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studymate/models/Task.dart';
import 'package:studymate/screens/DoctorAppointmentScreen/AppointmentScreen.dart';
import 'package:studymate/services/custom/AppointmentService.dart';
import 'AppointmentScreen.dart';

void main() => runApp(DoctorAppointmentScreen());

class DoctorAppointmentScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appointment Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.deepPurple,
     
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Task> items;
  AppointmentService fireServ = new AppointmentService();
  StreamSubscription<QuerySnapshot> todoTasks;

  @override
  void initState() {
    super.initState();

    items = new List();

    todoTasks?.cancel();
    todoTasks = fireServ.getTaskList().listen((QuerySnapshot snapshot) {
      final List<Task> tasks = snapshot.documents
          .map((documentSnapshot) => Task.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items = tasks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          _myAppBar(context),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 80,
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Stack(children: <Widget>[
                    // The containers in the background
                    Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 202.0,
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Material(
                              color: Colors.white,
                              elevation: 16.0,
                              shadowColor: Color(0xFFAB47BC),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '${items[index].taskappointmentID}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0),
                                      ),
                                      
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '${items[index].taskname}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0),
                                          ),
                                          Text(
                                            '${items[index].taskSpecialDescription}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0),
                                          ),
                                          Text(
                                            '${items[index].taskdate}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '${items[index].tasktime}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0),
                                          ),
                                          Text(
                                            '${items[index].taskplace}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0),
                                          ),
                                          Padding(
                                          padding: const EdgeInsets.only(top: 0.0, bottom: 2.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            IconButton(
                                            icon:Icon(Icons.check_circle,color:Colors.green,size: 35), 
                                            onPressed: () {},
                                            ),
                                          Padding(
                                          padding:const EdgeInsets.only() ,
                                          child: Column(
                                          children: <Widget>[
                                          Text( " Approved ",
                                             style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17.0,
                                              ),
                                            )
                                          ],
                                      ),
                                    ),
                                     IconButton(
                                            icon:Icon(Icons.cancel,color:Colors.red,size: 35), 
                                            onPressed: () {},
                                            ),
                                          Padding(
                                          padding:const EdgeInsets.only() ,
                                          child: Column(
                                          children: <Widget>[
                                          Text( "UnApproved",
                                             style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                      ),
                                    ),
                                         ],
                                        ),
                                       ),
                                      ],
                                    )
                                      
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ]);
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(
          Icons.add,
          color: Color(0xFFFAFAFA),
        ),
        onPressed: () {
          //Navigator.push(context,MaterialPageRoute(builder: (context) => TaskScreen()),
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TaskScreen(Task('', '', '', '', '', '')),
                fullscreenDialog: true),
          );
        },
      ),
    );
  }

  Widget _myAppBar(context) {
    return Container(
      height: 80.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              const Color(0xFF6A1B9A),
              const Color(0xFF6A1B9A),
            ],
          
           ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ),
                    onPressed: () =>
                      Navigator.pushNamed(context,'/HomeScreenDoctor'),
                    ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: Text(
                  'Appointment Management',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.checkSquare,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      //
                    }),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
