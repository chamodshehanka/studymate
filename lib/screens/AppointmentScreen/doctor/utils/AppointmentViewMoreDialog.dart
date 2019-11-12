import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:studymate/models/Appointment.dart';
import 'package:studymate/services/custom/AppointmentService.dart';

class AppointmentViewMoreDialog extends StatefulWidget {
  final Appointment appointment;

  AppointmentViewMoreDialog({this.appointment});

  _AppointmentViewMoreDialogState createState() =>
      _AppointmentViewMoreDialogState();
}

class _AppointmentViewMoreDialogState extends State<AppointmentViewMoreDialog> {
  final _formKeyAppointment = GlobalKey<FormState>();
  AppointmentService _appointmentService = AppointmentService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        'Manage Appointment',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.deepPurple),
      ),
      content: Form(
        key: _formKeyAppointment,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Patient : ' + widget.appointment.studentName),
            Text('Description : ' + widget.appointment.description),
            Text('Doctor : ' + widget.appointment.doctorName),
            Text('Date : ' + widget.appointment.date),
            Text('Time : ' + widget.appointment.time),
            Text('Place : ' + widget.appointment.place),

            SizedBox(height: 15),

            /// Button Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                /// Change Appointment Button
                RaisedButton(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  child: Text("Edit"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                SizedBox(width: 10),

                ///Approve Action
                RaisedButton(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.deepPurpleAccent,
                  textColor: Colors.white,
                  child: Text("Approve"),
                  onPressed: () {
                    Appointment appointment = Appointment(
                      widget.appointment.id,
                      widget.appointment.description,
                      widget.appointment.date,
                      widget.appointment.time,
                      widget.appointment.place,
                      widget.appointment.doctorName,
                      widget.appointment.studentName,
                      true,
                    );

                    Future<dynamic> isUpdated =
                        _appointmentService.updateAppointment(appointment);

                    isUpdated.then((result) {
                      log(result.toString());
                    });
                  },
                ),
              ],
            ),

            /// Cancel Action
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
      ),
    );
  }
}
