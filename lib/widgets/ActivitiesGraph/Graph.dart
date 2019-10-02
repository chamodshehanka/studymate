import 'package:flutter/material.dart';

class Graph extends StatelessWidget {
  final AnimationController animationController;
  final double height;

  Graph({this.animationController, this.height = 120});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GraphBar(height: height, percentage: 0.5),
          GraphBar(height: height, percentage: 0.8),
          GraphBar(height: height, percentage: 0.7),
          GraphBar(height: height, percentage: 0.1),
        ],
      ),
    );
  }
}

class GraphBar extends StatefulWidget {
  final double height;
  final double percentage;

  GraphBar({this.height, this.percentage});

  @override
  _GraphBarState createState() => _GraphBarState();
}

class _GraphBarState extends State<GraphBar> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BarPainter(widget.percentage),
      child: Container(
        height: widget.height,
        color: Colors.deepPurpleAccent,
        // child:
      ),
    );
  }
}

class BarPainter extends CustomPainter {
  double percentage;

  BarPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    Paint greyPaint = Paint()
      ..color = Colors.grey
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    Offset topPoint = Offset(0, 0);
    Offset bottomPoint = Offset(0, size.height);
    Offset centerPoint = Offset(0, size.height / 2);

    canvas.drawLine(topPoint, bottomPoint, greyPaint);
    Paint filledPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.pink.shade500, Colors.blue.shade500],
      ).createShader(Rect.fromPoints(topPoint, bottomPoint))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

      double filledHeight = percentage * size.height;
      double filledHalfHeight = filledHeight / 2;

      canvas.drawLine(centerPoint, Offset(0, filledHalfHeight), filledPaint);
      canvas.drawLine(centerPoint, Offset(0, size.height - filledHalfHeight), filledPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
