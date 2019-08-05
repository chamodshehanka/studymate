import 'package:flutter/material.dart';
import "package:carousel_slider/carousel_slider.dart";

class createSchedule extends StatefulWidget{
  @override
  _createScheduleState createState()=> _createScheduleState();
  
  }
  
class _createScheduleState extends State<createSchedule>{
  int counter = 0;
  void incrementCounter(){
    setState(() {
      counter++;
    }); 
  }
  List<String> days = new List();
  CarouselSlider instance;
  @override
  void initState() {

    super.initState();
    days.add("Sunday");
    days.add("Monday");
    days.add("Tuesday");
    days.add("Wednesday");
    days.add("Thursday");
    days.add("Friday");
    days.add("Saturday");
  }
 
  @override
  Widget build(BuildContext context) {
    
    instance = new CarouselSlider(
      items: days.map((d){
        return new Container(
          width :400,
          margin:new EdgeInsets.symmetric(horizontal:5.0),
          decoration:new BoxDecoration(
            color:Colors.amber
          ),
          child:new Text(d)
        );
      }).toList(),
      height:550,
      autoPlay: false,
      
      );

    return Scaffold(
      appBar: AppBar(title: Text("StudyMate"),
      backgroundColor: Colors.deepOrange,
      ),
      backgroundColor: Colors.white,
      body: instance

    );
    
      }
}

