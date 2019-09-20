import 'package:flutter/material.dart';

class StudymateDropdown extends StatefulWidget {

    
final List<String> valueList;
final String labelText;


StudymateDropdown(this.labelText,this.valueList);

  
 _StudymateDropdownState createState() => _StudymateDropdownState();

}


class _StudymateDropdownState extends State<StudymateDropdown> {
  String selectedValue;
@override
Widget build(BuildContext context) {
  return Container(
      width: 350,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.0,left: 20.0,top: 10.0,right: 20.0),
        child: DropdownButton<String>(
        hint: Text(widget.labelText),
        value: selectedValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        isExpanded: true,
        elevation: 16,
        style: TextStyle(
          color: Colors.deepPurple
        ),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String newValue) {
          setState(() {
            selectedValue = newValue;
          });
        },
        items: widget.valueList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          })
          .toList(),
      ),
  ),
  );
}
}