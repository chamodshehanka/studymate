import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/Appointment.dart';
import 'package:studymate/services/custom/AppointmentService.dart';
import 'package:studymate/widgets/StudymateDialogBox.dart';
import 'package:studymate/widgets/StudymateTextField.dart';

class ManageAppointmentScreen extends StatefulWidget {
  final Appointment appointment;

  ManageAppointmentScreen({Key key, @required this.appointment});

  @override
  _ManageAppointmentScreenState createState() => _ManageAppointmentScreenState();
}

class _ManageAppointmentScreenState extends State<ManageAppointmentScreen> {
  final AppointmentService appointmentService = AppointmentService();

  final _formKey = GlobalKey<FormState>();
  final specialDescriptionController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final placeController = TextEditingController();
  final statusController = TextEditingController();


  @override
  void initState() {
    super.initState();
    specialDescriptionController.text = widget.appointment.specialDescription ;
    dateController.text = widget.appointment.date;
    timeController.text = widget.appointment.time ;
    placeController.text = widget.appointment.place ;
    //statusController.text = widget.appointment.status ;

  }

  @override
  Widget build(BuildContext context) {
    // Appointment Delete Action
    void appointmentDeleteAction() {
      Future<dynamic> isDeleted =
          AppointmentService().deleteAppointment(widget.appointment.id);
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
                child:StudymateTextField('Date',dateController,'text',false,Colors.grey,TextInputType.text,
         Icon(Icons.date_range,color: Colors.grey, )),
         ),             
          Padding(
                padding: EdgeInsets.all(8.0),
                child:StudymateTextField('Time',timeController,'text',false,Colors.grey,TextInputType.text,
         Icon(Icons.timer,color: Colors.grey,)),
          ),
          Padding(
                padding: EdgeInsets.all(8.0),
                child:StudymateTextField('Place',placeController,'text',false,Colors.grey,TextInputType.text,
         Icon(Icons.edit_location,color: Colors.grey,)),
          ),

         new Flexible(fit: FlexFit.loose,child: new TextField (
         decoration: new InputDecoration(hintText: 'Special Description', ),
         maxLines: 2,),),
                  
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
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
                                /*widget.appointment.status*/);

                            Future isUpdated =
                                AppointmentService().updateAppointment(updatedAppointment);
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
