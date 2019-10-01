import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studymate/services/custom/ActivityService.dart';
import 'package:studymate/widgets/CurveClipper.dart';

class ActivityAdminDashboardScreen extends StatefulWidget {
  _ActivityAdminDashboardScreenState createState() =>
      _ActivityAdminDashboardScreenState();
}

class _ActivityAdminDashboardScreenState
    extends State<ActivityAdminDashboardScreen>
    with SingleTickerProviderStateMixin {
  int noOfAllActivities = 10;
  int noOfLeisureActivities = 20;
  int noOfSocialActivities = 30;
  int noOfOtherActivities = 0;
  // AnimationController _controller;
  // Animation<double> _heightAnimation;
  // Animation<double> _iconSizeAnimation;

  @override
  void initState() {
    super.initState();

    _getActivitiesCount();
    // Theme block
    // _controller = new AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 300),
    // );

    // _heightAnimation = new Tween<double>(begin: 0.0, end: 220.0).animate(
    //     new CurvedAnimation(curve: Curves.decelerate, parent: _controller));

    // _iconSizeAnimation = new Tween<double>(begin: 10, end: 35.0).animate(
    //     new CurvedAnimation(curve: Curves.easeOut, parent: _controller));

    // _controller.addListener(() {
    //   setState(() {});
    // });

    // _heightAnimation.toString();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: media.height,
        width: media.width,
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: CurveClipper(),
              child: Container(
                width: media.width,
                height: media.height * .25,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff5f27cd), Color(0xff341f97)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              width: media.width,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'Activities Dashboard',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Positioned(
              top: media.height * .08,
              width: media.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 20,
                ),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xffeff2f3),
                          offset: Offset(1, 5.0),
                          blurRadius: 3.0)
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      buildDashboardRow1(),
                      Divider(
                        color: Colors.grey,
                        height: 1,
                      ),
                      buildDashboardRow2(),
                    ],
                  ),
                ),
              ),
            ),
            //Add Another position
            // https://www.youtube.com/watch?v=L6UKUfLmrNg
          ],
        ),
      ),
    );
  }

  // Widget _buildRoomItem(BoxConstraints constraints, Size media) {
  //   return Container();
  // }

  // Widget _buildRoutinesItem(Size media) {
  //   return Container();
  // }

  Widget buildDashboardRow1() {
    return Expanded(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage('assets/images/kids.png'),
                          fit: BoxFit.contain),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'No of all activities',
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          noOfAllActivities.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                        // Container(
                        //   width: 30,
                        //   height: 12,
                        //   padding: const EdgeInsets.all(1.5),
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(2),
                        //     border: Border.all(color: Colors.grey, width: 0.5),
                        //   ),
                        //   child: Container(
                        //     padding: const EdgeInsets.only(right: 7),
                        //     child: Container(
                        //       decoration: BoxDecoration(
                        //         color: Color(0xff0ed02d),
                        //         borderRadius: BorderRadius.circular(2),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(color: Colors.grey, width: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 75,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('assets/images/leisure.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Leisure Activities',
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          noOfLeisureActivities.toString(),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDashboardRow2() {
    return Expanded(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('assets/images/speaking.jpg'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Social Activities',
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold)),
                        Text(noOfSocialActivities.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15)),
                        // Text('Done 9.30', style: TextStyle(fontSize: 13.5)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(
            color: Colors.grey,
            width: 1,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 75,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage('assets/images/swimming.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Other Activities',
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold)),
                        Text(noOfOtherActivities.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15)),
                        // SizedBox(
                        //   height: 20,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _getActivitiesCount() {
    Stream<QuerySnapshot> activityList = ActivityService().getActivityList();
    activityList.forEach((activity) {
      print(activity.documents);
    });
  }
}
