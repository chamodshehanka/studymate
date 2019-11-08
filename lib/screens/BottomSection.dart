import 'package:flutter/material.dart';

class BottomSection extends StatefulWidget {
  const BottomSection({
    Key key,
  }) : super(key: key);

  @override
  _BottomSectionState createState() => _BottomSectionState();
}

class _BottomSectionState extends State<BottomSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            height: (MediaQuery.of(context).size.height * 0.22),
            child: PageView(
              physics: BouncingScrollPhysics(),
              pageSnapping: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[],
            )),
        Divider(
          height: 1,
          color: Colors.black54,
          indent: 5,
          endIndent: 5,
        ),
      ],
    );
  }
}
