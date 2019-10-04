import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:studymate/screens/AppointmentScreen_New/DoctorAppointmentUI.dart';

class DashboardAppointment extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashboardAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation:10,
        titleSpacing: 300,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  width: 50,
                  child: Icon(
                    Icons.notifications,
                    color: Theme.of(context).accentColor,
                    size: 40,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  width: 20,
                  height: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.red,
                    ),
                    width: 20,
                    height: 20,
                    child: Center(
                      child: Text(
                        '03',
                        style: TextStyle(
                          color: Colors.white,fontStyle: FontStyle.italic,
                          fontSize:10,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25, 30, 25, 25),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width:100,
                  height: 100,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.deepPurple,
                  ),
                  child: Image.asset(
                    'assets/images/how-to-roll-up-calendars-in-sharepoint-icons-png-22.png',
                    width: 10,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Text(
                  '125',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 80,
                    fontFamily: 'Bebas',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '0'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '120'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      LinearPercentIndicator(
                        lineHeight: 8.0,
                        percent: 0.7,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        backgroundColor:
                            Theme.of(context).accentColor.withAlpha(30),
                        progressColor:Colors.deepPurple
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                      ),
                      Text(
                        ' Appointment Taken'.toUpperCase(),
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontFamily: 'Bebas',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 25,
                  color: Colors.grey[300],
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'APPROVED',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '259',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'UNAPPROVED',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '102',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 25,
                  color: Colors.grey[300],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminAppointmentListScreen(),
                      ),
                    );
                  },
                  minWidth: double.infinity,
                  height: 50,
                  child: Text(
                    'APPOINTMENTS'.toUpperCase(),
                  ),
                  color: Colors.deepPurple,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final double total;
  final double achieved;
  final Image image;
  final Color color;

  const StatCard({
    Key key,
    @required this.title,
    @required this.total,
    @required this.achieved,
    @required this.image,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey[200],
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      
    );
  }
}
