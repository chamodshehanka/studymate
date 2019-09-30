import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// import 'package:studymate/models/Activity.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

class ActivityProgressScreen extends StatefulWidget {
  _ActivityProgressScreenState createState() => _ActivityProgressScreenState();
}

class _ActivityProgressScreenState extends State<ActivityProgressScreen> {
  // final HttpsCallable callable = CloudFunctions.instance
  //     .getHttpsCallable(functionName: CommonConstants.activityProgressFunction);
  // List<charts.Series<Activity, String>> _seriesData;
  var textVal = "Cat";

  initState() {
    super.initState();

    // loading cloud funtion
    // sum(5, 2).then((value) {
    //   print("hey look : " + value.toString());
    //   textVal = value.toString();
    //   setState(() {
    //     textVal = value.toString();
    //   });
    // });

    //
  }

  // Future<int> sum(int x, int y) async {
  //   HttpsCallableResult response =
  //       await callable.call(<int, dynamic>{x: x, y: y});
  //   return response.data;
  // }

  @override
  Widget build(BuildContext context) {
    var activityProgressBody = Container();

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
