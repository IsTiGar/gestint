import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.red,
      primaryColor: Color.fromARGB(255, 204, 7, 60),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      scaffoldBackgroundColor: Color.fromARGB(255, 242, 242, 242),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: Color.fromARGB(255, 204, 7, 60),
      )
    );
  }
}