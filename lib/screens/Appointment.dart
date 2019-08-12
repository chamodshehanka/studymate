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
                                labelText: 'Patient ID',
                                hintText: '' ,
                                  ),
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child:TextField(
                                decoration:InputDecoration(
                                labelText: 'Special Description',
                                hintText: '' ,
                                  ),
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child:TextField(
                                decoration:InputDecoration(
                                labelText: 'Date',
                                hintText: '' ,
                                  ),
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child:TextField(
                                decoration:InputDecoration(
                                labelText: 'Time',
                                hintText: '' ,
                                  ),
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child:TextField(
                                decoration:InputDecoration(
                                labelText: 'Place',
                                hintText: '' ,
                                  ),
                                )
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  child: Text("Request"),
                                  onPressed: () {
                                    showDialog(
              context: context,
              
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(child: Text('Alert')),                 
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                              child: Text('Yes'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          FlatButton(
                              child: Text('No'),
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
