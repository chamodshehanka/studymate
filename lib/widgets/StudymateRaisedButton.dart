import 'package:flutter/material.dart';

class StudymateRaisedButton extends StatefulWidget {
  final String labelText;
  final Color color;
  final Function pressed;


  StudymateRaisedButton(this.labelText, this.pressed, this.color,);

  _StudymateRaisedButton createState() => _StudymateRaisedButton();
}

class _StudymateRaisedButton extends State<StudymateRaisedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: 10.0, left: 20.0, top: 10.0, right: 20.0),
          child: 
          ButtonTheme(
            height: 50,
            buttonColor: widget.color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            
            child:RaisedButton(
            elevation: 10.0,
            onPressed:widget.pressed,
            
            child: Text(widget.labelText),
            textColor: Colors.white,
            
          )
        
          ),
        ));
  }
}
