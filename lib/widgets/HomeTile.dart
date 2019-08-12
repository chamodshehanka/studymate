import 'package:flutter/material.dart';

class HomeTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  HomeTile(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
        child: InkWell(
          splashColor: Colors.orangeAccent,
          onTap: onTap,
          child: Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: <Widget>[
                  Icon(icon),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(text, style: TextStyle(fontSize: 16.0)),
                  ),
                ]),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ));
  }
}
