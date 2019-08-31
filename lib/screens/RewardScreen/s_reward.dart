import 'package:flutter/material.dart';

class StudentRewardsScreen extends StatefulWidget {
  _StudentRewardsScreen createState() => _StudentRewardsScreen();
}

class _StudentRewardsScreen extends State<StudentRewardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Rewards Management",
          style: TextStyle(fontWeight: FontWeight.bold),
          
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Color(0xFF18D191), size: 10.0),
      ),
      body:Column(
        children: <Widget>[
          RaisedButton(
            onPressed:()=> Navigator.pushNamed(context, '/badge_collection'),
            child:Padding(
              padding: (const EdgeInsets.only(
                                        top: 50.0, bottom: 20.0)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Color(0XFF28D093),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 50.0, left: 20.0),
                                            child: Icon(
                                              Icons.camera_enhance,
                                              color: Colors.white,
                                              size: 50.0,
                                            ),
                                          ),
                                          Text(
                                            "Achivements",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30.0),
                                          ),
                                        ],
                                      ),
                                      )
            ), 
            
          ),
          RaisedButton(
            onPressed:()=> Navigator.pushNamed(context, '/'),
            child: Text("Achievments"),
          ),
        ],
      ),
    );
  }
}

