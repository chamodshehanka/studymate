import 'package:flutter/material.dart';

class EditAdminProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EditAdminProfilePage(),
    );
  }
}

class EditAdminProfilePage extends StatefulWidget {
  @override
  _EditAdminProfilePage createState() => _EditAdminProfilePage();
}

class _EditAdminProfilePage extends State<EditAdminProfilePage> {
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
            'EDIT PROFILE',
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigator.push(
              // context,
              // MaterialPageRoute(builder: (context) => MyApp()),
              // );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: 40.0, right: 20.0, left: 20.0, bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildTextField('Thilini Dureksha'),
                    SizedBox(
                      height: 30.0,
                    ),
                    buildTextField('0711489992'),
                    SizedBox(
                      height: 30.0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    buildTextField('1996-04-07'),
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
                    buildTextField('300/p/6 20 Feet Road Walisara Ragama'),
                    SizedBox(
                      height: 30.0,
                    ),
                    buildTextField('Malabe'),
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
          color: Colors.white,
          fontSize: 15.0,
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
          fontSize: 15.0,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 50.0,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.orange,
          ),
          child: Center(
            child: Text(
              'Update',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
        Container(
          height: 50.0,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.red[800],
          ),
          child: Center(
            child: Text(
              'Remove',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
