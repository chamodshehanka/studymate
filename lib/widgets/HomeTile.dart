import 'package:flutter/material.dart';

class HomeTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color background;
  final String path;

  HomeTile(this.icon, this.title, this.background, this.path);

  Widget _buildCardContent() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Material(
                color: Colors.transparent,
                child: Text(
                  this.title,
                  style: TextStyle(
                    fontSize: 20,
                    height: 0.9,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDecorations() {
    return [
      Positioned(
        bottom: -200 * 0.050,
        right: -200 * 0.034,
        child: Icon(
          this.icon,
          size: 150,
          color: Colors.white.withOpacity(0.14),
        ),
      ),
      Positioned(
        bottom: 8,
        right: 12,
        child: Container(
          child: Image.asset(
            "assets/images/minion.png",
            fit: BoxFit.contain,
            width: 75,
            height: 75,
            alignment: Alignment.bottomRight,
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 200,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Card(
        child: Material(
          color: this.background,
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, path),
            splashColor: Colors.white10,
            highlightColor: Colors.white10,
            child: Stack(
              children: [
                _buildCardContent(),
                ..._buildDecorations(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
