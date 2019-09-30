import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class MessageHandler extends StatefulWidget {
  _MessageHandlerState createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    _fcm.configure(onMessage: (Map<String, dynamic> message) async {
      print('onMessage : $message');
    }, onResume: (Map<String, dynamic> message) async {
      print('onResume : $message');
    }, onLaunch: (Map<String, dynamic> message) async {
      print('onLaunch : $message');
    });

    // Remove this
    _db.toString();
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

// https://www.youtube.com/watch?v=2TSm2YGBT1s
