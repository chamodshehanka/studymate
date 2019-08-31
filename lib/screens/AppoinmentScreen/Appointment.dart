import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var floatingActionButton2 = FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(6.0),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Patient ID',
                              labelStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14.0),
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.all(6.0),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Special Description',
                              labelStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14.0),
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.all(6.0),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Date',
                              labelStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14.0),
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.all(6.0),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Time',
                              labelStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14.0),
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.all(6.0),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Place',
                              labelStyle:
                                  TextStyle(color: Colors.grey, fontSize: 14.0),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: RaisedButton(
                          color: Colors.purple,
                          textColor: Colors.white,
                          elevation: 4.0,
                          splashColor: Colors.amberAccent,
                          child: Text("Request"),
                          onPressed: () {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Center(child: Text('Alert')),
                                    backgroundColor: Colors.white,
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "Successful Added",
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
                                                  child: Text('Yes'),
                                                  textColor:
                                                      Colors.purpleAccent,
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  }),
                                              FlatButton(
                                                  child: Text('No'),
                                                  textColor:
                                                      Colors.purpleAccent,
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  })
                                            ])
                                      ],
                                    ),
                                  );
                                });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      },
      child: Icon(Icons.add),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Management"),
      ),
      body: getNoteListView(),
      floatingActionButton: floatingActionButton2,
    );
  }

  getNoteListView() {}
}
