import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/widgets/LineChart.dart';

class ActivityProgressScreen extends StatefulWidget {
  _ActivityProgressScreenState createState() => _ActivityProgressScreenState();
}

class _ActivityProgressScreenState extends State<ActivityProgressScreen> {
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var activityProgressBody = Container(
      child: ActivityLineChartWidget(
        
      ),
    );

    return MaterialApp(
      title: 'Activity Progress UI',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Activity Progress'),
          backgroundColor: Colors.deepPurple,
        ),
        body: SafeArea(
          child: activityProgressBody,
        ),
      ),
    );
  }
}
