import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/Appointment.dart';
import 'package:studymate/services/custom/AppointmentService.dart';

class NotApprovedAppointmentsTab extends StatefulWidget {
  _NotApprovedAppointmentsTabState createState() =>
      _NotApprovedAppointmentsTabState();
}

class _NotApprovedAppointmentsTabState
    extends State<NotApprovedAppointmentsTab> {
  List<Appointment> appointmentList;
  AppointmentService appointmentService = AppointmentService();
  StreamSubscription<QuerySnapshot> appointmentSubscription;
  // BaseAuthentication _authentication = Authentication();

  @override
  void initState() {
    super.initState();

    appointmentList = List();
    appointmentSubscription?.cancel();
    appointmentSubscription = appointmentService
        .getNotApprovedAppointments()
        .listen((QuerySnapshot snapshot) {
      final List<Appointment> appointments = snapshot.documents
          .map((documentSnapshot) => Appointment.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.appointmentList = appointments;
      });
    });
  }

  @override
  void dispose() {
    appointmentSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Card makeCard(Appointment appointment) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
            ),
            child: buildTilesList(appointment),
          ),
        );

    final appointmentBody = appointmentList != null
        ? Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: appointmentList.length,
              itemBuilder: (BuildContext context, int index) {
                return makeCard(appointmentList[index]);
              },
            ),
          )
        : Container(
            alignment: Alignment.center,
            child: Text(
              'Appointments are not available!!',
              style: TextStyle(backgroundColor: Colors.red, fontSize: 15),
            ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: appointmentBody,
    );
  }

  buildTilesList(Appointment appointment) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(
              border: Border(right: BorderSide(width: 1, color: Colors.white))),
          child: Text(
            appointment.date,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          appointment.description,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        trailing: Icon(
          Icons.filter_list,
          color: Colors.white,
          size: 30,
        ),
      );
}
