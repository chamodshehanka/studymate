
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/models/Admin.dart';
import 'package:studymate/models/Doctor.dart';
import 'package:studymate/models/Student.dart';
import 'package:studymate/services/custom/AdminServices.dart';
import 'package:studymate/services/custom/DoctorService.dart';
import 'package:studymate/services/custom/StudentService.dart';
import 'package:studymate/widgets/CurveClipper.dart';
import 'package:studymate/widgets/StudymateRaisedButton.dart';

class UserManagerScreen extends StatefulWidget {
  _UserManagerScreenState createState() =>
      _UserManagerScreenState();
}

class _UserManagerScreenState
    extends State<UserManagerScreen> with TickerProviderStateMixin {
  int noOfAllUsers = 0;
  int noOfDoctors = 0;
  int noOfStudents = 0;
  int noOfAdmins = 0;
  double countFontSize = 42;
  Color countNumColor = Colors.deepPurple;
  StreamSubscription<QuerySnapshot> studentsSubscription;
  StreamSubscription<QuerySnapshot> adminsSubscription;
  StreamSubscription<QuerySnapshot> doctorsSubscription;
  StudentService studentService = StudentService();
  AdminService adminService = AdminService();
  DoctorService doctorService = DoctorService();
  AnimationController _controller;
  Animation<double> _heightAnimation;
  Animation<double> _iconSizeAnimation;

    @override
  void initState() {
    super.initState();

     studentsSubscription?.cancel();
    studentsSubscription = studentService
        .getStudentList()
        .listen((QuerySnapshot snapshot) {
      final List<Student> students = snapshot.documents
          .map((documentSnapshot) => Student.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.noOfStudents = students.length;
        this.noOfAllUsers+=noOfStudents;
      });
    });


    adminsSubscription?.cancel();
    adminsSubscription = adminService
        .getAll()
        .listen((QuerySnapshot snapshot) {
      final List<Admin> admins = snapshot.documents
          .map((documentSnapshot) => Admin.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.noOfAdmins = admins.length;
        this.noOfAllUsers+=noOfAdmins;
      });
    });

    doctorsSubscription?.cancel();
    doctorsSubscription = adminService
        .getAll()
        .listen((QuerySnapshot snapshot) {
      final List<Doctor> doctors = snapshot.documents
          .map((documentSnapshot) => Doctor.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.noOfDoctors = doctors.length;
        this.noOfAllUsers+=noOfDoctors;
      });
    });

    // Theme block
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _heightAnimation = new Tween<double>(begin: 0.0, end: 220.0).animate(
        new CurvedAnimation(curve: Curves.decelerate, parent: _controller));

    _iconSizeAnimation = new Tween<double>(begin: 10, end: 35.0).animate(
        new CurvedAnimation(curve: Curves.easeOut, parent: _controller));

    // Adding listner to animation controller
    _controller.addListener(() {
      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: media.height,
        width: media.width,
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: CurveClipper(),
              child: Container(
                width: media.width,
                height: media.height * .25,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff5f27cd), Color(0xff341f97)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 30,
              width: media.width,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'User Dashboard',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
            Positioned(
              top: media.height * .08,
              width: media.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 20,
                ),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xffeff2f3),
                          offset: Offset(1, 5.0),
                          blurRadius: 3.0)
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      buildDashboardRow1(),
                      Divider(
                        color: Colors.grey,
                        height: 1,
                      ),
                      buildDashboardRow2(),
                    ],
                  ),
                ),
              ),
            ),
            // Second position Layer
            Positioned(
              top: media.height * .38,
              height: (media.height * .66) - 100,
              width: media.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 100),
                    Text(
                      'Quick Actions',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.deepPurple),
                    ),
                    SizedBox(height: 5),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 190,
                                  child: StudymateRaisedButton(
                                      'Manage Admins',
                                      manageAdmins,
                                      Colors.deepPurpleAccent),
                                ),
                                Container(
                                  width: 190,
                                  child: StudymateRaisedButton(
                                    'Manage Doctors',
                                    manageDoctors,
                                    Colors.deepPurpleAccent,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 190,
                                  child: StudymateRaisedButton('Manage Students',
                                      manageStudents, Colors.deepPurpleAccent),
                                ),
                                Container(
                                  width: 190,
                                  child: StudymateRaisedButton(
                                      'Admin Home',
                                      goToAdminHome,
                                      Colors.deepPurpleAccent),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Floating Menu Overlay
            Positioned(
              top: 0,
              child: FadeTransition(
                opacity: _controller,
                child: GestureDetector(
                  onTap: () {
                    _controller.reverse();
                  },
                  child: Container(
                    width: _heightAnimation.value > 5 ? media.width : 0,
                    height: _heightAnimation.value > 5 ? media.height : 0,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            Positioned(
              width: 56, // width of floating button
              height: _heightAnimation.value,
              bottom: 28, // middle of floating button
              left: (media.width / 2) + 134,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Visibility(
                        visible: _heightAnimation.value > 210,
                        child: IconButton(
                          icon: Icon(
                            Icons.list,
                            color: Colors.white,
                            size: _iconSizeAnimation.value,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/adminActivityList');
                          },
                        ),
                      ),
                      Visibility(
                        visible: _heightAnimation.value > 160,
                        child: IconButton(
                          icon: Icon(
                            Icons.history,
                            color: Colors.white,
                            size: _iconSizeAnimation.value,
                          ),
                          onPressed: () {
                            // impl
                          },
                        ),
                      ),
                      Visibility(
                        visible: _heightAnimation.value > 90,
                        child: IconButton(
                          icon: Icon(
                            Icons.insert_drive_file,
                            color: Colors.white,
                            size: _iconSizeAnimation.value,
                          ),
                          onPressed: () {
                            // Report generating UI
                            Navigator.pushNamed(context, '/activityReports');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        heroTag: null,
        backgroundColor: Colors.deepPurpleAccent,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget child) {
            return Transform(
              transform:
                  new Matrix4.rotationZ(_controller.value * 0.5 * 22 / 7.0),
              alignment: FractionalOffset.center,
              child: Icon(_controller.isDismissed ? Icons.menu : Icons.close),
            );
          },
        ),
        onPressed: () {
          if (_controller.isDismissed) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        },
      ),
    );
  }

Widget buildDashboardRow1() {
    return Expanded(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 70,
                    child: Icon(Icons.supervised_user_circle,size: 80,),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Users',
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          noOfAllUsers.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: countFontSize,
                              color: countNumColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(color: Colors.grey, width: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 70,
                    child: Icon(Icons.school,size: 80,),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Students',
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          noOfStudents.toString(),
                          style: TextStyle(
                              color: countNumColor,
                              fontWeight: FontWeight.w500,
                              fontSize: countFontSize),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDashboardRow2() {
    return Expanded(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 70,
                    child: Icon(Icons.local_hospital,size: 80,),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Doctors',
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold)),
                        Text(noOfDoctors.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: countFontSize,
                                color: countNumColor))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(
            color: Colors.grey,
            width: 1,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                   Container(
                    width: 70,
                    child: Icon(Icons.settings,size: 80,),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Admins',
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold)),
                        Text(noOfAdmins.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: countFontSize,
                                color: countNumColor)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  void manageDoctors() {
    Navigator.pushNamed(context, '/doctorManage');
  }


  void manageStudents() {
    Navigator.pushNamed(context, '/studentManage');
  }

  void manageAdmins() {
    Navigator.pushNamed(context, '/adminManage');
  }

  void goToAdminHome() {
    Navigator.pushNamed(context, '/homeAdmin');
  }
}
