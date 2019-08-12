import 'package:flutter/material.dart';

class DoctorInputField extends StatefulWidget {
  final Icon fieldIcon;
  final String hintText;

  DoctorInputField(this.fieldIcon, this.hintText);

  @override
  _DoctorInputFieldState createState() => _DoctorInputFieldState();
}

class _DoctorInputFieldState extends State<DoctorInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.deepOrange,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.fieldIcon,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0)),
                ),
                width: 200,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.hintText,
                        fillColor: Colors.white,
                        filled: true),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
