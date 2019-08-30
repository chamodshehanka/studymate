import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  String _appointmentID = "";
  String _doctorID = "";
  String _patientID = "";
  String _specialDescription = "";
  String _date = "";
  String _time = "";
  String _place = "";

  final _formKey = GlobalKey<FormState>();
  

  void validateAndSave(){
    final form =_formKey.currentState;
    if(form.validate()){
      form.save();
      print('Form is Valid.Appointment ID:$_appointmentID,Doctor ID:$_doctorID,Patient ID: $_patientID,Special Description: $_specialDescription, Date: $_date, Time: $_time, Place: $_place');
    }else{
      print('Form is Invalid.Appointment ID:$_appointmentID,Doctor ID:$_doctorID,Patient ID: $_patientID,Special Description: $_specialDescription, Date: $_date, Time: $_time, Place: $_place');
    }
  }
  @override
  Widget build(BuildContext context) {
    var floatingActionButton2 = FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                //Create Form
                content: Form(
                  key: _formKey,
                  //New column
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new TextFormField(
                      decoration: new InputDecoration(labelText: 'Appointment ID',prefixIcon: Icon(Icons.account_circle)),
                      obscureText: true,
                      onSaved: (value) => _appointmentID = value,
                      validator: (value) => value.isEmpty ? 'Appointment ID can\'t be empty':null
                     ),
                     new TextFormField(
                      decoration: new InputDecoration(labelText: 'Doctor ID',prefixIcon: Icon(Icons.account_circle)),
                      onSaved: (value) => _doctorID = value,
                      obscureText: true,
                      validator: (value) => value.isEmpty ? 'Doctor ID can\'t be empty':null
                     ),
                     new TextFormField(
                      decoration: new InputDecoration(labelText: 'Patient ID',prefixIcon: Icon(Icons.account_circle)),
                      obscureText: true,
                      onSaved: (value) => _patientID = value,
                      validator: (value) => value.isEmpty ? 'patient ID can\'t be empty':null
                     ),
                      new TextFormField(
                      decoration: new InputDecoration(labelText: 'Special Description',prefixIcon: Icon(Icons.assignment)),
                      onSaved: (value) => _specialDescription = value,
                      validator: (value) => value.isEmpty ? 'Special Description can\'t be empty':null
                     ),
                      new TextFormField(
                      decoration: new InputDecoration(labelText: 'Date',prefixIcon: Icon(Icons.calendar_today)),
                      onSaved: (value) => _date = value,
                      validator: (value) => value.isEmpty ? 'Date can\'t be empty':null
                     ),
                      new TextFormField(
                      decoration: new InputDecoration(labelText: 'Time',prefixIcon: Icon(Icons.access_time )),
                      onSaved: (value) => _time = value,
                      validator: (value) => value.isEmpty ? 'Time can\'t be empty':null
                     ),
                      new TextFormField(
                      decoration: new InputDecoration(labelText: 'Place',prefixIcon: Icon(Icons.edit_location )),
                      onSaved: (value) => _place = value,
                      validator: (value) => value.isEmpty ? 'Place can\'t be empty':null
                     ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: 
                        RaisedButton(
                        color:Colors.purple,textColor:Colors.white ,
                        elevation: 4.0,
                        splashColor: Colors.amberAccent,
                          child: Text("Request"),
                         onPressed: validateAndSave,
                      ))
                    ],
                  ),
                ),
              );
            });
      },
      child: Icon(Icons.add),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Management"),
      ),
      body: getNoteListView(),
      floatingActionButton: floatingActionButton2,
    );
  }

  getNoteListView() {}
}
