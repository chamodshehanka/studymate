import 'package:flutter/material.dart';
import 'package:studymate/screens/AppointmentScreen/doctor/tabs/NotApprovedAppointmentTab.dart';
import 'package:studymate/screens/AppointmentScreen/doctor/tabs/ApprovedAppointmentTab.dart';
import 'package:studymate/screens/AppointmentScreen/doctor/utils/CreateAppointmentDialog.dart';

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
                  Tab(icon: Text('Not Approved')),
                  Tab(icon: Text('Approved'))
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                NotApprovedAppointmentsTab(),
                ApprovedAppointmentTab(),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.deepPurpleAccent,
              child: Icon(Icons.add, color: Colors.white),
              onPressed: () {
                /// Create Appointment impl
                _showMakeAppointmentDialog(context);
              },
            ),
          )),
    );
  }

  void _showMakeAppointmentDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) {
          return CreateAppointmentDialog();
        });
  }
}
