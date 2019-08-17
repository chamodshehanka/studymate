import 'package:flutter/material.dart';
import './create_account.dart';
import './delete_account.dart';
import 'package:studymate/screens/HomeScreen/HomeUIAdmin.dart';

class UserManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserManagementPage(),
    );
  }
}

class UserManagementPage extends StatefulWidget {
  @override
  _UserManagementPage createState() => _UserManagementPage();
}

class _UserManagementPage extends State<UserManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(56, 52, 175, 1.0),
          title: Text(
            'User Management',
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreenAdmin()),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                // color: const Color.fromRGBO(56, 52, 175, 1.0),
                // padding: EdgeInsets.only(
                // top: 20.0, right: 20.0, left: 20.0, bottom: 20.0),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 100.0,
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          buildButtonContainer('Add New Account',
                              Colors.indigoAccent[100], 'createAccount'),
                          SizedBox(
                            height: 30.0,
                          ),
                          buildButtonContainer(
                              'Delete Account', Colors.red, 'deleteAccount'),
                          SizedBox(
                            height: 30.0,
                          ),
                          buildButtonContainer(
                              'Overview', Colors.green[600], ''),
                          SizedBox(height: 10.0),
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

  Widget buildButtonContainer(
      String buttonTxt, Color buttonColor, String buttonAction) {
    return GestureDetector(
      onTap: () {
        switch (buttonAction) {
          case 'createAccount':
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateAccount()));
            break;
          case 'deleteAccount':
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DeleteAccount()));
            break;
          default:
            break;
        }
      },
      child: Container(
        height: 65.0,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: buttonColor,
        ),
        child: Center(
          child: Text(
            buttonTxt,
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
