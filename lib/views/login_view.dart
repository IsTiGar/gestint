import 'package:flutter/material.dart';

import 'main_menu_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // this avoids overflow when keyboard is visible
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image(image: AssetImage('assets/images/flag.png')),
                SizedBox(width: 30),
                Expanded(
                  child: Text(
                    'Direcció general de personal docent',
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Usuario',
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 18,
                    ),
                  ),
                  TextFormField(
                    //this moves the cursor to the next field
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: 'Ejemplo: X12345678',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, introduce tu usuario';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Contraseña',
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  TextFormField(
                    // this hides the keyboard
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(

                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, introduce tu usuario';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState!.validate()) {
                          // Check credentials on FireStore ************ //TODO
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MainMenuView()),
                          );
                        }
                      },
                      child: const Text('Entrar'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 40),
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ElevatedButton(
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_formKey.currentState!.validate()) {
                            // Process data.
                          }
                        },
                        child: const Text('Entrar con certificado digital'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 40),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ElevatedButton(
                        onPressed: () {
                          // Validate will return true if the form is valid, or false if
                          // the form is invalid.
                          if (_formKey.currentState!.validate()) {
                            // Process data.
                          }
                        },
                        child: const Text('Entrar con huella digital'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 40),
                        )
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}