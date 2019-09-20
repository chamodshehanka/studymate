import 'package:flutter/material.dart';

class StudymateTextField extends StatefulWidget {
  
  final String labelText;
  final TextEditingController textEditingController;
  final String validation;
  final Color color;
  final TextInputType keyboardType;

  StudymateTextField(this.labelText,this.textEditingController,this.validation,this.color,this.keyboardType);

  _StudymateTextField createState() => _StudymateTextField();
}

class _StudymateTextField extends State<StudymateTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
    
      child: 
      Padding(
        padding: EdgeInsets.only(bottom: 10.0,left: 20.0,top: 10.0,right: 20.0),
        child: TextFormField(
                      decoration: new InputDecoration(
                        labelText: widget.labelText,
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                          ),
                        ),
                      ),
                      validator: (val) {
                        if(val.length==0) {
                          return widget.validation;
                        }else{
                          return null;
                        }
                      },
                      keyboardType: widget.keyboardType,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
      )
      
    );
  }
}
