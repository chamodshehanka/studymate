import 'package:flutter/material.dart';
import 'package:studymate/widgets/RadialProgress.dart';
import 'package:studymate/widgets/TopBar.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                    color: Colors.red,
                  ),
                  Container(
                    width: 160.0,
                    color: Colors.blue,
                  ),
                  Container(
                    width: 160.0,
                    color: Colors.green,
                  ),
                  Container(
                    width: 160.0,
                    color: Colors.yellow,
                  ),
                  Container(
                    width: 160.0,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
