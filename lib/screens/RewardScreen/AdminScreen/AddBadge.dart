import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:studymate/models/Activity.dart';
import 'package:studymate/models/Badge.dart';
import 'package:studymate/models/Subject.dart';
import 'package:studymate/services/custom/ActivityService.dart';
import 'package:studymate/services/custom/BadgeService.dart';
import 'package:studymate/services/custom/SubjectService.dart';
import 'package:studymate/widgets/StudymateTextField.dart';

class AddBadgeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AddBadgeScreenState();
  }
}

class AddBadgeScreenState extends State<AddBadgeScreen> {
  final BadgeService badgeService = BadgeService();
  final ActivityService activityService = ActivityService();
  final SubjectService subjectService = SubjectService();
  StreamSubscription<QuerySnapshot> socialActivitySubscription;
  StreamSubscription<QuerySnapshot> leisureActivitySubscription;
  StreamSubscription<QuerySnapshot> subjectSubscription;
  final _formKeyAddBadge = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final milestoneController = TextEditingController();
  final descriptionController = TextEditingController();
  List<Asset> images = [];
  String _error = '';

  List socialList = List();
  List leisureList = List();
  List subjectList = List();
  var type;
  var task;
  List taskList = List();
  File galleryFile;

  @override
  void initState() {
    super.initState();
    socialActivitySubscription?.cancel();
    socialActivitySubscription = activityService
        .getSocialActivityList()
        .listen((QuerySnapshot snapshot) {
      final List activities = snapshot.documents
          .map((documentSnapshot) =>
              Activity.fromMap(documentSnapshot.data).name)
          .toList();

      setState(() {
        this.socialList = activities;
      });
    });

    leisureActivitySubscription?.cancel();
    leisureActivitySubscription = activityService
        .getLeisureActivityList()
        .listen((QuerySnapshot snapshot) {
      final List activities = snapshot.documents
          .map((documentSnapshot) =>
              Activity.fromMap(documentSnapshot.data).name)
          .toList();

      setState(() {
        this.leisureList = activities;
      });
    });

    subjectSubscription?.cancel();
    subjectSubscription =
        subjectService.getSubjectList().listen((QuerySnapshot snapshot) {
      final List subjects = snapshot.documents
          .map(
              (documentSnapshot) => Subject.fromMap(documentSnapshot.data).name)
          .toList();

      setState(() {
        this.subjectList = subjects;
      });
    });
  }

 Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 1,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

   Future<void> removeAssets() async{
    List<Asset> resultList = [];
      setState(() {
      images = resultList;
    });
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = "";

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "iTech Support Solutions",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );

      for (var r in resultList) {
        var t = await r.filePath;
        print(t);
      }
    } on Exception catch (e) {
      error = e.toString();
    }
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    


    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Create A Badge'),
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return new ListView(
            children: <Widget>[
              Form(
                key: _formKeyAddBadge,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                          child: _error!= "" ? Text(_error.toString(),style: TextStyle(color: Colors.red),):Text("")
                        ),
                        SizedBox(
                          height: images.length!=0 ? 130 :0,
                          child: buildGridView(),
                        ),
                   RaisedButton(
                            color: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Text(
                                "Pick Images",
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white),
                              ),
                          onPressed: loadAssets,
                        ),
                    StudymateTextField(
                      labelText: 'Badge Name',
                      textEditingController: nameController,
                      validation: 'name',
                      icon: Icon(Icons.text_fields, color: Colors.grey),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(),
                              ),
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 10.0, 20.0, 10.0),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Icon(Icons.directions_run,
                                    color: Colors.grey),
                              )),
                          value: type,
                          hint: Text('Select Badge Type'),
                          items: ['Study', 'Social', 'Leisure']
                              .map((label) => DropdownMenuItem(
                                    child: Text(label),
                                    value: label,
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() => type = value);
                            setState(() {
                              switch (type) {
                                case "Social":
                                  taskList = socialList;
                                  break;
                                case "Leisure":
                                  taskList = leisureList;
                                  break;
                                case "Study":
                                  taskList = subjectList;
                                  break;
                                default:
                                  taskList = ["Select Type First"];
                              }
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(),
                              ),
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 10.0, 20.0, 10.0),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Icon(Icons.directions_run,
                                    color: Colors.grey),
                              )),
                          value: task,
                          hint: Text('Select Task'),
                          items: taskList
                              .map((label) => DropdownMenuItem(
                                    child: Text(label),
                                    value: label.toString(),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() => task = value);
                          },
                        ),
                      ),
                    ),
                    StudymateTextField(
                      labelText: 'Badge Milestone In Minutes',
                      textEditingController: milestoneController,
                      validation: 'TimeDuration',
                      icon: Icon(Icons.text_fields, color: Colors.grey),
                    ),
                    StudymateTextField(
                      labelText: 'Badge Description',
                      textEditingController: descriptionController,
                      validation: 'name',
                      icon: Icon(Icons.text_fields, color: Colors.grey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 10,
                          color: Colors.deepPurpleAccent,
                          textColor: Colors.white,
                          child: Text("Save"),
                          onPressed: () {
                            if (_formKeyAddBadge.currentState.validate()) {
                              Future<Badge> isAdded = badgeService.createBadge(
                                  nameController.text,
                                  type,
                                  task,
                                  milestoneController.text,
                                  descriptionController.text,
                                  galleryFile);
                              if (isAdded != null) {
                                Navigator.pop(context);
                              } else {
                                //Navigator.pop(context);
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
            ],
          );
        },
      ),
    );
  }

  Widget displaySelectedFile(File file) {
    return new SizedBox(
      height: 150.0,
      width: 150.0,
//child: new Card(child: new Text(''+galleryFile.toString())),
//child: new Image.file(galleryFile),
      child: file == null
          ? new Text('Sorry nothing selected!!')
          : new Image.file(file),
    );
  }
}
