import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/models/Appointment.dart';
import 'package:studymate/screens/AppointmentScreen_New/ManageAppointmentUI.dart';
import 'package:studymate/services/custom/AppointmentServiceNew.dart';
import 'package:studymate/widgets/StudymateTextField.dart';

class AdminAppointmentListScreen extends StatefulWidget {
  _AdminAppointmentListScreenState createState() =>
      _AdminAppointmentListScreenState();
}

class _AdminAppointmentListScreenState extends State<AdminAppointmentListScreen> {
  List<Appointment> appointmentList;
  AppointmentServiceNew appointmentServiceNew = AppointmentServiceNew();
  StreamSubscription<QuerySnapshot> appointmentSubscription;
  List<String> appointmentTypeList;
  final _formKey = GlobalKey<FormState>();
  final specialDescriptionController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final placeController = TextEditingController();
  final typeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    appointmentList = List();
    appointmentSubscription?.cancel();
    appointmentSubscription =
        appointmentServiceNew.getAppointmentList().listen((QuerySnapshot snapshot) {
      final List<Appointment> appointment = snapshot.documents
          .map((documentSnapshot) => Appointment.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.appointmentList = appointment;
      });
    });

    // Dropdown Items load
    appointmentTypeList = ['Emergency', 'Not Emergency'];
  }

  @override
  void dispose() {
    appointmentSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    buildTilesList(Appointment appointment) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white30))),
            child: Text(
              appointment.type,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            appointment.specialDescription,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.mode_edit, color: Colors.white, size: 30.0),
          onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ManageAppointmentScreen(appointment: appointment)))
          },
        );

    Card makeCard(Appointment leisureActivity) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            child: buildTilesList(leisureActivity),
          ),
        );

    final adminAppointmentBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: appointmentList.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(appointmentList[index]);
        },
      ),
    );
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Manage Appointment List'),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: adminAppointmentBody,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: Icon(Icons.add),
          onPressed: () => _createNewAppointment(context),
        ),
      ),
    );
  }

  void _createNewAppointment(BuildContext context) async {
    String appointmentType;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text(
              'Create New Appointment',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.deepPurple[50],
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: StudymateTextField(
                        'Special Description',
                        specialDescriptionController,
                        'text',
                        false,
                        Colors.grey,
                        TextInputType.text,
                        Icon(
                          Icons.local_activity,
                          color: Colors.grey,
                        )),
                  ),Padding(
                    padding: EdgeInsets.all(8.0),
                    child: StudymateTextField(
                        'Date',
                        dateController,
                        'text',
                        false,
                        Colors.grey,
                        TextInputType.text,
                        Icon(
                          Icons.local_activity,
                          color: Colors.grey,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: StudymateTextField(
                        'Time',
                        timeController,
                        'text',
                        false,
                        Colors.grey,
                        TextInputType.text,
                        Icon(
                          Icons.local_activity,
                          color: Colors.grey,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: StudymateTextField(
                        'Place',
                        placeController,
                        'text',
                        false,
                        Colors.grey,
                        TextInputType.text,
                        Icon(
                          Icons.local_activity,
                          color: Colors.grey,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      
                      hint: Text('Appointment Type'),
                      value: appointmentType,
                      items: ["Emergency", "Not Emergency"]
                          .map((label) => DropdownMenuItem(
                                child: Text(label),
                                value: label,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          appointmentType = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 10,
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                          child: Text("Save"),
                          onPressed: () {
                            log('Appointment Type : ' + appointmentType);

                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              //Adding to DB
                              Future<Appointment> isAdded =
                                  AppointmentServiceNew().createAppointment(
                                  specialDescriptionController.text, dateController.text,timeController.text,placeController.text,typeController.text); 
                                 if (isAdded != null) {
                                Navigator.pop(context);
                              } else {
                                //Have to add error message
                                Scaffold.of(context).showSnackBar(new SnackBar(
                                  content: new Text('Failed to Add!'),
                                  backgroundColor: Colors.deepPurple,
                                ));
                              }
                            }
                          },
                        ),
                        // Test Dispose button
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
