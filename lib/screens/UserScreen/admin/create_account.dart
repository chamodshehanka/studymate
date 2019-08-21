import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import './user_management.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class CreateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CreateAccountPage(),
    );
  }
}

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPage createState() => _CreateAccountPage();
}

class _CreateAccountPage extends State<CreateAccountPage> {
  var _options = ['Select Role', 'Parent', 'Admin', 'Doctor', 'Student'];
  var _currentOptionSelected = 'Select Role';

  String _username, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(56, 52, 175, 1.0),
          title: Text(
            'Add New Account',
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
                // color: const Color.fromRGBO(56, 52, 175, 1.0),
                padding: EdgeInsets.only(
                    top: 20.0, right: 20.0, left: 20.0, bottom: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 40.0,
                            ),
                            Container(
                              height: 45.0,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.0)),
                                  border:
                                      Border.all(color: Colors.indigo[900])),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  style: TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 18,
                                  ),
                                  items: _options.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  value: _currentOptionSelected,
                                  onChanged: (String newOption) {
                                    _onDropDownOptionSelected(newOption);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 180.0,
                            ),
                            buildUsernameField(),
                            SizedBox(
                              height: 20.0,
                            ),
                            buildPasswordField(),
                            SizedBox(
                              height: 50.0,
                            ),
                            buildButtonContainer(),
                            SizedBox(
                              height: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildUsernameField() {
    return Container(
      height: 53.0,
      child: TextFormField(
        validator: (input) {
          if (input.isEmpty) {
            return 'Username is required';
          }
        },
        onSaved: (input) => _username = input,
        style: TextStyle(
          color: Colors.indigo[900],
        ),
        decoration: new InputDecoration(
          labelText: 'Enter User name',
          labelStyle: TextStyle(
            color: Colors.indigo,
            fontSize: 16.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField() {
    return Container(
      height: 53.0,
      child: TextFormField(
        validator: (input) {
          if (input.length < 6) {
            return 'Password should be minimun 6 characters';
          }
        },
        onSaved: (input) => _password = input,
        style: TextStyle(
          color: Colors.indigo[900],
        ),
        decoration: InputDecoration(
          labelText: 'Enter Password',
          labelStyle: TextStyle(
            color: Colors.indigo,
            fontSize: 16.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo),
          ),
        ),
        obscureText: true,
      ),
    );
  }

  Widget buildButtonContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        buildCreateButtonContainer(),
        buildCancelButtonContainer(),
      ],
    );
  }

  Widget buildCreateButtonContainer() {
    return GestureDetector(
      onTap: () {
        registerNewAccount();
      },
      child: Container(
        height: 50.0,
        width: 135,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.indigo[400],
        ),
        child: Center(
          child: Text(
            'Create',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCancelButtonContainer() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserManagement()));
      },
      child: Container(
        height: 50.0,
        width: 135,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.indigo[400],
        ),
        child: Center(
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }

  void _onDropDownOptionSelected(String newOptionSelected) {
    setState(() {
      this._currentOptionSelected = newOptionSelected;
    });
  }

  Future<void> registerNewAccount() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();

      // try {
      //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //     email: _username,
      //     password: _password,
      //   );

      //   Firestore.instance.collection('users').document().setData({
      //     'id': '000',
      //     'username': _username,
      //     'password': _password,
      //     'Type': _currentOptionSelected,
      //     'First Name': _currentOptionSelected + ' User',
      //     'Last Name': ' ',
      //     'Contact': '077 000 000',
      //     'Gender': ' '
      //   });
      // } catch (e) {
      //   _showDialog("Successfull !!", "New user successfully registered.");
      // }

      // _showDialog("Successfull", "New user successfully registered");
    }
  }

  // user defined function
  void _showDialog(String title, String desc) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title),
          content: Text(
            desc,
            style: TextStyle(fontSize: 14.0),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("New User"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  this._currentOptionSelected = 'Select Role';
                });
                _formKey.currentState.reset();
              },
            ),
          ],
        );
      },
    );
  }
}
