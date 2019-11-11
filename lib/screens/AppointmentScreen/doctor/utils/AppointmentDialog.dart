import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studymate/services/custom/AppointmentService.dart';
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
            StudymateTextField(
              labelText: 'Description',
              textEditingController: descriptionController,
              validation: 'name',
              icon: Icon(Icons.description, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
