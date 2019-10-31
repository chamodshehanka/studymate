import 'package:flutter/material.dart';

class DoctorAppointmentDashboardScreen extends StatefulWidget {
  _DoctorAppointmentDashboardScreenState createState() =>
      _DoctorAppointmentDashboardScreenState();
}

class _DoctorAppointmentDashboardScreenState
    extends State<DoctorAppointmentDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Dashboard'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
    );
  }
}
