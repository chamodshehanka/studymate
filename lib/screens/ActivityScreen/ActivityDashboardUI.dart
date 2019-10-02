import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityDashboardScreen extends StatefulWidget {
  _ActivityDashboardScreenState createState() =>
      _ActivityDashboardScreenState();
}

class _ActivityDashboardScreenState extends State<ActivityDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: buildBody(context),
      ),
    );
  }

  // Activity Dashboard Body
  Widget buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(),
        )
      ],
    );
  }
}
