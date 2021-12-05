import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: MaterialColor(0xFFCC073C, {
        50:Color.fromRGBO(204,7,60, .1),
        100:Color.fromRGBO(204,7,60, .2),
        200:Color.fromRGBO(204,7,60, .3),
        300:Color.fromRGBO(204,7,60, .4),
        400:Color.fromRGBO(204,7,60, .5),
        500:Color.fromRGBO(204,7,60, .6),
        600:Color.fromRGBO(204,7,60, .7),
        700:Color.fromRGBO(204,7,60, .8),
        800:Color.fromRGBO(204,7,60, .9),
        900:Color.fromRGBO(204,7,60, 1),
      }),
      primaryColor: Color.fromARGB(255, 204, 7, 60),
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 50, 129, 75),
      ),
      scaffoldBackgroundColor: Color.fromARGB(255, 242, 242, 242),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: Color.fromARGB(255, 204, 7, 60),
      )
    );
  }
}