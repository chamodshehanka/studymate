import 'package:flutter/material.dart';
import 'package:studymate/utils/validator.dart';

class StudymateTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController textEditingController;
  final Color color;
  final TextInputType keyboardType;
  final String validation;
  final Icon icon;

  StudymateTextField(this.labelText, this.textEditingController,
      this.validation, this.color, this.keyboardType, this.icon);

  _StudymateTextField createState() => _StudymateTextField();
}

class _StudymateTextField extends State<StudymateTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: 10.0, left: 20.0, top: 10.0, right: 20.0),
          child: TextFormField(
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: widget.icon,
              ),
              contentPadding:
                  EdgeInsetsDirectional.fromSTEB(20.0, 10.0, 20.0, 10.0),
              labelText: widget.labelText,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(),
              ),
            ),
            controller: widget.textEditingController,
            autofocus: false,
            validator: (value) {
              return Validator.validate(widget.validation, value);
            },
            keyboardType: widget.keyboardType,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
        ));
  }
}
