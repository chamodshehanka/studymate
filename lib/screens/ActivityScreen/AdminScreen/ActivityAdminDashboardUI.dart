import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/models/Activity.dart';
import 'package:studymate/services/Authentication.dart';
import 'package:studymate/services/CloudFunctionsService.dart';
import 'package:studymate/services/custom/ActivityService.dart';
// import 'package:studymate/widgets/ActivitiesGraph/Graph.dart';
// import 'package:studymate/widgets/ActivitiesGraph/GraphData.dart';
import 'package:studymate/widgets/CurveClipper.dart';
import 'package:studymate/widgets/StudymateRaisedButton.dart';

class ActivityAdminDashboardScreen extends StatefulWidget {
  _ActivityAdminDashboardScreenState createState() =>
      _ActivityAdminDashboardScreenState();
}

class _ActivityAdminDashboardScreenState
    extends State<ActivityAdminDashboardScreen> with TickerProviderStateMixin {
  int noOfAllActivities = 0;
  int noOfLeisureActivities = 0;
  int noOfSocialActivities = 0;
  int noOfOtherActivities = 0;
  double countFontSize = 42;
  Color countNumColor = Colors.deepPurple;
  AnimationController _controller;
  Animation<double> _heightAnimation;
  Animation<double> _iconSizeAnimation;
  AnimationController _graphAnimationController;
  CloudFunctionService cloudFunctionService = CloudFunctionService();
  FirebaseMessaging _fcm = FirebaseMessaging();
  BaseAuthentication _authentication = Authentication();

  @override
  void initState() {
    super.initState();

    // To get activities count
    _getActivitiesCount();

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

    // fcm
    _fcm.configure(onMessage: (Map<String, dynamic> message) async {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: ListTile(
                  title: Text(message['notification']['title']),
                  subtitle: Text(message['notification']['body']),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ));
    }, onResume: (Map<String, dynamic> message) async {
      print('On Resume');
    }, onLaunch: (Map<String, dynamic> message) async {
      print('On launch');
    });

    _saveDeviceToken();
  }

  _saveDeviceToken() async {
    _authentication.getCurrentUser().then((userId) async {
      String uid = userId;
      String _fcmToken = await _fcm.getToken();
      if (_fcmToken != null) {
        var tokenRef = Firestore.instance
            .collection('admins')
            .document(uid)
            .collection('tokens')
            .document(_fcmToken);
        await tokenRef.setData({
          'token': _fcmToken,
          'createdAt': FieldValue.serverTimestamp(),
          'platform': Platform.operatingSystem
        });
      }
    });
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
      body: Column(
        children: <Widget>[
          Container(
            height: media.height,
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
                      'Activities Dashboard',
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
                        // Text(
                        //   'Activities Usage',
                        //   textAlign: TextAlign.left,
                        //   style: TextStyle(
                        //     color: Colors.deepPurple,
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        SizedBox(height: 50),
                        // Expanded(
                        //   child: Container(
                        //     child: _buildActivitiesChart(media),
                        //   ),
                        // ),
                        SizedBox(height: 5),
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
                                          'Manage Activities',
                                          viewActivitiesList,
                                          Colors.deepPurpleAccent),
                                    ),
                                    Container(
                                      width: 190,
                                      child: StudymateRaisedButton(
                                        'Activities Usage',
                                        viewActivitiesList,
                                        Colors.deepPurpleAccent,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 190,
                                      child: StudymateRaisedButton(
                                          'Send Message',
                                          sendMessage,
                                          Colors.deepPurpleAccent),
                                    ),
                                    Container(
                                      width: 190,
                                      child: StudymateRaisedButton(
                                          'Create Activity',
                                          sendMessage,
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
                                Navigator.pushNamed(
                                    context, '/adminActivityList');
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
                                Navigator.pushNamed(
                                    context, '/activityReports');
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
        ],
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

  // Have to impl
  // Widget _buildActivitiesChart(Size media) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: <Widget>[
  //       Container(
  //         alignment: Alignment.center,
  //         height: 100,
  //         child: InkWell(
  //           onTap: () {
  //             _graphAnimationController.forward();
  //           },
  //           child: Graph(
  //               animationController: _graphAnimationController,
  //               values: monthData),
  //         ),
  //       ),
  //     ],
  //   );
  // }

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
                          'Activities',
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          noOfAllActivities.toString(),
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
                          'Leisure',
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          noOfLeisureActivities.toString(),
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
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('assets/images/speaking.jpg'),
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
                        Text('Social',
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold)),
                        Text(noOfSocialActivities.toString(),
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
                    width: 75,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('assets/images/swimming.jpg'),
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
                        Text('Other',
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold)),
                        Text(noOfOtherActivities.toString(),
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

  // Get Activities count from Activity Collection
  void _getActivitiesCount() {
    Stream<QuerySnapshot> activityList = ActivityService().getActivityList();
    activityList.forEach((activity) {
      setState(() {
        noOfAllActivities = activity.documents.length;
        activity.documents.forEach((doc) {
          Activity activity = Activity.fromMap(doc.data);
          if (activity.type == 'Social') {
            noOfSocialActivities++;
          } else if (activity.type == 'Leisure') {
            noOfLeisureActivities++;
          }
        });
      });
    });
  }

  // View Activities List UI
  void viewActivitiesList() {
    Navigator.pushNamed(context, '/adminActivityList');
  }

  // View Activities Usage UI
  void viewActivitiesUsage() {}

  void sendMessage() {
    _authentication.getCurrentUser().then((authId) {
      cloudFunctionService.cloudNotificationFunction(authId);
    }).catchError((error) {
      log(error.toString());
    });
  }
}
