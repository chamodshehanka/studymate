import 'package:flutter/material.dart';
import 'package:googleapis/datastore/v1.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  
  final _formKey = GlobalKey<FormState>();

  int _PatientID;
  String _SpecialDescription;
  int _Date;
  int _Time;
  String _Place;

  void ValidateAndSave(){
    final form =_formKey.currentState;
    if(form.validate()){
      print('Form is Valid');
    }else{
      print('Form is Invalid');
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
                      decoration: new InputDecoration(labelText: 'Patient ID'),
                      obscureText: true,
                      validator: (value) => value.isEmpty ? 'patient ID can\'t be empty':null
                     ),
                      new TextFormField(
                      decoration: new InputDecoration(labelText: 'Special Description'),
                      validator: (value) => value.isEmpty ? 'Special Description can\'t be empty':null
                     ),
                      new TextFormField(
                      decoration: new InputDecoration(labelText: 'Date'),
                      validator: (value) => value.isEmpty ? 'Date can\'t be empty':null
                     ),
                      new TextFormField(
                      decoration: new InputDecoration(labelText: 'Time'),
                      validator: (value) => value.isEmpty ? 'Time can\'t be empty':null
                     ),
                      new TextFormField(
                      decoration: new InputDecoration(labelText: 'Place'),
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
