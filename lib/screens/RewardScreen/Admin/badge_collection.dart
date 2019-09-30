import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/Badge.dart';
import 'package:studymate/services/custom/BadgeService.dart';

class BadgesScreen extends StatefulWidget {
  _BadgesScreenState createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  List<Badge> badgeList;
  BadgeService badgeService = BadgeService();
  StreamSubscription<QuerySnapshot> badgeSubscription;
  // final _formKey =

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
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white30)
                    )
                    ),
           child:Center(
             child:Padding(
               padding: EdgeInsets.all(8.0),
               child:Column(
                 children: <Widget>[
                   Container(
                     width:MediaQuery.of(context).size.width,
                     height: 350.0,
                     child: Padding(
                       padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
                      child: Material(
                        color: Colors.white,
                        elevation: 14.0,
                        //  shadowColor: Color(),
                        child:Center()
                      ),
                     ),
                    //  child: Image.network(
                    //   //  badge.Image,
                    //   //  fit:BoxFit.fill
                    //  ),
                    
                   ),
                   SizedBox(height: 10.0,),
                   Text(
                     badge.name,
                      style:
                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                     
                   ),
                    SizedBox(height: 10.0,),
                   Text(
                     badge.type,
                      style:
                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                     
                   ),
                   SizedBox(height: 10.0,),
                   Text(
                     badge.milestone,
                      style:
                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                     
                   ),
                   SizedBox(height: 10.0,),
                   Text(
                     badge.description,
                      style:
                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                     
                   ),

                 ],
               )
             )
           )
          // Text(
          //     badge.type,
          //     style:
          //         TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          //   ),
          // ),
          // title: Text(
          //   badge.name,
          //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          // ),
          

        //   trailing: Icon(Icons.open_in_new, color: Colors.white, size: 30.0),
        //   onTap: () => {_viewBadge(context)},
    )
    );

    Card makeCard(Badge badge) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.deepPurpleAccent),
            child: buildTilesList(badge),
          ),
        );

    final badgeBody = Container(
      child: ListView.builder(

          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: badgeList.length,
          itemBuilder: (BuildContext context, int index) {
            return makeCard(badgeList[index]);
          }
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


