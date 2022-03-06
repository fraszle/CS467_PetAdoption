import 'package:flutter/material.dart';

class PlentyOfPetsTheme {
  static const _paragraphFontSize = 20.0;
  static const _paragraphFontWeight = FontWeight.w400;
  static const _standardColor = Colors.black;
  static final _stylizedColor = Colors.brown.shade200;

  static const formErrorText = TextStyle(
    fontSize: 18,
    color: Colors.red,
  );
  static const paragraphText = TextStyle(
      fontSize: _paragraphFontSize,
      fontWeight: _paragraphFontWeight,
      color: _standardColor);
  static TextStyle captionText = TextStyle(
      fontFamily: 'IndieFlower',
      fontSize: 25,
      color: Colors.brown.shade900,
      fontWeight: FontWeight.bold);
  static TextStyle headlineText =
      TextStyle(fontFamily: 'IndieFlower', fontSize: 60, color: _stylizedColor);
  static TextStyle headlineTextOutline = TextStyle(
      fontFamily: 'IndieFlower',
      fontSize: 60,
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = Colors.black);
  static TextStyle buttonText = TextStyle(
      fontSize: _paragraphFontSize,
      fontWeight: _paragraphFontWeight,
      color: Colors.brown.shade200);
  static TextStyle petCardText = const TextStyle(
      fontFamily: 'Lato',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 20, 77, 23));
  static TextStyle petCardName = const TextStyle(
      fontFamily: 'IndieFlower',
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 248, 121, 17));
  static TextStyle noFavs = const TextStyle(
      fontFamily: 'IndieFlower',
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 17, 8, 1));
  static TextStyle petFormTitle = const TextStyle(
      color: Colors.black,
      fontSize: 40,
      fontWeight: FontWeight.bold);
  static TextStyle petFormSubheading = const TextStyle(
      color: Colors.blue,
      fontSize: 20,
      fontWeight: FontWeight.bold);

  static OutlinedButtonThemeData outlinedButtonThemeData =
      OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              backgroundColor: Colors.white,
              shadowColor: Colors.black,
              elevation: 5,
              side: BorderSide(width: 2.0, color: _stylizedColor),
              textStyle: buttonText));

  static ThemeData getTheme() {
    return ThemeData(
        scaffoldBackgroundColor: Colors.green.shade200,
        fontFamily: 'Lato',
        textTheme: TextTheme(
            bodyText2: paragraphText,
            button: buttonText,
            headline3: headlineText,
            caption: captionText),
        outlinedButtonTheme: outlinedButtonThemeData);
  }
}
