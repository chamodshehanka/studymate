import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OtherActivityTab extends StatefulWidget {
  @override
  _OtherActivityTabState createState() => _OtherActivityTabState();
}

class _OtherActivityTabState extends State<OtherActivityTab> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('activity').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text(snapshot.connectionState.toString());
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document['title']),
                  subtitle: new Text(document['time']),
                );
              }).toList(),
            );
        }
      },
    );

    // return Scaffold(
    //   backgroundColor: Colors.white10,
    //   body: Container(
    //     padding: EdgeInsets.all(50.0),
    //     child: Text(
    //       '',
    //       style: TextStyle(
    //           color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 25),
    //       textAlign: TextAlign.center,
    //     ),
    //   ),
    // );
  }
}
