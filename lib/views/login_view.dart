import 'package:flutter/material.dart';
import 'package:gestint/contracts/user_view_contract.dart';
import 'package:gestint/presenters/user_presenter.dart';

import 'main_menu_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> implements UserViewContract {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late UserPresenter _userPresenter;
  bool _isLoading = true;
  TextEditingController _userController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userPresenter = UserPresenter(this);
  }

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
                    controller: _userController,
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
                    controller: _passwordController,
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
                          var id = _userController.text;
                          var password = _passwordController.text;
                          _userPresenter.checkUserCredentials(id, password);
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

  @override
  void onCheckUserCredentialError() {
    setState(() {
      _isLoading = false;
      _showErrorDialog();
    });
  }

  @override
  void onCheckUserCredentialsComplete(bool match) {
    if (match) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainMenuView()),
      );
    }else {
      _showErrorDialog();
    }
  }

  Future<void> _showErrorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atención'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text('Estos credenciales son incorrectos'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Entendido'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}