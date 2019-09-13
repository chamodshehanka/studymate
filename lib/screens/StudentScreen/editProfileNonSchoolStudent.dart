import 'dart:core';
import "package:flutter/material.dart";
import 'package:googleapis/cloudsearch/v1.dart';
import 'package:studymate/widgets/StudymateTextField.dart';

/*class NonSchoolStudentScreen extends StatefulWidget {
  _NonSchoolStudentScreenState createState() => _NonSchoolStudentScreenState();
}

class _NonSchoolStudentScreenState extends State<NonSchoolStudentScreen> {
  final TextEditingController _fullname = new TextEditingController();
  final TextEditingController _parentID = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _number = new TextEditingController();
  final TextEditingController _address = new TextEditingController();
  CustomTextField _nameField;
  CustomTextField _parentIDField;
  CustomTextField _emailField;
  CustomTextField _passwordField;
  CustomTextField _phoneField;
  CustomTextField _addressField;
  bool _blackVisible = false;
  VoidCallback onBackPress;

  @override
  void initState() {
    super.initState();

    onBackPress = () {
      Navigator.of(context).pop();
    };

    _nameField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _fullname,
      hint: "Full Name",
    );

    _parentIDField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _parentID,
      hint: "Parent ID",
    );

    _emailField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _email,
      hint: "E-mail Adress",
      inputType: TextInputType.emailAddress,
    );
    _passwordField = CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _password,
      obscureText: true,
      hint: "Password",
    );

    _phoneField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _number,
      hint: "Phone Number",
      inputType: TextInputType.number,
    );

    _addressField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _address,
      hint: "Address",
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Stack(
              alignment: Alignment.topLeft,
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 70.0, bottom: 10.0, left: 10.0, right: 10.0),
                      child: Text(
                        "Create new account",
                        softWrap: true,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          decoration: TextDecoration.none,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: "OpenSans",
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                      child: _nameField,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                      child: _parentIDField,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: _emailField,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: _passwordField,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                      child: _phoneField,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                       child: _addressField,   
                    ), 
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 40.0),
                      child: CustomFlatButton(
                        title: "Sign Up",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: Center(child: Text('Alert'),),
                                backgroundColor: Colors.white,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        "Profile Create Succesful",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        FlatButton(
                                          child: Text('No'),
                                          textColor: 
                                            Colors.purple,
                                          onPressed: (){},  
                                        ),
                                        FlatButton(
                                          child: Text('Yes'),
                                          textColor: 
                                              Colors.purple,
                                           onPressed: (){},   
                                        )
                                      ],    
                                    )
                                  ],
                                ),
                              );
                            }
                          );
                        },
                        splashColor: Colors.black12,
                        borderColor: Colors.blueAccent,
                        borderWidth: 0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
                SafeArea(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: onBackPress,
                  ),
                ),
              ],
            ),
            Offstage(
              offstage: !_blackVisible,
              child: GestureDetector(
                onTap: () {},
                child: AnimatedOpacity(
                  opacity: _blackVisible ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.ease,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomFlatButton extends StatelessWidget {
  final String title;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onPressed;
  final Color color;
  final Color splashColor;
  final Color borderColor;
  final double borderWidth;

  CustomFlatButton(
      {this.title,
      this.textColor,
      this.fontSize,
      this.fontWeight,
      this.onPressed,
      this.color,
      this.splashColor,
      this.borderColor,
      this.borderWidth});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      color: color,
      splashColor: splashColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          title,
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            decoration: TextDecoration.none,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: "OpenSans",
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(
          color: borderColor,
          width: borderWidth,
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final Color baseColor;
  final Color borderColor;
  final Color errorColor;
  final TextInputType inputType;
  final bool obscureText;
  final Function validator;
  final Function onChanged;
  final Function value;
  final List items;
  final Function child;

  CustomTextField(
      {this.hint,
      this.controller,
      this.onChanged,
      this.baseColor,
      this.borderColor,
      this.errorColor,
      this.inputType = TextInputType.text,
      this.obscureText = false,
      this.value,
      this.items,
      this.child,
      this.validator});

  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Color currentColor;

  @override
  void initState() {
    super.initState();
    currentColor = widget.borderColor;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: currentColor, width: 2.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          obscureText: widget.obscureText,
          onChanged: (text) {
            if (widget.onChanged != null) {
              widget.onChanged(text);
            }
            setState(() {
              if (!widget.validator(text) || text.length == 0) {
                currentColor = widget.errorColor;
              } else {
                currentColor = widget.baseColor;
              }
            });
          },
          keyboardType: widget.inputType,
          controller: widget.controller,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: widget.baseColor,
              fontFamily: "OpenSans",
              fontWeight: FontWeight.w300,
            ),
            border: InputBorder.none,
            hintText: widget.hint,
          ),
        ),
      ),
    );
  }
}*/
class NonSchoolStudentScreen extends StatefulWidget {
  @override
  NonSchoolStudentScreenState createState() => NonSchoolStudentScreenState();
}

class NonSchoolStudentScreenState extends State<NonSchoolStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime _dateTime;

  /*Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked  = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: new DateTime(1995),
      lastDate: new DateTime(2014)
    );

    if(picked != null && picked != _date){
      print('Date selected: ${_date.toString()}');
      setState((){
        _date = picked;
      });
    }
  }*/
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Create Profile'),
      ),


      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
        
        child: Center(
          child: Container(
            width: 400,
            height: 600,
            
            child: Column(
            
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              
                StudymateTextField(
                    Icon(Icons.person, color: Colors.white), 'Full Name'),
                StudymateTextField( 
                    Icon(Icons.data_usage, color: Colors.white),_dateTime == null ? 'Nothing has been picked yet' :_dateTime.toString()),
                    RaisedButton(
                      child: Text('Pick a date'),
                      onPressed: (){
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1995),
                            lastDate: DateTime(2014)
                          ).then((date){
                            setState((){
                              _dateTime = date;
                            });
                          });
                      },
                    ),
                    
                StudymateTextField(
                    Icon(Icons.email, color: Colors.white), 'Email'),
                 StudymateTextField(
                    Icon(Icons.lock, color: Colors.white), 'Password'),  
                            
                Container(
                    width: 150,
                    child: RaisedButton(
                      onPressed: (){},
                      
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Text(
                        'Sing Up',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  
                    ),
                  ]
                ),
            
                  
                )
                  
          
            
              
                
            ),
            
          ),
          
        );
      
    
  }
}

