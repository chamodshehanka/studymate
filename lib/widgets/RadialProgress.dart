

import 'dart:developer' as prefix0;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class RadialProgress extends StatefulWidget {
  final double goalCompleted = 0.7;
  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  AnimationController _radialProgressAnimationController;
  Animation<double> _progressAnimation;
  SharedPreferences prefs;
  int socialMinutes;
  int studyMinutes;
  int leisureMinutes;

  var progressDegrees = 0.0;

 Future<SharedPreferences> getSPInstance() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs;
  }
  
  @override
  void initState() {
    super.initState();

    getSPInstance().then((instance) {
      setState(() {
        prefs = instance;
      });
        int today = DateTime.now().weekday;
    switch (today) {
      case 1:
        {
          setState(() {
            socialMinutes = prefs.getInt('socialMon');
            leisureMinutes = prefs.getInt('leisureMon');
            studyMinutes = prefs.getInt('studyMon');
          });
        }
        break;
      case 2:
        {          setState(() {
            socialMinutes = prefs.getInt('socialTue');
            leisureMinutes = prefs.getInt('leisureTue');
            studyMinutes = prefs.getInt('studyTue');
          });
          
        }
        break;
      case 3:
        {          setState(() {
            socialMinutes = prefs.getInt('socialWed');
            leisureMinutes = prefs.getInt('leisureWed');
            studyMinutes = prefs.getInt('studyWed');
          });
          
        }
        break;
      case 4:
        {          setState(() {
            socialMinutes = prefs.getInt('socialThu');
            leisureMinutes = prefs.getInt('leisureThu');
            studyMinutes = prefs.getInt('studyThu');
          });
          
        }
        break;
      case 5:
        {          setState(() {
            socialMinutes = prefs.getInt('socialFri');
            leisureMinutes = prefs.getInt('leisureFri');
            studyMinutes = prefs.getInt('studyFri');
          });
          
        }
        break;
      case 6:
        {          setState(() {
            socialMinutes = prefs.getInt('socialSat');
            leisureMinutes = prefs.getInt('leisureSat');
            studyMinutes = prefs.getInt('studySat');
          });
          
        }
        break;
      case 7:
        {          setState(() {
            socialMinutes = prefs.getInt('socialSun');
            leisureMinutes = prefs.getInt('leisureSun');
            studyMinutes = prefs.getInt('studySun');
          });
          
        }
        break;
    }
    prefix0.log(socialMinutes.toString());
    prefix0.log(leisureMinutes.toString());
    prefix0.log(studyMinutes.toString());
    });

    _radialProgressAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _progressAnimation = Tween(begin: 0.0, end: 360.0).animate(CurvedAnimation(
        parent: _radialProgressAnimationController, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {
          progressDegrees = widget.goalCompleted * _progressAnimation.value;
        });
      });
    _radialProgressAnimationController.forward(from: 0.0);

    // log(socialMinutes);
    // log(leisureMinutes);
    // log(studyMinutes);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 200.0,
        width: 200.0,
      ),
      painter: RadialPainter(),
    );
  }
}

class RadialPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    Paint cpaint = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;
    canvas.drawCircle(center, size.width / 2, cpaint);

    Paint ppaint = Paint()
      ..color = Colors.blue
      ..shader = LinearGradient(colors: [Colors.greenAccent, Colors.green])
          .createShader(Rect.fromCircle(center: center, radius: size.width / 2))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0;

    canvas.drawArc(Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(-90), math.radians(220), false, ppaint);

    Paint cpaint2 = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0;
    canvas.drawCircle(center, size.width / 2.5, cpaint2);

    Paint ppaint2 = Paint()
      ..color = Colors.blue
      ..shader = LinearGradient(colors: [Colors.lightBlue[200], Colors.blue])
          .createShader(Rect.fromCircle(center: center, radius: size.width / 2))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0;

    canvas.drawArc(Rect.fromCircle(center: center, radius: size.width / 2.5),
        math.radians(-90), math.radians(150), false, ppaint2);

    Paint cpaint3 = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0;
    canvas.drawCircle(center, size.width / 3.5, cpaint3);

    Paint ppaint3 = Paint()
      ..color = Colors.blue
      ..shader = LinearGradient(colors: [Colors.amber, Colors.deepOrange])
          .createShader(Rect.fromCircle(center: center, radius: size.width / 2))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0;

    canvas.drawArc(Rect.fromCircle(center: center, radius: size.width / 3.5),
        math.radians(-90), math.radians(90), false, ppaint3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
