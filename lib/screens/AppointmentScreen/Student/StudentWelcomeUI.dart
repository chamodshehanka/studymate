import 'package:flutter/material.dart';
import 'package:studymate/screens/AppointmentScreen/Student/StudentAppointmentUI.dart';


class StudentAppointmentScreen extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<StudentAppointmentScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(25, 100, 25, 25),
          child: Center(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/Kevin_minions.png',
                  width: 200,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                ),
                Text(
                  'Your Personal',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Booking Appointment'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 48,
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Bebas',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Text(
                  'Increase Booking. Time Saving. Secure Systems. Experts Services.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentAppointmentListScreen(),
                      ),
                    );
                  },
                  minWidth: double.infinity,
                  height: 50,
                  child: Text(
                    'Get Started'.toUpperCase(),
                  ),
                  color: Colors.deepPurple,
                  textColor: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
