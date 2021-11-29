import 'package:flutter/material.dart';
import 'package:gestint/contracts/user_view_contract.dart';
import 'package:gestint/models/user.dart';
import 'package:gestint/presenters/user_presenter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    _userController.clear();
    _passwordController.clear();
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
                    AppLocalizations.of(context)!.dgp,
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
                    AppLocalizations.of(context)!.user,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 18,
                    ),
                  ),
                  TextFormField(
                    //this moves the cursor to the next field
                    textInputAction: TextInputAction.next,
                    controller: _userController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.example,
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.enter_user;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  Text(
                    AppLocalizations.of(context)!.password,
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
                    obscureText: true,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.enter_password;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ElevatedButton(
                      onPressed: () {
                        /* Validate will return true if the form is valid, or false if
                           the form is invalid. */
                        if (_formKey.currentState!.validate()) {
                          var id = _userController.text;
                          var password = _passwordController.text;
                          _userPresenter.checkUserCredentials(id, password);
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.login),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 40),
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ElevatedButton(
                        onPressed: () {
                          /* Validate will return true if the form is valid, or false if
                           the form is invalid. */
                          if (_formKey.currentState!.validate()) {
                            // Process data.
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.digital_login),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 40),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ElevatedButton(
                        onPressed: () {
                          /* Validate will return true if the form is valid, or false if
                           the form is invalid. */
                          if (_formKey.currentState!.validate()) {
                            // Process data.
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.fingerprint_login),
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
  void onCheckUserCredentialsComplete(String userId, bool match) {
    if (match) {
      /* Credentials are correct, set user id on Provider for future uses */
      Provider.of<User>(context, listen: false).setUserId(userId);
      /* And navigate to main screen */
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainMenuView()),
      ).then((value) {
        /* Reset user and password fields in case user returns here clicking back button */
        _passwordController.clear();
        _userController.clear();
      });
    }else {
      /* Credentials don't match, show error message */
      _showErrorDialog();
    }
  }

  /* Error Dialog */
  Future<void> _showErrorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.warning),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(AppLocalizations.of(context)!.login_warning),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.ok),
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