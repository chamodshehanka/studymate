import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/Appointment.dart';
import 'package:studymate/models/Doctor.dart';
import 'package:studymate/models/Student.dart';
import 'package:studymate/services/custom/AppointmentService.dart';
import 'package:studymate/services/custom/DoctorService.dart';
import 'package:studymate/services/custom/StudentService.dart';
import 'package:studymate/widgets/StudymateTextField.dart';

class CreateAppointmentDialog extends StatefulWidget {
  _CreateAppointmentDialog createState() => _CreateAppointmentDialog();
}

class _CreateAppointmentDialog extends State<CreateAppointmentDialog> {
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
  StudentService _studentService = StudentService();
  StreamSubscription<QuerySnapshot> doctorsSubscription;
  StreamSubscription<QuerySnapshot> studentsSubscription;
  List<Doctor> doctorsList;
  List<String> doctorNamesList;
  List<Student> studentsList;
  List<String> studentNamesList;

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
        doctorsList = doctors;

        /// to remove existing names
        doctorNamesList.clear();

        /// Fill out doctorNames List
        doctorsList.forEach((doctor) {
          doctorNamesList.add(doctor.firstName + ' ' + doctor.lastName);
        });
      });
    });

    studentsList = List();
    studentNamesList = List();
    studentsSubscription?.cancel();
    studentsSubscription =
        _studentService.getStudentList().listen((QuerySnapshot snapshot) {
      final List<Student> students =
          snapshot.documents.map((doc) => Student.fromMap(doc.data)).toList();

      setState(() {
        studentsList = students;

        /// to remove existing names
        studentNamesList.clear();

        studentsList.forEach((student) {
          studentNamesList.add(student.firstName + student.lastName);
        });
      });
    });
  }

  @override
  void dispose() {
    doctorsSubscription?.cancel();
    studentsSubscription?.cancel();
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
            // Student Dropdown
            Padding(
              padding: const EdgeInsets.only(left: 1, right: 1),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(),
                  ),
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(30.0, 10.0, 20.0, 10.0),
                  // prefixIcon: Padding(
                  //   padding: EdgeInsets.only(left: 1.0),
                  //   child: Icon(Icons.directions_run, color: Colors.grey),
                  // ),
                ),
                value: studentName,
                hint: Text('Select Student'),
                items: studentNamesList
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    studentName = value;
                  });
                },
              ),
            ),
            StudymateTextField(
              labelText: 'Description',
              textEditingController: descriptionController,
              validation: 'name',
              icon: Icon(Icons.description, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 1, right: 1),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(),
                  ),
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(30.0, 10.0, 20.0, 10.0),
                  // prefixIcon: Padding(
                  //   padding: EdgeInsets.only(left: 1.0),
                  //   child: Icon(Icons.directions_run, color: Colors.grey),
                  // ),
                ),
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
            ),

            SizedBox(height: 15),

            /// Button Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                /// Create Appointment
                RaisedButton(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  child: Text("Create"),
                  onPressed: () {
                    /// Adding to DB
                    Future<Appointment> isAdded =
                        _appointmentService.createAppointment(Appointment(
                            null,
                            'specialDescription',
                            'date',
                            'time',
                            'place',
                            doctorName,
                            studentName,
                            false));

                    if (isAdded != null) {
                      Navigator.pop(context);
                    } else {
                      /// When something went wrong
                      // Navigator.pop(context);
                    }
                  },
                ),

                /// To make a gap between them
                SizedBox(width: 10),

                /// Cancel Button
                RaisedButton(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
