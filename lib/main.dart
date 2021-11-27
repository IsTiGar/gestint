import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'theme/custom_theme.dart';
import 'views/login_view.dart';
import 'views/main_menu_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

Map<int, Color> color =
{
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
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme.lightTheme,
      home: MainMenuView(), //TODO cambiar a LoginView
    );
  }
}
