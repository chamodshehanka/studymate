import 'package:flutter/material.dart';
import 'dart:core';

import 'package:studymate/services/Authentication.dart';

// void main() => runApp(new MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'UI Profile',
//       home: new ProfileUIScreen(),
//     );
//   }
// }

class ProfileUIScreen extends StatefulWidget {
  _ProfileUIScreenState createState() => _ProfileUIScreenState();
}

class _ProfileUIScreenState extends State<ProfileUIScreen> {
   
  Color gradientStar = Colors.orange[200];
  BaseAuthentication _authentication = Authentication();

  Color gradientEnd = Colors.purple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
    Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  height: 200,
                  decoration: BoxDecoration(
                      gradient: new LinearGradient(
                        colors: [gradientStar, gradientEnd],
                      ),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50))),
                  child: Center(
                    child: Text('Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white,
                            fontStyle: FontStyle.italic)),
                  )),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Stack(
                        children: <Widget>[
                          Divider(height: 1, color: Colors.grey),
                          Container(
                              height: 100,
                              width: 350,
                              margin: EdgeInsets.only(top: 10),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  Card(
                                      elevation: 20,
                                      child: Container(
                                          padding: EdgeInsets.all(20),
                                          child: Column(
                                            children: <Widget>[
                                              Icon(Icons.person,
                                                  color: Colors.purple),
                                              Text('About')
                                            ],
                                          ))),
                                  Card(
                                    elevation: 20,
                                    child: Container(
                                        padding: EdgeInsets.all(20),
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Icons.book,
                                                color: Colors.purple),
                                            Text('Subjects')
                                          ],
                                        )),
                                  ),
                                  Card(
                                    elevation: 20,
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        children: <Widget>[
                                          Icon(Icons.local_activity,
                                              color: Colors.purple),
                                          Text('Activites')
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 20,
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        children: <Widget>[
                                          Icon(Icons.stars,
                                              color: Colors.purple),
                                          Text('Badges')
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 20,
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        children: <Widget>[
                                          Icon(Icons.report,
                                              color: Colors.purple),
                                          Text('Appointment')
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Divider(height: 5),
                          Container(
                              margin: EdgeInsets.only(top: 30, left: 5),
                              child: Column(
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Text(
                                      'Special Note',
                                      style: TextStyle(
                                          color: Colors.purple,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ])
                                ],
                              ))
                        ],
                      ))),
              Positioned(
                  top: 150,
                  child: Container(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('profile'),
                      )))
            ],
          ),
        ],
      ),
       floatingActionButton: FloatingActionButton(
        
        child: Icon(Icons.close, color: Colors.white),
        onPressed: () {
          _authentication.signOut();
          Navigator.pushNamed(context, '/welcome');
        },

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
  }
}
