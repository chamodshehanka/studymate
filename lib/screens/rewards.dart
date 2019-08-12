import 'package:flutter/material.dart';

class RewardsScreen extends StatefulWidget {
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Color(0xFF18D191), size: 10.0),
      ),
      body: MainContent(),
    );
  }
}

class MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: (const EdgeInsets.symmetric(horizontal: 15.0)),
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Rewards Management",
                        style: TextStyle(fontSize: 30.0),
                        textAlign: TextAlign.left)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 400.0,
                        child: FlatButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/badge'),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: (const EdgeInsets.only(
                                        top: 30.0, bottom: 20.0)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Color(0xFFFD7384),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 100.0, left: 20.0),
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 50.0,
                                            ),
                                          ),
                                          Text(
                                            "Badges",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: (const EdgeInsets.only(
                                        top: 20.0, bottom: 20.0)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Color(0XFF28D093),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 50.0, left: 20.0),
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 50.0,
                                            ),
                                          ),
                                          Text(
                                            "Achievements",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 30.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
