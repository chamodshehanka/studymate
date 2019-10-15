import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studymate/models/Activity.dart';
import 'package:studymate/models/PreferredActivity.dart';
import 'package:studymate/models/Student.dart';
import 'package:studymate/services/custom/ActivityService.dart';
import 'package:studymate/services/custom/StudentService.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ActivityLineChartWidget extends StatefulWidget {
  _ActivityLineChartWidgetState createState() =>
      _ActivityLineChartWidgetState();
}

class _ActivityLineChartWidgetState extends State<ActivityLineChartWidget> {
  List<Activity> activitiesAllList;
  List<Student> studentsList;
  List<PreferredActivity> studentsPreferredActivitiesList;
  List<LineChartData> linechartDataList;
  ActivityService activityService = ActivityService();
  StudentService studentService = StudentService();
  StreamSubscription<QuerySnapshot> activitiesSubscription;
  StreamSubscription<QuerySnapshot> studentsSubscription;

  @override
  void initState() {
    super.initState();

    // Get all activities
    activitiesAllList = List();
    activitiesSubscription?.cancel();
    activitiesSubscription =
        activityService.getActivityList().listen((QuerySnapshot snapshot) {
      final List<Activity> activities = snapshot.documents
          .map((documentSnapshot) => Activity.fromMap(documentSnapshot.data))
          .toList();
      setState(() {
        this.activitiesAllList = activities;
      });
    });

    // Get all students
    studentsList = List();
    studentsSubscription?.cancel();
    studentsSubscription =
        studentService.getStudentList().listen((QuerySnapshot snapshot) {
      final List<Student> students =
          snapshot.documents.map((doc) => Student.fromMap(doc.data)).toList();
      setState(() {
        this.studentsList = students;
      });
    });

    studentsPreferredActivitiesList = List();
    linechartDataList = List();

    loadStudentPreferredActivities();
    loadChartDataList();
  }

  @override
  void dispose() {
    activitiesSubscription?.cancel();
    studentsSubscription?.cancel();
    super.dispose();
  }

  void loadStudentPreferredActivities() {
    studentsList.forEach((student) {
      studentService
          .getAllPreferredActivities(student.id, 'Social')
          .listen((QuerySnapshot snapshot) {
        final List<PreferredActivity> list = snapshot.documents
            .map((doc) => PreferredActivity.fromMap(doc.data))
            .toList();
        setState(() {
          this.studentsPreferredActivitiesList = list;
        });
      });

      studentService
          .getAllPreferredActivities(student.id, 'Leisure')
          .listen((QuerySnapshot snapshot) {
        final List<PreferredActivity> list = snapshot.documents
            .map((doc) => PreferredActivity.fromMap(doc.data))
            .toList();
        setState(() {
          this.studentsPreferredActivitiesList.addAll(list);
        });
      });
    });
  }

  void loadChartDataList() {
    activitiesAllList.forEach((activity) {
      int count = 0;
      studentsPreferredActivitiesList.forEach((preferredActivity) {
        if (activity.name == preferredActivity.name) {
          count++;
        }
      });
      setState(() {
        linechartDataList.add(LineChartData(activity.name, count));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
        series: <LineSeries<LineChartData, String>>[
          LineSeries<LineChartData, String>(
              dataSource: linechartDataList ?? [LineChartData('Running', 2)],
              xValueMapper: (LineChartData data, _) => data.x,
              yValueMapper: (LineChartData data, _) => data.y,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              color: Colors.deepPurpleAccent)
        ],
      ),
    );
  }
}

class LineChartData {
  final String x;
  final int y;
  LineChartData(this.x, this.y);
}
