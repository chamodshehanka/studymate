import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studymate/screens/ActivityScreen/AdminScreen/PDFWidget.dart';

class ActivityReportScreen extends StatefulWidget {
  _ActivityReportScreenState createState() => _ActivityReportScreenState();
}

class _ActivityReportScreenState extends State<ActivityReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () => _generatePDFAndView(context),
          ),
        ],
      ),
      body: Container(),
    );
  }

  _generatePDFAndView(context) async {
    PDFWidget().getPDF();
  }
}
