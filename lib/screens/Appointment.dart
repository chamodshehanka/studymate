import 'package:flutter/material.dart';

void main(){
  

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Appointment Management',
      home:SIForm(),
      theme:ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.purple,
        buttonColor: Colors.purple,
        accentColor: Colors.purple,
        
        
      )
    )
  );
}
//class MyApp extends StatelessWidget {
// final String appTitle = 'Date & Time picker';
// @override
// Widget build(BuildContext context) => MaterialApp(
//       title: appTitle,
//       home: MainPage(appTitle: appTitle),
//    );
//}

//class MainPage extends StatelessWidget {
// final String appTitle;
// const MainPage({this.appTitle});

// @override
// Widget build(BuildContext context) => Scaffold(
//      appBar: AppBar(
//         title: Text(appTitle),
//       ),
//       body: Center(
//        child: (),
//      ),
//    );
//}

class SIForm extends StatefulWidget{

  @override
  State<StatefulWidget> createState(){

    return _SIFormState();
  }
}

  class _SIFormState extends State<SIForm>{

      final _minimumPadding = 4.0;

    Widget build(BuildContext context){

      TextStyle textStyle = Theme.of(context).textTheme.title;

      return Scaffold(
        appBar:AppBar(
          title: Text('Appointment Management') ,
        ),
        body: Container(
          margin: EdgeInsets.all(_minimumPadding * 4),
          child:Column(
            children: <Widget>[
              Padding(
                padding:EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child:TextField(
                  style:textStyle,
                decoration:InputDecoration(
                    labelText: 'Patient ID',
                    hintText: 'Enter Patient ID:IT18087048' ,
                    labelStyle:textStyle ,
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              )),
              Padding(
                padding:EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child:TextField(
                  style:textStyle,
                decoration:InputDecoration(
                    labelText: 'Patient Name',
                    hintText: 'Enter Patient Name:A B C Jayaprada' ,
                    labelStyle:textStyle ,
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              )),
              Padding(
              padding:EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
              child:TextField(
                style:textStyle,
                decoration:InputDecoration(
                    labelText: 'Special Description',
                    hintText: 'Enter Special Description:' ,
                    labelStyle:textStyle ,
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )
                )
              )),
              Padding(
                padding: EdgeInsets.only(bottom: _minimumPadding,top: _minimumPadding),
                child:Column(children: <Widget>[
                  Container(
                    margin:EdgeInsets.only(top:40.0 ),
                    width: 250.0,
                    height: 60.0,
                  child:RaisedButton(
                    
                    //splashColor: Colors.purple,
                    elevation:15.0 ,
                    highlightElevation: 20.0,
                    color:Colors.purple,
                    textTheme: ButtonTextTheme.primary,
                    padding: EdgeInsets.symmetric(vertical:20.0),
                    child:Text('Send',textScaleFactor: 1.5,),
                    onPressed:(){

                     }
                    ),
                  ),
            Container(
               margin:EdgeInsets.only(top:25.0 ),
               width: 250.0,
               height: 60.0,
              child: RaisedButton(
                elevation:15.0 ,
                highlightElevation: 20.0,
                color:Colors.purple,
                textTheme: ButtonTextTheme.primary,
                padding: EdgeInsets.symmetric(vertical:20.0),
                //color: Theme.of(context).primaryColorDark,
                //textColor: Theme.of(context).primaryColorLight,
                child:Text('Edit',textScaleFactor: 1.5,) ,
                onPressed: (){

                },
              ),
            ),
            Container(
               margin:EdgeInsets.only(top:25.0 ),
               width: 250.0,
               height: 60.0,
              child: RaisedButton(
                elevation:15.0 ,
                highlightElevation: 20.0,
                color:Colors.purple,
                textTheme: ButtonTextTheme.primary,
                padding: EdgeInsets.symmetric(vertical:20.0),
                //color: Theme.of(context).accentColor,
                //textColor: Theme.of(context).primaryColorDark,
                child:Text('Cancel',textScaleFactor: 1.5,) ,
                onPressed: (){
                },
              ),
              ),
            ],  
          ),
        ),
      ],
      )),
      );
    }
  }
