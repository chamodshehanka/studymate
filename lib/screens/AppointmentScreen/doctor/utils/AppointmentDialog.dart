import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/Doctor.dart';
import 'package:studymate/services/custom/AppointmentService.dart';
import 'package:studymate/services/custom/DoctorService.dart';
import 'package:studymate/widgets/StudymateTextField.dart';

class AppointmentDialog extends StatefulWidget {
  _AppointmentDialog createState() => _AppointmentDialog();
}

class _AppointmentDialog extends State<AppointmentDialog> {
  final _formKeyAppointment = GlobalKey<FormState>();
  final isApprovedController = TextEditingController();
  final descriptionController = TextEditingController();
  final placeController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  var doctorName;
  var studentName;
  AppointmentService _appointmentService = AppointmentService();
  DoctorService _doctorService = DoctorService();
  StreamSubscription<QuerySnapshot> doctorsSubscription;
  List<Doctor> doctorsList;
  List<String> doctorNamesList;

  @override
  void initState() {
    super.initState();

    doctorNamesList = List();
    doctorsList = List();
    doctorsSubscription?.cancel();
    doctorsSubscription =
        _doctorService.getAll().listen((QuerySnapshot snapshot) {
      final List<Doctor> doctors =
          snapshot.documents.map((doc) => Doctor.fromMap(doc.data)).toList();

      setState(() {
        this.doctorsList = doctors;
      });
    });

    /// Fill out doctorNames List
    doctorsList.forEach((doctor) =>
        doctorNamesList.add(doctor.firstName + ' ' + doctor.lastName));
  }

  @override
  void dispose() {
    doctorsSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        'Create Appointment',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.deepPurple),
      ),
      content: Form(
        key: _formKeyAppointment,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Student Select
            StudymateTextField(
              labelText: 'Description',
              textEditingController: descriptionController,
              validation: 'name',
              icon: Icon(Icons.description, color: Colors.grey),
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(),
                  ),
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 10.0),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Icon(Icons.directions_run, color: Colors.grey),
                  )),
              value: doctorName,
              hint: Text('Select Doctor'),
              items: doctorNamesList
                  .map((label) => DropdownMenuItem(
                        child: Text(label),
                        value: label,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  doctorName = value;
                });
              },
            ),

            // Button Actions
            Row(
              children: <Widget>[],
            ),
          ],
        ),
      ),
    );
  }
}
