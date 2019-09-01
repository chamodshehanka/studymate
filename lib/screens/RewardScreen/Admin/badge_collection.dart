import 'package:flutter/material.dart';

class BadgesScreen extends StatefulWidget {
  @override
  _BadgesScreenState createState() => _BadgesScreenState();
}

class   _BadgesScreenState extends State<BadgesScreen> {
  
  void initState(){
          super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(
          "Badge Collection",
          style: TextStyle(fontWeight: FontWeight.bold),
          
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Color(0xFF18D191), size: 10.0),

      ),
      
      floatingActionButton: FloatingActionButton(
       
        child: Icon(Icons.add),
        tooltip: 'Add New Badge',
         onPressed:() => Navigator.pushNamed(context, '/new_badge'),
        
      ),
    );
  }
}
