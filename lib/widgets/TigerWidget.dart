import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class TigerWidget extends StatefulWidget {
  final String animation;
  TigerWidget({Key key, @required this.animation});

  _TigerWidgetState createState() => _TigerWidgetState();
}

/// animation types:
/// fail
/// success
/// idle
/// test
class _TigerWidgetState extends State<TigerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: FlareActor(
        'assets/animations/tiger.flr',
        animation: widget.animation,
      ),
    );
  }
}
