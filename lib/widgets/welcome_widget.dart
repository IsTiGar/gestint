import 'package:flutter/widgets.dart';

class WelcomeWidget extends StatelessWidget {

  WelcomeWidget ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Expanded(
        child: Text(
          'Bienvenido al portal del personal de la Consejeria de Educación y Formación Profesional de las Islas Baleares',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}