/// © Israel Tierno García
/// Reservados todos los derechos. Está prohibido la reproducción total o parcial de esta obra por cualquier medio o procedimiento,
/// comprendidos la impresión, la reprografía, el microfilme, el tratamiento informático o cualquier otro sistema,
/// así como la distribución de ejemplares mediante alquiler y préstamo, sin la autorización escrita del autor
/// o de los límites que autorice la Ley de Propiedad Intelectual.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gestint/models/user.dart';
import 'package:provider/provider.dart';
import 'theme/custom_theme.dart';
import 'views/login_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => User(),
      child: MyApp(),
  ),);
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
      title: 'Gestint',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ca', ''), // Catalan
        Locale('es', ''), // Spanish
      ],
      theme: CustomTheme.lightTheme,
      home: LoginView(),
    );
  }
}
