import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './admin/user_management.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  // If already and registered user, he/she will be automatically redirected
  @override
  void initState() {
    super.initState();
    getUser().then((user) {
      if (user != null) {
         Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserManagement()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(56, 52, 175, 1.0),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: 100.0, right: 20.0, left: 20.0, bottom: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('assets/logo.png'),
                      SizedBox(
                        height: 40.0,
                      ),
                      buildUsernameField(),
                      SizedBox(
                        height: 20.0,
                      ),
                      buildPasswordField(),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Forgot Password ?',
                              style: TextStyle(
                                color: Colors.indigo[50],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      buildButtonContainer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildUsernameField() {
    return TextFormField(
      validator: (input) {
        if (input.isEmpty) {
          return 'Username is required';
        }
      },
      onSaved: (input) => _username = input,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: 'Username',
        labelStyle: TextStyle(
          color: Colors.lightBlue[200],
          fontSize: 16.0,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlue[400], width: 2.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlue[400], width: 2.0),
        ),
        prefixIcon: Icon(
          Icons.email,
          color: Colors.lightBlue[400],
        ),
      ),
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      validator: (input) {
        if (input.length < 6) {
          return 'Password should be minimun 6 characters';
        }
      },
      onSaved: (input) => _password = input,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(
            color: Colors.lightBlue[200],
            fontSize: 16.0,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue[400], width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue[400], width: 2.0),
          ),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.lightBlue[400],
          )),
      obscureText: true,
    );
  }

  Widget buildButtonContainer() {
    return GestureDetector(
      onTap: () {
        signIn();
      },
      child: Container(
        height: 56.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.indigoAccent[100],
        ),
        child: Center(
          child: Text(
            'LOGIN',
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

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _username, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserManagement()));
      } catch (e) {
        print(e.toString());
      }
    }
  }

  // Get registerd in user with current device
  Future<FirebaseUser> getUser() async{
    return await auth.currentUser();
  }
}
