import 'package:flutter/material.dart';

ThemeData buildTheme() {
  
  TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
        headline: base.headline.copyWith(
          fontFamily: 'Merriweather',
          fontSize: 40.0,
          color: const Color(0xFF555555),
        ),
        title: base.title.copyWith(
          fontFamily: 'Merriweather',
          fontSize: 15.0,
          color: const Color(0xFF555555),
        ),
        caption: base.caption.copyWith(
          color: const Color(0xFF555555),
        ),
        body1: base.body1.copyWith(color: const Color(0xFF555555)));
  }

  
  final ThemeData base = ThemeData.light();


  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
    primaryColor: const Color(0xFF2196F3),
    accentColor: const Color(0xFFFFFFFF),
    iconTheme: IconThemeData(
      color: const Color(0xFFCCCCCC),
      size: 20.0,
    ),
    buttonColor: Colors.white,
    backgroundColor: Colors.white,
  );
}