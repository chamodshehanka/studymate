import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/widgets/StudymateRaisedButton.dart';
import 'package:studymate/widgets/StudymateTextField.dart';
import 'package:studymate/widgets/loading.dart';

class AdminRegScreen extends StatefulWidget {
  _AdminRegScreenState createState() => _AdminRegScreenState();
}


class _AdminRegScreenState extends State<AdminRegScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstName = new TextEditingController();
  final TextEditingController _lastName = new TextEditingController();
  final TextEditingController _nicNumber = new TextEditingController();
  final TextEditingController _slmcRegNumber = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _phoneNumber = new TextEditingController();
  final TextEditingController _workingPlace = new TextEditingController();
  

  bool _autoValidate = false;
  bool _loadingVisible = false;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 60.0,
          child: ClipOval(
            child: Image.asset(
              'assets/images/default.png',
              fit: BoxFit.cover,
              width: 120.0,
              height: 120.0,
            ),
          )),
    );

    final firstName = StudymateTextField("First Name", _firstName,
     "name", Colors.grey, TextInputType.text, Icon(Icons.text_fields,color: Colors.grey,));

    final lastName = StudymateTextField("Last Name", _lastName,
     "name", Colors.grey, TextInputType.text, Icon(Icons.text_fields,color: Colors.grey,));

     final nicNumber = StudymateTextField("NIC number", _nicNumber,
     "NIC number", Colors.grey, TextInputType.emailAddress, Icon(Icons.email,color: Colors.grey,));

     final slmcRegNumber = StudymateTextField("SLMC reg number", _slmcRegNumber,
     "SLMC reg number", Colors.grey, TextInputType.emailAddress, Icon(Icons.email,color: Colors.grey,));

    final email = StudymateTextField("Email", _email,
     "email", Colors.grey, TextInputType.emailAddress, Icon(Icons.email,color: Colors.grey,));

     

    final phoneNumber = StudymateTextField("Phone Number", _phoneNumber,
     "phone number", Colors.grey, TextInputType.text, Icon(Icons.lock,color: Colors.grey,));

     final workingPlace = StudymateTextField("Working palce", _workingPlace,
     "working place", Colors.grey, TextInputType.emailAddress, Icon(Icons.email,color: Colors.grey,));
  

    final signUpButton = StudymateRaisedButton("Sign Up", ()=>{
       _emailSignUp(
              firstName: _firstName.text,
              lastName: _lastName.text,
              nicNumber: _nicNumber.text,
              slmcRegNumber: _slmcRegNumber.text,
              email: _email.text,
              phoneNumber: _phoneNumber.text,
              workingPlace: _workingPlace.text,
              context: context)
    }, Colors.deepPurple);
    

    final signInLabel = FlatButton(
      child: Text(
        'Have an Account? Sign In.',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/signin');
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingScreen(
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      logo,
                      SizedBox(height: 48.0),
                      firstName,
                      SizedBox(height: 24.0),
                      lastName,
                      SizedBox(height: 24.0),
                      nicNumber,
                      SizedBox(height: 24.0,),
                      slmcRegNumber,
                      SizedBox(height: 24.0,),
                      email,
                      SizedBox(height: 24.0),
                      phoneNumber,
                      SizedBox(height: 24.0),
                      workingPlace,
                      SizedBox(height: 24.0),
                      signUpButton,
                      signInLabel
                    ],
                  ),
                ),
              ),
            ),
          ),
          inAsyncCall: _loadingVisible),
    );
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  void _emailSignUp(
      {String firstName,
      String lastName,
      String nicNumber,
      String slmcRegNumber,
      String email,
      String phoneNumber,
      String workingPlace,
      BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
 
        // await Auth.signUp(email, password).then((uID) {
        //   Auth.addUserSettingsDB(new User(
        //     userId: uID,
        //     email: email,
        //     firstName: firstName,
        //     lastName: lastName,
        //   ));
        // });
      
        await Navigator.pushNamed(context, '/sign_in');
      } catch (e) {
        _changeLoadingVisible();
        print("Sign Up Error: $e");
        //String exception = Auth.getExceptionText(e);
        // Flushbar(
        //   title: "Sign Up Error",
        //   message: exception,
        //   duration: Duration(seconds: 5),
        // )..show(context);
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
   
}
