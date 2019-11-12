import 'package:studymate/screens/ScheduleScreen/DailySchedule.dart';
import 'package:studymate/screens/ScheduleScreen/WeeklyPlanScreen.dart';
import 'package:studymate/screens/SubjectsScreen/SubjectListUI.dart';
import 'package:studymate/services/Authentication.dart';
import 'package:studymate/widgets/Navigation/extended_navbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:studymate/screens/ActivityScreen/ActivitiesListUI.dart';
import 'package:studymate/screens/HomeScreen/HomeUI.dart';

class StudentMainScreen extends StatefulWidget {
  StudentMainScreen({Key key}) : super(key: key);

  _StudentMainScreenState createState() => _StudentMainScreenState();
}

class _StudentMainScreenState extends State<StudentMainScreen> {
  BaseAuthentication _authentication = Authentication();
  Widget activeScreen = HomeScreen();
  @override
  Widget build(BuildContext context) {
    return ExtendedNavigationBarScaffold(
      body: activeScreen,
      elevation: 0,
      navBarColor: Colors.deepPurple,
      navBarIconColor: Colors.white,
      moreButtons: [
        MoreButtonModel(
          icon: Icons.home,
          label: 'Home',
          onTap: () {
            setState(() {
              activeScreen = HomeScreen();
            });
          },
        ),
        MoreButtonModel(
          icon: Icons.today,
          label: 'Daily Schedule',
          onTap: () {
            setState(() {
              activeScreen = DailyScheduleScreen();
            });
          },
        ),
        MoreButtonModel(
          icon: Icons.calendar_today,
          label: 'Schedules',
          onTap: () {
            setState(() {
              activeScreen = WeeklyPlanScreen();
            });
          },
        ),
        MoreButtonModel(
          icon: Icons.local_activity,
          label: 'Activities',
          onTap: () {
            setState(() {
              activeScreen = ActivityListScreen();
            });
          },
        ),
        MoreButtonModel(
          icon: Icons.library_books,
          label: 'Subjects',
          onTap: () {
            setState(() {
              activeScreen = SubjectListScreen();
            });
          },
        ),
        MoreButtonModel(
          icon: Icons.local_hospital,
          label: 'Appointments',
          onTap: () {},
        ),
        null,
        MoreButtonModel(
          icon: Icons.chat,
          label: 'Chat',
          onTap: () {
             Navigator.pushNamed(context, '/chatMain');
          },
        ),
        null,
      ],
      searchWidget: Container(
        height: 200,
        child: Row(
          children: <Widget>[
            RaisedButton(
              child: Icon(Icons.close),
              onPressed: () {
                _authentication.signOut();
                Navigator.pushNamed(context, '/welcome');
              },
            ),
          ],
        ),
      ),
      // onTap: (button) {},
      // currentBottomBarCenterPercent: (currentBottomBarParallexPercent) {},
      // currentBottomBarMorePercent: (currentBottomBarMorePercent) {},
      // currentBottomBarSearchPercent: (currentBottomBarSearchPercent) {},
      parallexCardPageTransformer: PageTransformer(
        pageViewBuilder: (context, visibilityResolver) {
          return PageView.builder(
            controller: PageController(viewportFraction: 0.85),
            itemCount: parallaxCardItemsList.length,
            itemBuilder: (context, index) {
              final item = parallaxCardItemsList[index];
              final pageVisibility =
                  visibilityResolver.resolvePageVisibility(index);
              return ParallaxCardsWidget(
                item: item,
                pageVisibility: pageVisibility,
              );
            },
          );
        },
      ),
    );
  }

  final parallaxCardItemsList = <ParallaxCardItem>[
    ParallaxCardItem(
        title: 'Some Random Route 1',
        body: 'Place 1',
        background: Container(
          color: Colors.orange,
        )),
    ParallaxCardItem(
        title: 'Some Random Route 2',
        body: 'Place 2',
        background: Container(
          color: Colors.redAccent,
        )),
    ParallaxCardItem(
        title: 'Some Random Route 3',
        body: 'Place 1',
        background: Container(
          color: Colors.blue,
        )),
  ];
}
