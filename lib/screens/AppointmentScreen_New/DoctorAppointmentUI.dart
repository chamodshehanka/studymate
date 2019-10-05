import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/models/Appointment.dart';
import 'package:studymate/screens/AppointmentScreen_New/ManageAppointmentUI.dart';
import 'package:studymate/services/custom/AppointmentServiceNew.dart';
import 'package:studymate/widgets/StudymateTextField.dart';

class DoctorAppointmentListScreen extends StatefulWidget {
  _DoctorAppointmentListScreenState createState() =>
      _DoctorAppointmentListScreenState();
}

class _DoctorAppointmentListScreenState extends State<DoctorAppointmentListScreen> {
  List<Appointment> appointmentList;
  AppointmentServiceNew appointmentServiceNew = AppointmentServiceNew();
  StreamSubscription<QuerySnapshot> appointmentSubscription;
  //List<String> appointmentStatusList;

 // final statusController = TextEditingController();

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
  //appointmentStatusList = ['Approve', 'UnApprove'];
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
            child: Text(appointment.date,
              style:TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            appointment.time,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            appointment.place,
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

  Card makeCard(Appointment approveAppointment) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            child: buildTilesList(approveAppointment),
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
              return MaterialApp(debugShowCheckedModeBanner: false,
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
 showDialog(
     context: context,
     builder:(_){
       return StudymateDialog();
     });
 }
}
class StudymateDialog extends StatefulWidget {
  _StudymateDialogState createState() => _StudymateDialogState();
}

class _StudymateDialogState extends State<StudymateDialog> {
  
final _formKeyAddAppointment = GlobalKey<FormState>();
  final specialDescriptionController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final placeController = TextEditingController();
  AppointmentServiceNew appointmentServiceNew = AppointmentServiceNew();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: Text('Create New Appointment',textAlign: TextAlign.center,),
                backgroundColor: Colors.deepPurple[50],
                 content: Form(
                   key: _formKeyAddAppointment,
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                   mainAxisSize: MainAxisSize.min,
                   children: <Widget>[

         StudymateTextField('Date',dateController,'text',false,Colors.grey,TextInputType.text,
         Icon(Icons.date_range,color: Colors.grey, )),
                                  
         StudymateTextField('Time',timeController,'text',false,Colors.grey,TextInputType.text,
         Icon(Icons.timer,color: Colors.grey,)),
                        
         StudymateTextField('Place',placeController,'text',false,Colors.grey,TextInputType.text,
         Icon(Icons.edit_location,color: Colors.grey,)),

         new Flexible(fit: FlexFit.loose,
         child: new TextField (
           controller: specialDescriptionController,
         decoration: new InputDecoration(
           hintText: 'Special Description', ),
         maxLines: 2,),),

           SizedBox(height: 20) ,              
           Row(
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
                                 /*log('Appointment SpecialDescription : ' + appointmentspecialDescription);
                                 log('Appointment Date : ' + appointmentdate);
                                 log('Appointment Time : ' + appointmenttime);
                                 log('Appointment Place : ' + appointmentplace);*/
                                  if (_formKeyAddAppointment.currentState.validate()) {
                                        _formKeyAddAppointment.currentState.save();
                                        //Adding to DB
                                        Future<Appointment> isAdded =appointmentServiceNew
                                        .createAppointment(
                                            specialDescriptionController.text, dateController.text,timeController.text,placeController.text,); 
                                           if (isAdded != null) {
                                          Navigator.pop(context);
                                        } else {
                                          Navigator.pop(context);
                                          }
                    }
                  },
                ),
                SizedBox(width: 10),
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
