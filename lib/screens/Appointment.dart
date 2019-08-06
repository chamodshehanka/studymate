import 'package:flutter/material.dart';

void main(){
  

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Appointment Management',
      home:MyApp(),//SIForm(),
      theme:ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.purple,
        buttonColor: Colors.purple,
        accentColor: Colors.purple,
        //home:new MyApp(),
      )
    )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
                                padding: EdgeInsets.all(8.0),
                                child:TextField(
                                decoration:InputDecoration(
                                labelText: 'Patient Name',
                                hintText: 'Enter Patient Name:' ,
                                  ),
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child:TextField(
                                decoration:InputDecoration(
                                labelText: 'Special Description',
                                hintText: 'Enter Special Description:' ,
                                  ),
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child:TextField(
                                decoration:InputDecoration(
                                labelText: 'Appointment Date',
                                hintText: 'Enter Appointment Date:' ,
                                  ),
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child:TextField(
                                decoration:InputDecoration(
                                labelText: 'Appointment Time',
                                hintText: 'Enter Appointment Time:' ,
                                  ),
                                )
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  child: Text("Request"),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                    }
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