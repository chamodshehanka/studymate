import 'package:flutter/material.dart';

class MedicalRecordUIScreen extends StatefulWidget {
  _MedicalRecordScreenState createState() => _MedicalRecordScreenState();
}

class _MedicalRecordScreenState extends State<MedicalRecordUIScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Records'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        child: Text('Heshan'),
      ),
    );
  }
}
