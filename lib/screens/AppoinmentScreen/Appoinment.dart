import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  
  final _formKey = GlobalKey<FormState>();

  String _PatientID;
  String _SpecialDescription;
  String _Date;
  String _Time;
  String _Place;

  void ValidateAndSave(){
    final form =_formKey.currentState;
    if(form.validate()){
      form.save();
      print('Form is Valid.Patient ID: $_PatientID,Special Description: $_SpecialDescription, Date: $_Date, Time: $_Time, Place: $_Place');
    }else{
      print('Form is Invalid.Patient ID: $_PatientID,Special Description: $_SpecialDescription, Date: $_Date, Time: $_Time, Place: $_Place');
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
                      validator: (value) => value.isEmpty ? 'Appointment ID can\'t be empty':null
                     ),
                     new TextFormField(
                      decoration: new InputDecoration(labelText: 'Doctor ID',prefixIcon: Icon(Icons.account_circle)),
                      obscureText: true,
                      validator: (value) => value.isEmpty ? 'Doctor ID can\'t be empty':null
                     ),
                     new TextFormField(
                      decoration: new InputDecoration(labelText: 'Patient ID',prefixIcon: Icon(Icons.account_circle)),
                      obscureText: true,
                      validator: (value) => value.isEmpty ? 'patient ID can\'t be empty':null
                     ),
                      new TextFormField(
                      decoration: new InputDecoration(labelText: 'Special Description',prefixIcon: Icon(Icons.assignment)),
                      validator: (value) => value.isEmpty ? 'Special Description can\'t be empty':null
                     ),
                      new TextFormField(
                      decoration: new InputDecoration(labelText: 'Date',prefixIcon: Icon(Icons.calendar_today)),
                      validator: (value) => value.isEmpty ? 'Date can\'t be empty':null
                     ),
                      new TextFormField(
                      decoration: new InputDecoration(labelText: 'Time',prefixIcon: Icon(Icons.access_time )),
                      validator: (value) => value.isEmpty ? 'Time can\'t be empty':null
                     ),
                      new TextFormField(
                      decoration: new InputDecoration(labelText: 'Place',prefixIcon: Icon(Icons.edit_location )),
                      validator: (value) => value.isEmpty ? 'Place can\'t be empty':null
                     ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: 
                        RaisedButton(color:Colors.purple,textColor:Colors.white ,
                        elevation: 4.0,
                        splashColor: Colors.amberAccent,
                          child: Text("Request"),
                          onPressed: ValidateAndSave,
                        ),
                      )
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
