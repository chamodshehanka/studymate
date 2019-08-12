import 'package:flutter/material.dart';

void main() => runApp(Badges());

class Badges extends StatefulWidget {
  @override
  _BadgesState createState() => _BadgesState();
}

class _BadgesState extends State<Badges> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController badgeNameCtrl = TextEditingController();
  final TextEditingController typeCtrl = TextEditingController();
  final TextEditingController milestoneCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Badge",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Color(363553),
                Color(903775),
              ])),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      height: 180.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.indigo, width: 3.0),
                          right: BorderSide(color: Colors.indigo, width: 3.0),
                          left: BorderSide(color: Colors.indigo, width: 3.0),
                          bottom: BorderSide(color: Colors.indigo, width: 3.0),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: Icon(Icons.add,
                          size: 160.0, color: Colors.grey.shade500),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.indigo,
                          width: 1.5,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      labelText: "Badge Name",
                      labelStyle: TextStyle(
                          color: Colors.indigo, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
