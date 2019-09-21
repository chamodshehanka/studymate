import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  @override
  AddScreenState createState() => AddScreenState();
}

class AddScreenState extends State<AddScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
        child: Center(
          child: Container(
            width: 400,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // StudymateTextField(
                //     Icon(Icons.person, color: Colors.white), 'UserId'),
                // StudymateTextField(
                //     Icon(Icons.lock, color: Colors.white), 'Password'),
                Container(
                    width: 150,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      color: Colors.deepOrange,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Text(
                        'Log In',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
