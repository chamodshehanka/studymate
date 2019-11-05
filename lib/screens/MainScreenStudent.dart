import 'package:flutter/material.dart';
import 'package:flurry_navigation/flurry_navigation.dart';
import 'package:flurry_navigation/flurry_menu.dart';
import 'package:studymate/screens/ActivityScreen/ActivitiesListUI.dart';
import 'package:studymate/screens/BottomSection.dart';
import 'package:studymate/screens/HomeScreen/HomeUI.dart';
import 'package:studymate/screens/ScheduleScreen/DailySchedule.dart';

class StudentMainScreen extends StatefulWidget {
  @override
  _StudentMainScreenState createState() => new _StudentMainScreenState();
}

class _StudentMainScreenState extends State<StudentMainScreen> {
  //Decalre active screen var with the the default screen somewhere accesible to the contentScreen attributes
  var activeScreen = studentHome;
  Widget build(BuildContext context) {
    return new FlurryNavigation(
      // The curve of the screen (Double)
      curveRadius: (MediaQuery.of(context).size.width *MediaQuery.of(context).size.height)/4980,
      // The Icon data of the icon the BottomLeft
      expandIcon: Image.asset("assets/expand.png"),
      // The size of the icon on the BottomLeft (Double)
      iconSize: ((MediaQuery.of(context).size.width * MediaQuery.of(context).size.height)/15420),
      // The content of the screen
      contentScreen: activeScreen,
      menuScreen: new FlurryMenu(
        bgColor: Colors.deepPurple,
      // The content of the bottom sction of the menu screen
//BottomSection() Class is an example of what you can use

bottomSection: BottomSection(),
        menu: new SideMenu(
          items: [
            new SideMenuItem(
              id:'home', //You can set this to whatever you want but dont duplicate it
              icon:'assets/images/home.png', //Set this to the data for the icon of the button
              isSelected: true,
              selectedBtnColor: Colors.deepPurpleAccent,
              disabledBtnColor: Colors.white,
              btnShape: BoxShape.circle),
            new SideMenuItem(
              id: 'daily',
              icon: 'assets/images/daily.png',
              isSelected: false,
              selectedBtnColor: Colors.deepPurpleAccent,
              disabledBtnColor: Colors.white,
              btnShape: BoxShape.circle),
            new SideMenuItem(
              id:'weekly',
              icon:'assets/images/weekly.png',
              isSelected: false,
              selectedBtnColor: Colors.deepPurpleAccent,
              disabledBtnColor: Colors.white,
              btnShape: BoxShape.circle),
            new SideMenuItem(
              id:'activity',
              icon:'assets/images/activities.png',
              isSelected:false,
             selectedBtnColor: Colors.deepPurpleAccent,
             disabledBtnColor: Colors.white,
              btnShape: BoxShape.circle),
              new SideMenuItem(
              id: 'subject',
              icon: 'assets/images/subject.png',
              isSelected: false,
              selectedBtnColor: Colors.deepPurpleAccent,
              disabledBtnColor: Colors.white,
              btnShape: BoxShape.circle),
              new SideMenuItem(
              id: 'appointment',
              icon: 'assets/images/appointment.png',
              isSelected: false,
              selectedBtnColor: Colors.deepPurpleAccent,
              disabledBtnColor: Colors.white,
              btnShape: BoxShape.circle),
              new SideMenuItem(
              id: 'chat',
              icon: 'assets/images/chat.png',
              isSelected: false,
              selectedBtnColor: Colors.deepPurpleAccent,
              disabledBtnColor: Colors.white,
              btnShape: BoxShape.circle),new SideMenuItem(
              id: 'profile',
              icon: 'assets/images/profile.png',
              isSelected: false,
              selectedBtnColor: Colors.deepPurpleAccent,
              disabledBtnColor: Colors.white,
              btnShape: BoxShape.circle),


          ],
        ),
        onMenuItemSelected: (String itemId) {
          if (itemId == 'home') {
            setState(() => activeScreen = studentHome);
          } else if (itemId == 'daily') {
            setState(() => activeScreen = dailySchedule);
          } else if (itemId == 'weekly') {
            setState(() => activeScreen = activityList);
          } else if (itemId == 'activity') {
            setState(() => activeScreen = activityList);
          } else if (itemId == 'activity') {
            setState(() => activeScreen = activityList);
          }
        },
      ),
    );
  }
}
