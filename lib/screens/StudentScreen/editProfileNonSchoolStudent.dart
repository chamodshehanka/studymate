import 'dart:core';

/*void main() => runApp(new NonSchoolStudentScreen());

class NonSchoolStudentScreen extends StatefulWidget {
  NonSchoolStudentScreen({Key key}) : super(key: key);

  @override
  NonSchoolStudentScreenState createState() => NonSchoolStudentScreenState();
}

class NonSchoolStudentScreenState extends State<NonSchoolStudentScreen> {
   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _validate = false;
  String name;
  String mobile;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Create Profile'),
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(15.0),
            child: new Form(
              key: _formKey,
              autovalidate: _validate,
              child: formUI(),
            ),
          ),
        ),
      ),
    );
  }


  Widget formUI() {
    return new Column(
      children: <Widget>[
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Full Name'),
          keyboardType: TextInputType.text,
          validator: validateName,
          onSaved: (String val) {
            name = val;
          },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Contact Number'),
          keyboardType: TextInputType.phone,
          validator: validateMobile,
          onSaved: (String val) {
            mobile = val;
          },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
          onSaved: (String val) {
            email = val;
          },
        ),
        new TextFormField(
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
          keyboardType: TextInputType.text,
          validator: validatePassword,
          onSaved: (String val) {
            password = val;
          },
        ),
        new SizedBox(
          height: 10.0,
        ),
        new RaisedButton(
          onPressed: _sendToServer,
          child: new Text('Sign Up'),
          
        )
      ],
    );
  }

  String validateName (String value) {
    String pattern = r'(^[a-zA-Z]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Name is Required";
    }else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateMobile (String value) {
   String pattern = r'(^[0-9]*$)';
   RegExp regExp = new RegExp(pattern);
   if (value.length == 0) {
     return "Mobile is Required";
   }else if(value.length != 10) {
     return "Mobile number must 10 digits";
  }else if (!regExp.hasMatch(value)) {
    return "Mobile Number must be digits";
  }
  return null;
  }

  String validateEmail (String value) {
    Pattern pattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    }
    else if (!regex.hasMatch(value))
      return 'Invalid Email';
    else{
      return null;
    }
  }

  String validatePassword (String value) {
    if (value.length > 6){
    return 'Password must be more than 6 character';
    }else{
    return null;
    }
  }

  _sendToServer(){
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print('Form is valid. Name $name, Mobile $mobile, Email $email, Password $password');
    }else {
      print('Form is invalid. Name $name, Mobile $mobile, Email $email, Password $password');
    }
  }
  
}*/
