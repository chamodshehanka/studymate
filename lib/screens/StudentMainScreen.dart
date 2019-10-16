import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:studymate/screens/StudentPlaceHolder.dart';
import 'package:studymate/services/Authentication.dart';

class StudentMainScreen extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _StudentMainScreenState();
  }
}

class _StudentMainScreenState extends State<StudentMainScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    StudentPlaceholder(0),
    StudentPlaceholder(1),
    StudentPlaceholder(2),
    StudentPlaceholder(3),
  ];
  FirebaseMessaging _fcm = FirebaseMessaging();
  BaseAuthentication _authentication = Authentication();

  @override
  void initState() {
    super.initState();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: FabCircularMenu(
          child: Container(
            child: _children[_currentIndex],
          ),
          ringColor: Colors.deepPurple,
          ringDiameter: 200.0,
          ringWidth: 60.0,
          options: <Widget>[
            IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  Navigator.pushNamed(context, '/daily');
                },
                iconSize: 30.0,
                color: Colors.white),
            IconButton(
                icon: Icon(Icons.schedule),
                onPressed: () {},
                iconSize: 30.0,
                color: Colors.white),
            IconButton(
                icon: Icon(Icons.chat),
                onPressed: () {},
                iconSize: 30.0,
                color: Colors.white),
            IconButton(
                icon: Icon(Icons.track_changes),
                onPressed: () {
                  Navigator.pushNamed(context, '/studentDailyReport');
                },
                iconSize: 30.0,
                color: Colors.white),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.deepPurple,
          buttonBackgroundColor: Colors.deepPurple,
          backgroundColor: Colors.white,
          items: <Widget>[
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.calendar_today, size: 30, color: Colors.white),
            Icon(Icons.favorite, size: 30, color: Colors.white),
            Icon(Icons.person, size: 30, color: Colors.white),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
