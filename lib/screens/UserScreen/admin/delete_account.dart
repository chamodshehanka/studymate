import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
import './user_management.dart';

class DeleteAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DeleteAccountPage(),
    );
  }
}

class DeleteAccountPage extends StatefulWidget {
  @override
  _DeleteAccountPage createState() => _DeleteAccountPage();
}

class _DeleteAccountPage extends State<DeleteAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(56, 52, 175, 1.0),
          title: Text(
            'Delete Account',
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserManagement()),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                color: const Color.fromRGBO(56, 52, 175, 1.0),
                // padding: EdgeInsets.only(
                // top: 20.0, right: 20.0, left: 20.0, bottom: 20.0),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 40.0,
                          ),
                          Text(
                            'Thilini Dureksha',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          buildButtonContainer(),
                          SizedBox(
                            height: 30.0,
                          ),
                          SizedBox(
                            height: 10.0,
                            child: Container(
                              color: Colors.indigoAccent[100],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  // final DatabaseReference database =
  //     FirebaseDatabase.instance.reference().child("Admin");

  sendData() {
    // database.push().set({'name': 'John', 'last name': 'Doe'});
  }

  Widget buildButtonContainer() {
    return GestureDetector(
      onTap: () {
        sendData();
      },
      child: Container(
        height: 45.0,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.indigoAccent[100],
        ),
        child: Center(
          child: Text(
            'EDIT PROFILE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
