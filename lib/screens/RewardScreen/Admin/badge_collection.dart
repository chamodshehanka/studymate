import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/Badge.dart';
import 'package:studymate/services/custom/BadgeService.dart';
//import 'package:studymate/Screens/RewardScreen/Admin/new_badge.dart';

class BadgesScreen extends StatefulWidget {
  _BadgesScreenState createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  List<Badge> badgeList;
     BadgeService badgeService = BadgeService();
  StreamSubscription<QuerySnapshot> badgeSubscription;
  

  @override
  void initState() {
    super.initState();

    badgeList = List();
    badgeSubscription?.cancel();
    badgeSubscription =
        badgeService.getBadgeList().listen((QuerySnapshot snapshot) {
      final List<Badge> badgeCollection = snapshot.documents
          .map((documentSnapshot) =>
              Badge.fromMap(documentSnapshot.data))
          .toList();
      setState(() { 
        this.badgeList = badgeCollection;
      });
    });
  }

  @override
  void dispose() {
    badgeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    buildTilesList(Badge badge) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            child:Hero(

            tag: badge.name,
            child: Column(children: <Widget>[
              Material(
                child: InkWell(
                    onTap: () {
                  
                    },
            
            child: Container(
              child: Container(
                child: Column(
                  children: <Widget>[
                                           
                     Container(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text(
                              badge.name,
                              style: TextStyle(color: Colors.black, fontSize: 18.0)),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text(
                              badge.milestone,
                              style: TextStyle(color: Colors.black, fontSize: 18.0)),
                        ),
                      ),
                  ],
                )
              ),
            ),
            ),

          
     ) 
            ]
            )
          )
    )
    );

    Card makeCard(Badge badge) => Card(
          elevation: 8.0,
          
          margin: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 12.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
               borderRadius: BorderRadius.circular(24.0),
                
            ),
            child: buildTilesList(badge),
          ),
        );

    final badgeBody = Container(
      child: GridView.builder(
          gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: badgeList.length,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(badgeList[index]);
          }, 
          ),
    );
 
   
    return Scaffold(
        appBar: AppBar(
          title: Text('Badge Collection'),
          backgroundColor: Colors.deepPurple,
        ),
        body: badgeBody,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(context, '/new_badge'),
        )
        );
  }
}




 
