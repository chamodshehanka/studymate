import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ActivityAdminDashboardScreen extends StatefulWidget {
  _ActivityAdminDashboardScreenState createState() =>
      _ActivityAdminDashboardScreenState();
}

class _ActivityAdminDashboardScreenState
    extends State<ActivityAdminDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
            
          ),
        ],
      ),
    );
  }
}
