import 'package:flutter/material.dart';
import 'package:studymate/screens/AppointmentScreen/doctor/tabs/NotApprovedAppointmentTab.dart';

class DoctorAppointmentDashboardScreen extends StatefulWidget {
  _DoctorAppointmentDashboardScreenState createState() =>
      _DoctorAppointmentDashboardScreenState();
}

class _DoctorAppointmentDashboardScreenState
    extends State<DoctorAppointmentDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Appointment Dashboard'),
              backgroundColor: Colors.deepPurpleAccent,
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(icon: Icon(Icons.access_time)),
                  Tab(icon: Icon(Icons.access_time))
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                NotApprovedAppointmentsTab(),
                NotApprovedAppointmentsTab(),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add, color: Colors.white),
              onPressed: () {},
            ),
          )),
    );
  }
}
