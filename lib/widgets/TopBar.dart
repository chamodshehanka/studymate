import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studymate/widgets/CurveClipper.dart';

class TopBar extends StatelessWidget {
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurveClipper(),
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff5f27cd), Color(0xff341f97)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 25.0, 0, 0),
            child: Center(
              child: Text(
                todayDate(),
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ),
          ),
             Padding(
            padding: EdgeInsets.fromLTRB(0, 55.0, 0, 0),
            child: Center(
              child: Text(
                todayDay(),
                style: TextStyle(color: Colors.white, fontSize: 50.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String todayDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    return formattedDate;
  }

    String todayDay() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('E').format(now);

    return formattedDate;
  }
}
