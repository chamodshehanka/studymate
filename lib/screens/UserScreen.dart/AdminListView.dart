import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:studymate/models/Admin.dart';
import 'package:studymate/services/custom/AdminServices.dart';
import 'package:studymate/services/custom/StudentService.dart';

class AdminListView extends StatefulWidget {
  AdminListView({Key key, this.title});
  final String title;

  @override
  _AdminListViewState createState() => _AdminListViewState();
}

class _AdminListViewState extends State<AdminListView> {
  List<Admin> adminList;
  AdminService adminService = AdminService();
  StudentService studentService = StudentService();
  StreamSubscription<QuerySnapshot> adminsSubscription;

  @override
  void initState() {
    super.initState();

    adminList = List();
    adminsSubscription?.cancel();
    adminsSubscription = adminService
        .getAll()
        .listen((QuerySnapshot snapshot) {
      final List<Admin> admins = snapshot.documents
          .map((documentSnapshot) => Admin.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.adminList = admins;
      });
    });

  }

  @override
  void dispose() {
    adminsSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Card makeCard(Admin admin) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Slidable(
            child: Container(
                decoration: BoxDecoration(color: Colors.deepPurpleAccent),
                child: buildTilesList(admin)),
            actionPane: SlidableDrawerActionPane(),
            secondaryActions: <Widget>[
              IconSlideAction(
                  caption: 'Delete',
                  color: Colors.redAccent,
                  icon: Icons.delete,
                  onTap: () => {}),
            ],
          ),
        );

    final adminBody = adminList != null
        ? Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: adminList.length,
              itemBuilder: (BuildContext context, int index) {
                return makeCard(adminList[index]);
              },
            ),
          )
        : Container(
            alignment: Alignment.center,
            child: Text(
              'No Any Administrators!!',
              style: TextStyle(backgroundColor: Colors.red, fontSize: 15),
            ));

    return Scaffold(
      backgroundColor: Colors.white10,
      body: adminBody,
    );
  }

  buildTilesList(Admin admin) => ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white30))),
        child: Text(
          admin.contactNo,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        admin.firstName+" "+admin.lastName,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      trailing:
          Icon(Icons.view_list),
      onTap: () {
      });

}
