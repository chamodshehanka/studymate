import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/models/Subject.dart';
import 'package:studymate/services/CloudFunctionsService.dart';
import 'package:studymate/services/custom/SubjectService.dart';
import 'package:studymate/widgets/SubjectsGraph/SubGraph.dart';
import 'package:studymate/widgets/SubjectsGraph/SubGraphData.dart';
import 'package:studymate/widgets/CurveClipper.dart';
import 'package:studymate/widgets/StudymateRaisedButton.dart';

class SubjectAdminDashboardScreen extends StatefulWidget {
  _SubjectAdminDashboardScreenState createState() =>
      _SubjectAdminDashboardScreenState();
}

class _SubjectAdminDashboardScreenState
    extends State<SubjectAdminDashboardScreen> with TickerProviderStateMixin {
  int noOfAllSubjects = 0;
  int noOfGrade89Subjects = 0;
  int noOfOLevelSubjects = 0;
  int noOfALevelSubjects = 0;
  AnimationController _controller;
  Animation<double> _heightAnimation;
  Animation<double> _iconSizeAnimation;
  AnimationController _graphAnimationController;
  CloudFunctionService cloudFunctionService = CloudFunctionService();

  @override
  void initState() {
    super.initState();

    // To get subjects count
    _getSubjectsCount();

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

    // Graph Animations
    _graphAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  @override
  void dispose() {
    _graphAnimationController.dispose();
    super.dispose();
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
              top: 50,
              width: media.width,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Subjects Dashboard',
                  style: TextStyle(color: Colors.white, fontSize: 20),
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
                    Text(
                      'Subjects Usage',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    Expanded(
                      child: Container(
                        child: _buildSubjectsChart(media),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Recent Actions',
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
                                      'All Subjects',
                                      viewSubjectsList,
                                      Colors.deepPurpleAccent),
                                ),
                                Container(
                                  width: 190,
                                  child: StudymateRaisedButton(
                                      'Subjects Usage',
                                      viewSubjectsList,
                                      Colors.deepPurpleAccent),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 190,
                                  child: StudymateRaisedButton('Send Message',
                                      sendMessage, Colors.deepPurpleAccent),
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
                            Navigator.pushNamed(context, '/adminSubjectList');
                            _controller.reverse();
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
                            _controller.reverse();
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
                            Navigator.pushNamed(context, '/subjectReports');
                            _controller.reverse();
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

  // Widget _buildRoomItem(BoxConstraints constraints, Size media) {
  //   return Container();
  // }

  // Have to impl
  Widget _buildSubjectsChart(Size media) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 100,
          child: InkWell(
            onTap: () {
              _graphAnimationController.forward();
            },
            child: SubGraph(
                animationController: _graphAnimationController,
                values: monthData),
          ),
        ),
      ],
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
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage('assets/images/kids.png'),
                          fit: BoxFit.contain),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'No of all subjects',
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          noOfAllSubjects.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
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
                    width: 75,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('assets/images/leisure.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Grade89 subjects',
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          noOfGrade89Subjects.toString(),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
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
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('assets/images/grade89.jpg'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('OLevel Subjects',
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold)),
                        Text(noOfOLevelSubjects.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15)),
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
                    width: 75,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('assets/images/ol.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('ALevel Subjects',
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold)),
                        Text(noOfALevelSubjects.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15)),
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

  // Get Activities count from Activity Collection
  void _getSubjectsCount() {
    Stream<QuerySnapshot> subjectList = SubjectService().getSubjectList();
    subjectList.forEach((subject) {
      setState(() {
        noOfAllSubjects = subject.documents.length;
        subject.documents.forEach((doc) {
          Subject subject = Subject.fromMap(doc.data);
          if (subject.type == 'Grade89') {
            noOfGrade89Subjects++;
          } else if (subject.type == 'OLevel') {
            noOfOLevelSubjects++;
          }
        });
      });
    });
  }

  // View Subjects List UI
  void viewSubjectsList() {
    Navigator.pushNamed(context, '/adminSubjectList');
  }

  // View Subjects Usage UI
  void viewSubjectsUsage() {}

  void sendMessage() {
    cloudFunctionService
        .sendMessageToParent('Student has not updated his journal!')
        .then((onValue) {
      log(onValue.toString());
    }).catchError((error) {
      log(error.toString());
    });
  }
}
