import 'package:flutter/material.dart';

class PlentyOfPetsTheme {
  static const _paragraphFontSize = 18.0;
  static const _paragraphFontWeight = FontWeight.w400;
  static const _standardColor = Colors.black;
  static const _invertedColor = Colors.white;

  static const paragraphText = TextStyle(
      fontSize: _paragraphFontSize,
      fontWeight: _paragraphFontWeight,
      color: _standardColor);
  static const buttonText = TextStyle(
      fontSize: _paragraphFontSize,
      fontWeight: _paragraphFontWeight,
      color: _invertedColor);

  static ThemeData getTheme() {
    return ThemeData(
        scaffoldBackgroundColor: Colors.green.shade100,
        fontFamily: 'Lato',
        textTheme:
            const TextTheme(bodyText2: paragraphText, button: buttonText));
  }
}
