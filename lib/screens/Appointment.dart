import 'package:flutter/material.dart';
//import 'dart:async';
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
        //home:new MyApp(),
      )
    )
  );
}
/*class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}
class _State extends State<MyApp>{

    DateTime _date = new DateTime.now();
    TimeOfDay _time = new TimeOfDay.now();

    Future<Null> _selectDate(BuildContext cotext) async{
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: _date,
          firstDate: new DateTime(2016),
          lastDate: new DateTime(2016)
      );
      if(picked != null && picked != _date){
        print('Date selected: ${_date.toString()}');
        setState((){
          _date = picked;
        });
      }
    }
    Future<Null> _selectTime(BuildContext cotext) async{
      final TimeOfDay picked = await showTimePicker(
          context: context,
          initialTime: _time,
      );
      if(picked != null && picked != _time){
        print('Time selected: ${_time.toString()}');
        setState((){
          _time = picked;
        });
      }
    }

    @override
    Widget build(BuildContext context){
      return new Scaffold(
        appBar: new AppBar(
          title:new Text('Name here'),
        ),
      body:new Container(
        padding:new EdgeInsets.all(32.0),
        child:new Column(
        children:<Widget>[
          new Text('Date selected: ${_date.toString()}'),
          new RaisedButton(
            child:new Text('Select Date'),
            onPressed:(){_selectDate(context);}
            ),
            new Text(''),
            new Text('Time selected: ${_time.toString()}'),
            new RaisedButton(
              child:new Text('Select Time'),
              onPressed:(){_selectDate(context);}
            ),
          ],
        ),
      ),
    );
  }
}
*/
class SIForm extends StatefulWidget{

  @override
  State<StatefulWidget> createState(){

    return _SIFormState();
  }
}

  class _SIFormState extends State<SIForm>{

      final _minimumPadding = 5.0;

    Widget build(BuildContext context){

      TextStyle textStyle = Theme.of(context).textTheme.title;

      return Scaffold(
        appBar:AppBar(
          title: Text('Appointment Management') ,
        ),
        body: Container(
          margin: EdgeInsets.all(_minimumPadding * 1),
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
                    margin:EdgeInsets.only(top:100.0 ),
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
               margin:EdgeInsets.only(top:10.0 ),
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
               margin:EdgeInsets.only(top:10.0 ),
               width: 250.0,
               height:60.0,
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
