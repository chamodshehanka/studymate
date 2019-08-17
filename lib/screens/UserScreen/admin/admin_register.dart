import 'package:flutter/material.dart';

class AdminRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AdminRegisterPage(),
    );
  }
}

class AdminRegisterPage extends StatefulWidget {
  @override
  _AdminRegisterPage createState() => _AdminRegisterPage();
}

class _AdminRegisterPage extends State<AdminRegisterPage> {
  int selectedRadio;

  void initState() {
    super.initState();
    selectedRadio = 1;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(56, 52, 175, 1.0),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(56, 52, 175, 1.0),
          title: Text(
            'ADMIN REGISTER',
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MyApp()),
              // );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20.0, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Colors.pink,
                      size: 13.0,
                    ),
                    Text(
                      ' Mandatory Fields',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: 70.0, right: 20.0, left: 20.0, bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildTextField('Enter Your First Name *'),
                    SizedBox(
                      height: 30.0,
                    ),
                    buildTextField('Enter Your Last Name *'),
                    SizedBox(
                      height: 30.0,
                    ),
                    buildTextField('Enter Your User Name  *'),
                    SizedBox(
                      height: 30.0,
                    ),
                    buildTextField('Enter Your Mobile (07x xxx xxx) *'),
                    SizedBox(
                      height: 30.0,
                    ),
                    buildTextField('Enter Your Email'),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Gender',
                          style:
                              TextStyle(fontSize: 13.0, color: Colors.white70),
                        ),
                        Radio(
                          value: 1,
                          groupValue: selectedRadio,
                          activeColor: Colors.white,
                          onChanged: (val) {
                            setSelectedRadio(val);
                          },
                        ),
                        Text(
                          'Male',
                          style:
                              TextStyle(fontSize: 13.0, color: Colors.white70),
                        ),
                        Radio(
                          value: 2,
                          groupValue: selectedRadio,
                          activeColor: Colors.white,
                          onChanged: (val) {
                            setSelectedRadio(val);
                          },
                        ),
                        Text(
                          'Female',
                          style:
                              TextStyle(fontSize: 13.0, color: Colors.white70),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    buildPasswordField(),
                    SizedBox(
                      height: 40.0,
                    ),
                    buildButtonContainer(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Already have an account ?',
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => MyApp()),
                                // );
                              },
                              child: Text(
                                'SIGN IN',
                                style: TextStyle(
                                  color: Colors.indigo[50],
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget buildTextField(String hintText) {
    return TextField(
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white70,
          fontSize: 13.0,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlue[400], width: 2.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlue[400], width: 2.0),
        ),
      ),
    );
  }

  Widget buildPasswordField() {
    return TextField(
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: 'Password',
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(
          color: Colors.white70,
          fontSize: 13.0,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlue[400], width: 2.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlue[400], width: 2.0),
        ),
      ),
      obscureText: true,
    );
  }

  Widget buildButtonContainer() {
    return Container(
      height: 56.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.indigoAccent[100],
      ),
      child: Center(
        child: Text(
          'REGISTER NOW',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
