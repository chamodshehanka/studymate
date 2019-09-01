import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/MedicalRecord.dart';
import 'package:studymate/services/custom/MedicalRecordService.dart';

class MedicalRecordUIScreen extends StatefulWidget {
  _MedicalRecordScreenState createState() => _MedicalRecordScreenState();
}

class _MedicalRecordScreenState extends State<MedicalRecordUIScreen> {
  List<MedicalRecord> medicalRecordList;
  MedicalRecordService medicalRecordService = MedicalRecordService();
  StreamSubscription<QuerySnapshot> medicalRecordSubscription;
  // final _formKey =

  @override
  void initState() {
    super.initState();

    medicalRecordList = List();
    medicalRecordSubscription?.cancel();
    medicalRecordSubscription =
        medicalRecordService.getAll().listen((QuerySnapshot snapshot) {
      final List<MedicalRecord> medicalRecords = snapshot.documents
          .map((documentSnapshot) =>
              MedicalRecord.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.medicalRecordList = medicalRecords;
      });
    });
  }

  @override
  void dispose() {
    medicalRecordSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    buildTilesList(MedicalRecord medicalRecord) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white30))),
            child: Text(
              medicalRecord.date,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            medicalRecord.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.mode_edit, color: Colors.white, size: 30.0),
          onTap: () => {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ManageActivityScreen(activity: activity)
            //   )
            // )
          },
        );

    Card makeCard(MedicalRecord medicalRecord) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            child: buildTilesList(medicalRecord),
          ),
        );

    final medicalRecordBody = Container(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: medicalRecordList.length,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(medicalRecordList[index]);
          }),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Records'),
        backgroundColor: Colors.deepPurple,
      ),
      body: medicalRecordBody,
    );
  }
}
