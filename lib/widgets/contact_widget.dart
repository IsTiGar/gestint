import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Si desea contactar con la administración puede enviar un mensaje de correo electrónico a las siguientes direcciones indicando el nombre, dni y cuerpo al cual pertenece:',
            textAlign: TextAlign.center,
            style:TextStyle(fontSize: 16)),
          SizedBox(height: 20),
          Text('Datos económicos:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('nomines@dgpdocen.caib.es'),
          SizedBox(height: 20),
          Text('Personal de primaria:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('primaria@dgpdocen.caib.es'),
          SizedBox(height: 20),
          Text('Personal de secundaria:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('secundaria@dgpdocen.caib.es'),
          SizedBox(height: 20),
          Text('Reconocimiento de formación del profesorado:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('sfhc@dgpice.caib.es'),
        ],
      ),
    );
  }
}