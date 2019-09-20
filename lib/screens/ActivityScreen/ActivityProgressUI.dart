import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/utils/CommonConstants.dart';

class ActivityProgressScreen extends StatefulWidget {
  _ActivityProgressScreenState createState() => _ActivityProgressScreenState();
}

class _ActivityProgressScreenState extends State<ActivityProgressScreen> {
  final HttpsCallable callable = CloudFunctions.instance
      .getHttpsCallable(functionName: CommonConstants.activityProgressFunction);
  var textVal = "Cat";

  initState() {
    super.initState();
    sum(5, 2).then((value) {
      print("hey look : " + value.toString());
      textVal = value.toString();
      setState(() {
        textVal = value.toString();
      });
    });
  }

  Future<int> sum(int x, int y) async {
    HttpsCallableResult response =
        await callable.call(<int, dynamic>{x: x, y: y});
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    var activityProgressBody = Container(
      child: Text('5 + 2 : ' + textVal),
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
