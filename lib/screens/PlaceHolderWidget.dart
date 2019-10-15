import 'package:flutter/material.dart';
import 'package:studymate/screens/ActivityScreen/ActivitiesUI.dart';
import 'package:studymate/screens/ScheduleScreen/ScheduleManagerMain.dart';
import 'package:studymate/screens/StudentScreen/studentProfileUI.dart';

import 'HomeScreen/HomeUI.dart';

class PlaceholderWidget extends StatefulWidget {
 final int index;

 PlaceholderWidget(this.index);
   _PlaceHolderState createState() => _PlaceHolderState();
}

class _PlaceHolderState extends State<PlaceholderWidget> {

 @override
 Widget build(BuildContext context) {

   switch(widget.index){
     case 0 : return HomeScreen();
      break;
      case 1 :return ScheduleManagerHome();
      break;

      case 2:return ActivityScreen();
      break;

      default:return ProfileUIScreen();

   }
   
   
   
   
  
 }

  
}