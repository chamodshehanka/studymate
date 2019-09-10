// import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/Badge.dart';
import 'package:studymate/services/BadgeService.dart';

class NewBadgeScreen extends StatefulWidget {
  final BadgeService badgeService = BadgeService();

  @override
  _NewBadgeScreenState createState() => _NewBadgeScreenState();
}

class _NewBadgeScreenState extends State<NewBadgeScreen> {
  //void initState(){

  //}

  BadgeService badgeService = new BadgeService();
  String name, description;
  String milestone;
  final nameController = new TextEditingController();
  final typeController = new TextEditingController();
  final milestoneController = new TextEditingController();
  final descriptionController = new TextEditingController();

  // getName(name){
  //   this.name= name;
  // }
  // getMilestone(milestone){
  //   this.milestone= milestone;
  // }
  // getDescription(description){
  //   this.description= description;
  // }

  // int _badgeType = 0;
  String badgeVal;

  // void _handleBadgeType(int value){
  //   setState(() {
  //    _badgeType=value;

  //    switch(_badgeType){
  //      case 1:
  //       badgeVal= 'Subject';
  //       break;
  //     case 2:
  //         badgeVal='Activity';
  //         break;

  //    }
  //   });
  // }

  // createData(){
  //   DocumentReference db = Firestore.instance.collection('badges').document('badgename');
  //   Map<String,dynamic> badges={
  //     "badgename":name,
  //     "badgetype":badgeVal,
  //     "milestones":milestone,
  //     "description":description,
  //   };

  //   db.setData(badges).whenComplete((){
  //     print("Badge Created");
  //   });
  // }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController badgeNameCtrl = TextEditingController();
  final TextEditingController typeCtrl = TextEditingController();
  final TextEditingController milestoneCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();

  var type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " Create New Badge",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Color(0xFF18D191), size: 10.0),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      height: 180.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.indigo, width: 3.0),
                          right: BorderSide(color: Colors.indigo, width: 3.0),
                          left: BorderSide(color: Colors.indigo, width: 3.0),
                          bottom: BorderSide(color: Colors.indigo, width: 3.0),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: FlatButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/image_bank'), //popup
                        child: Icon(Icons.camera, color: Colors.grey.shade500),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    // onChanged:(String name){
                    //        getName(name);
                    //   },
                    keyboardType: TextInputType.text,
                    controller: nameController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter Badge Name';
                      } else
                        return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      labelText: "Badge Name",
                      labelStyle: TextStyle(
                          color: Colors.indigo, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  DropdownButtonFormField<String>(
                    //controller:typeController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      labelText: "Badge Type",
                      labelStyle: TextStyle(
                          color: Colors.indigo, fontWeight: FontWeight.bold),
                    ),

                    value: type,
                    items: ["Subject", "Activity"]
                        .map((label) => DropdownMenuItem(
                              child: Text(label),
                              value: label,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() => type = value);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: milestoneController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter Milestone';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      labelText: "Milestone",
                      labelStyle: TextStyle(
                          color: Colors.indigo, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    maxLines: 4,
                    keyboardType: TextInputType.text,
                    controller: descriptionController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter Badge Description';
                      } else
                        return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      labelText: "Badge Description",
                      labelStyle: TextStyle(
                          color: Colors.indigo, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 15.0, top: 15.0, right: 15.0, left: 15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                              child: Text('ADD'),
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState.validate()) {
                                    createBadge(
                                        nameController.text,
                                        "",
                                        milestoneController.text,
                                        descriptionController.text);
                                  }
                                });
                              }),
                        ),
                        Container(
                          width: 15.0,
                        ),
                        Expanded(
                            child: RaisedButton(
                          child: Text('CLEAR'),
                          onPressed: () {},
                        ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Badge> createBadge(
      String name, String type, String milestone, String description) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(badgeCollection.document());

      final Badge badge =
          new Badge(ds.documentID, name, type, milestone, description);
      final Map<String, dynamic> data = badge.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Badge.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }
}
