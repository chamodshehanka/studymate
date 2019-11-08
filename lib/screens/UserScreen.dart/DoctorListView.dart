import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:studymate/models/Doctor.dart';
import 'package:studymate/services/custom/DoctorService.dart';
import 'package:studymate/widgets/StudymateDialogBox.dart';

class DoctorListView extends StatefulWidget {
  DoctorListView({Key key, this.title});
  final String title;

  @override
  _DoctorListViewState createState() => _DoctorListViewState();
}

class _DoctorListViewState extends State<DoctorListView> {
  List<Doctor> doctorList;
  DoctorService doctorService = DoctorService();
  StreamSubscription<QuerySnapshot> doctorssSubscription;

  @override
  void initState() {
    super.initState();

    doctorList = List();
    doctorssSubscription?.cancel();
    doctorssSubscription =
        doctorService.getAll().listen((QuerySnapshot snapshot) {
      final List<Doctor> doctors = snapshot.documents
          .map((documentSnapshot) => Doctor.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.doctorList = doctors;
      });
    });
  }

  @override
  void dispose() {
    doctorssSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Card makeCard(Doctor doctor) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Slidable(
            child: Container(
                decoration: BoxDecoration(color: Colors.deepPurpleAccent),
                child: buildTilesList(doctor)),
            actionPane: SlidableDrawerActionPane(),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Delete',
                color: Colors.redAccent,
                icon: Icons.delete,
                onTap: () => deleteDoctor(doctor),
              )
            ],
          ),
        );

    final studentBody = doctorList != null
        ? Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: doctorList.length,
              itemBuilder: (BuildContext context, int index) {
                if (doctorList[index].firstName != null &&
                    doctorList[index].lastName != null)
                  return makeCard(doctorList[index]);
                else
                  return null;
              },
            ),
          )
        : Container(
            alignment: Alignment.center,
            child: Text(
              'No Any Doctors!!',
              style: TextStyle(backgroundColor: Colors.red, fontSize: 15),
            ));

    return Scaffold(
      backgroundColor: Colors.white10,
      body: studentBody,
    );
  }

  buildTilesList(Doctor doctor) => ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white30))),
        child: Text(
          doctor.workPlace,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        doctor.firstName + " " + doctor.lastName,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      trailing: Icon(Icons.view_list),
      onTap: () {});

  void deleteDoctor(Doctor doctor) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StudymateDialogBox(
            title: 'Are you sure?',
            description: doctor.firstName +
                " " +
                doctor.lastName +
                ' ,Doctor will be permanently deleted!',
            confirmation: true,
            confirmationAction: () {
              Future<dynamic> isDeleted = doctorService.delete(doctor.id);
              isDeleted.then((result) {
                if (result) {
                  Scaffold.of(context).showSnackBar(new SnackBar(
                    content: new Text('Successfully Deleted'),
                    backgroundColor: Colors.green,
                  ));
                } else {
                  Scaffold.of(context).showSnackBar(new SnackBar(
                    content: new Text('Deletion Failed!'),
                    backgroundColor: Colors.redAccent,
                  ));
                }
              });
              Navigator.pop(context);
            },
            tigerAnimationType: 'fail',
          );
        });
  }
}
