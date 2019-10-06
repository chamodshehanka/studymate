import 'package:flutter/material.dart';
import 'package:studymate/widgets/RadialProgress.dart';
import 'package:studymate/widgets/TopBar.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TopBar(),
            RadialProgress(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 200.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 160.0,
                    color: Colors.green,
                    child:ListView(
                      children: <Widget>[
                        Text("STUDY",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                        SizedBox(height: 15.0),
                        Text("80",style: TextStyle(color: Colors.white,fontSize: 40.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                        Text("Minutes",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                        Text("To Go",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      ],
                    ),
                  ),
                  Container(
                    width: 160.0,
                    color: Colors.blue,
                    child:ListView(
                      children: <Widget>[
                        Text("Leisure",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                        SizedBox(height: 15.0),
                        Text("140",style: TextStyle(color: Colors.white,fontSize: 40.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                        Text("Minutes",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                        Text("To Go",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      ],
                    ),
                  ),
                  Container(
                    width: 160.0,
                    color: Colors.orange,
                    child:ListView(
                      children: <Widget>[
                        Text("SOCIAL",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                        SizedBox(height: 15.0),
                        Text("200",style: TextStyle(color: Colors.white,fontSize: 40.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                        Text("Minutes",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                        Text("To Go",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}
