import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class RadialProgress extends StatefulWidget{
  final double goalCompleted = 0.7;
  @override
  _RadialProgressState createState() => _RadialProgressState();
  }
  
  class _RadialProgressState extends State<RadialProgress> with SingleTickerProviderStateMixin{

  AnimationController _radialProgressAnimationController;
  Animation<double> _progressAnimation;
  var progressDegrees = 0.0;
  @override
  void initState(){
    super.initState();
    _radialProgressAnimationController = AnimationController(vsync: this,duration: Duration(seconds: 3));
    _progressAnimation = Tween(begin: 0.0,end: 360.0).animate(CurvedAnimation(parent: _radialProgressAnimationController,curve: Curves.easeIn))..addListener((){
        setState(() {
                progressDegrees = widget.goalCompleted * _progressAnimation.value;
        });
     

    });
       _radialProgressAnimationController.forward(); 
    

    
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
      
class RadialPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width/2,size.height/2);
    Paint cpaint = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;
    canvas.drawCircle(center,size.width/2 ,cpaint);

    Paint ppaint = Paint()
      ..color = Colors.blue
      ..shader = LinearGradient(colors:[Colors.greenAccent,Colors.green]).createShader(Rect.fromCircle(center: center,radius: size.width/2))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0;

    canvas.drawArc(Rect.fromCircle(center: center,radius: size.width/2),math.radians(-90),math.radians(220) ,false, ppaint);

    Paint cpaint2 = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0;
    canvas.drawCircle(center,size.width/2.5 ,cpaint2);

    Paint ppaint2 = Paint()
      ..color = Colors.blue
      ..shader = LinearGradient(colors:[Colors.lightBlue[200],Colors.blue]).createShader(Rect.fromCircle(center: center,radius: size.width/2))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0;

    canvas.drawArc(Rect.fromCircle(center: center,radius: size.width/2.5),math.radians(-90),math.radians(150) ,false, ppaint2);


    Paint cpaint3 = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0;
    canvas.drawCircle(center,size.width/3.5 ,cpaint3);

    Paint ppaint3 = Paint()
      ..color = Colors.blue
      ..shader = LinearGradient(colors:[Colors.amber,Colors.deepOrange]).createShader(Rect.fromCircle(center: center,radius: size.width/2))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0;

    canvas.drawArc(Rect.fromCircle(center: center,radius: size.width/3.5),math.radians(-90),math.radians(90) ,false, ppaint3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    
    return true;
  }
}