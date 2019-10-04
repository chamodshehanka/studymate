import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/Appointment.dart';
import 'package:studymate/services/custom/AppointmentServiceNew.dart';
import 'package:studymate/widgets/StudymateDialogBox.dart';
import 'package:studymate/widgets/StudymateTextField.dart';

class ManageAppointmentScreen extends StatefulWidget {
  final Appointment appointment;

  ManageAppointmentScreen({Key key, @required this.appointment});

  @override
  _ManageAppointmentScreenState createState() => _ManageAppointmentScreenState();
}

class _ManageAppointmentScreenState extends State<ManageAppointmentScreen> {
  final AppointmentServiceNew appointmentServiceNew = AppointmentServiceNew();

  final _formKey = GlobalKey<FormState>();
  final specialDescriptionController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final placeController = TextEditingController();
  final typeController = TextEditingController();


  @override
  void initState() {
    super.initState();
    specialDescriptionController.text = widget.appointment.specialDescription ;
    dateController.text = widget.appointment.date;
    timeController.text = widget.appointment.time ;
    placeController.text = widget.appointment.place ;

  }

  @override
  Widget build(BuildContext context) {
    // Appointment Delete Action
    void appointmentDeleteAction() {
      Future<dynamic> isDeleted =
          AppointmentServiceNew().deleteAppointment(widget.appointment.id);
      if (isDeleted != null) {
        Navigator.pop(context);
      } else {
        print('Appointment Delete Failed');
      }
    }

    void showDeleteConfirmationDialog() {
      if (widget.appointment.id != null) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return StudymateDialogBox(
                title: 'Are you sure?',
                description: widget.appointment.specialDescription +
                    ' appointment will be permanently deleted!',
                confirmation: true,
                confirmationAction: appointmentDeleteAction,
                tigerAnimationType: 'fail',
              );
            });
      } else {
        // showDialog<void>(
        //     context: context, child: Text('Something went wrong'));
      }
    }

    final manageAppointmentBody = Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
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
                child: TextFormField(
                  initialValue: widget.appointment.type,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 10,
                      color: Colors.deepPurpleAccent,
                      textColor: Colors.white,
                      child: Text('Save'),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          if (widget.appointment.id != null) {
                            Appointment updatedAppointment = Appointment(
                                widget.appointment.id,
                                specialDescriptionController.text,
                                dateController.text,
                                timeController.text,
                                placeController.text,
                                widget.appointment.type);

                            Future isUpdated =
                                AppointmentServiceNew().updateAppointment(updatedAppointment);
                            if (isUpdated != null) {
                              Navigator.pop(context);
                            }
                          } else {
                            print('Appointment id is not valid');
                          }
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 10,
                      color: Colors.redAccent,
                      textColor: Colors.white,
                      child: Text('Remove'),
                      onPressed: showDeleteConfirmationDialog,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Manage ' + widget.appointment.specialDescription + ' Appointment'),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: manageAppointmentBody,
      ),
    );
  }
}
