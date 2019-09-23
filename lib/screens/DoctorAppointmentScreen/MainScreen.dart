import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'NewAppointment.dart';

void main() => runApp(DoctorAppointmentScreen());

class DoctorAppointmentScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appointment Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
         primaryColor: Color(0xFF4A148C),
      ),
      home: CreatToDo(),
    );
  }
}

class CreatToDo extends StatefulWidget {
  @override
  _CreatToDoState createState() => _CreatToDoState();
}

class _CreatToDoState extends State<CreatToDo> {
  @override
  void initState() {
    super.initState();
  }

  readData() {
    DocumentReference ds = Firestore.instance
        .collection('Appointment')
        .document('taskappointmentID');
    ds.get().then((datasnapshot) {
      print(datasnapshot.data['taskappointmentID']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          _myAppBar(context),
          Center(
            child: Text('Appointment'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF6A1B9A),
        child: Icon(
          Icons.add,
          color: Color(0xFFFAFAFA),
        ),
        onPressed: () {
          //Navigator.push(context,MaterialPageRoute(builder: (context) => TaskScreen()),
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewTask(), fullscreenDialog: true),
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
        padding: const EdgeInsets.only(top: 14.0),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                     }),
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
                      FontAwesomeIcons.search,
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
