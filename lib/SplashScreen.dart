  
import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();

  
  
}

class _SplashScreenState extends State<SplashScreen>{

 void initState(){
    super.initState();
    Timer(Duration(seconds: 5),()=>Navigator.pushNamed(context, '/first'));
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color:Colors.blueAccent, 
              ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 65.0,
                child: Icon(
                  Icons.school,
                  color:Colors.black,
                  size:70.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:10.0),
              ),
              Text(
                'StudyMate',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                ),  
              ),
              Padding(
                padding: EdgeInsets.only(top:70.0),
              ),
              CircularProgressIndicator(),
            
            ],
          )
        ],
      )
    );
  }

  
}