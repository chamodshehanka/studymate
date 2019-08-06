import 'package:flutter/material.dart';

class AccountTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 60.0),
            child: Icon(
              Icons.business,
              color: Colors.blueAccent,
              size: 125.0,
            ),
          ),
           Padding(
            padding: const EdgeInsets.only(top: 35.0, right: 15.0, left: 15.0),
            child: Text(
              "Select Your Account Type!",
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blueAccent,
                decoration: TextDecoration.none,
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
            child: CustomFlatButton(
              title: "I'm Going To A School",
              fontSize: 22,
              fontWeight: FontWeight.w700,
              textColor: Colors.white,
             onPressed: () {
                Navigator.of(context).pushNamed("/signup");
              },
              splashColor: Colors.black12,
              borderColor: Colors.white,
              borderWidth: 0,
              color: Colors.blueAccent,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
            child: CustomFlatButton(
              title: "I'm Not Going To A School",
              fontSize: 22,
              fontWeight: FontWeight.w700,
              textColor: Colors.black54,
              onPressed: () {
                Navigator.of(context).pushNamed("/signup1");
              },
            
              splashColor: Colors.black12,
              borderColor: Colors.black12,
              borderWidth: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomFlatButton extends StatelessWidget {
  final String title;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onPressed;
  final Color color;
  final Color splashColor;
  final Color borderColor;
  final double borderWidth;

  CustomFlatButton(
      {this.title,
      this.textColor,
      this.fontSize,
      this.fontWeight,
      this.onPressed,
      this.color,
      this.splashColor,
      this.borderColor,
      this.borderWidth});

 @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      color: color,
      splashColor: splashColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          title,
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            decoration: TextDecoration.none,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: "OpenSans",
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(
          color: borderColor,
          width: borderWidth,
        ),
      ),
    );
  }
}
