import 'package:flutter/material.dart';

class HomeTile extends StatelessWidget {
  final IconData icon;
  final String  title;
  final Color background;
  final String path;
  

  HomeTile(this.icon, this.title, this.background,this.path);
  @override
  Widget build(BuildContext context) {
      return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(50),
        child: Container(
          width: 300,
          height: 300,
          child: RaisedButton(
              elevation: 10.0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              onPressed: () => Navigator.pushNamed(context, path),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                        color: background,
                      ),
                      width: 100,
                      height: 100,
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 60.0,
                      )),
                  SizedBox(height: 10.0),
                  Text(
                    title,
                    style: TextStyle(
                      color: background,
                      decoration: TextDecoration.none,
                      fontSize: 16.0,
                      fontFamily: "OpenSans",
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
