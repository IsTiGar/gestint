
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gestint/contracts/storage_view_contract.dart';
import 'package:gestint/contracts/user_view_contract.dart';
import 'package:gestint/models/storage_model.dart';
import 'package:gestint/models/user.dart';
import 'package:gestint/presenters/storage_presenter.dart';
import 'package:gestint/presenters/user_presenter.dart';
import 'package:gestint/widgets/custom_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'main_menu_view.dart';

/// This widget shows a login form, user has to log in in order to use the app

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> implements UserViewContract, StorageViewContract {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late UserPresenter _userPresenter;
  late StoragePresenter _storagePresenter;
  bool _checkboxValue = false;
  TextEditingController _userController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FocusNode _userFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _userPresenter = UserPresenter(this);
    // Check if user has saved credentials
    var _storageModel = new StorageModel();
    _storagePresenter = new StoragePresenter(this, _storageModel);
    _storagePresenter.getUserCredentials();
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
                  // User id block
                  Text(
                    AppLocalizations.of(context)!.user,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 18,
                    ),
                  ),
                  TextFormField(
                    key: new Key('userId'),
                    // this moves the cursor to the next field
                    textInputAction: TextInputAction.next,
                    controller: _userController,
                    focusNode: _userFocus,
                    onFieldSubmitted: (term){
                      _fieldFocusChange(context, _userFocus, _passwordFocus);
                    },
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
                  // Password block
                  Text(
                    AppLocalizations.of(context)!.password,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  TextFormField(
                    key: new Key('password'),
                    // this hides the keyboard
                    textInputAction: TextInputAction.done,
                    focusNode: _passwordFocus,
                    controller: _passwordController,
                    onFieldSubmitted: (value){
                      _passwordFocus.unfocus();
                      /* Validate will return true if the form is valid, or false if
                           the form is invalid. */
                      if (_formKey.currentState!.validate()) {
                        buildLoadingIndicator(context);
                        var id = _userController.text;
                        var password = _passwordController.text;
                        _userPresenter.checkUserCredentials(id, password);
                      }
                    },
                    obscureText: true,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!.enter_password;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  // Remember me block
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(AppLocalizations.of(context)!.remember_me),
                      Checkbox(
                        value: _checkboxValue,
                        onChanged: (bool? value) {
                          setState(() {
                            _checkboxValue = value!;
                          });
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ElevatedButton(
                      key: new Key('UserPasswordLoginButton'),
                      onPressed: () {
                        /* Validate will return true if the form is valid, or false if
                           the form is invalid. */
                        if (_formKey.currentState!.validate()) {
                          buildLoadingIndicator(context);
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
                        key: new Key('DigitalCertificateLoginButton'),
                        onPressed: () async{
                          /* Future feature, now as particular developer I have not access
                          to government's digital user system */
                          bool connect = await _showDigitalCertificateDialog();
                          if(connect) {
                            // I don't have access to this kind of government credentials
                            // Lets simulate a 3 seconds success connection
                            buildLoadingIndicator(context);
                            Timer.periodic(
                              const Duration(seconds: 2),
                              (Timer timer) {
                                timer.cancel();
                                /* Set user id on Provider for future uses, in real life
                                * the userId comes from the digital certificate */
                                Provider.of<User>(context, listen: false).setUserId('X46959966');
                                // remove loading indicator
                                Navigator.of(context).pop();
                                // And navigate to main screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MainMenuView()),
                                );
                              }
                            );
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
                        key: new Key('DigitalFingerprintLoginButton'),
                        onPressed: () {
                          // Future feature, show snackBar to the user, not available at current app version
                          final scaffold = ScaffoldMessenger.of(context);
                          scaffold.showSnackBar(
                              SnackBar(
                                key: new Key('FingerprintSnackBar'),
                                content: Text(AppLocalizations.of(context)!.not_available_option),
                                action: SnackBarAction(label: AppLocalizations.of(context)!.ok, onPressed: scaffold.hideCurrentSnackBar),
                              )
                          );
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

  // This function change focus between nodes
  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void onCheckUserCredentialError() {
    setState(() {
      // Hide loading indicator
      Navigator.of(context).pop();
      _showErrorDialog();
    });
  }

  @override
  void onCheckUserCredentialsComplete(String userId, String password, bool match) {
    if (match) {
      // Credentials are correct
      // Remove loading indicator
      Navigator.of(context).pop();
      /* check if user wishes to remember credentials and
        save or clear them in that case */
      if(_checkboxValue) {
        // User want his credentials to be remembered
        _storagePresenter.saveUserCredentials(userId, password);
      }else{
        // User don't want his credentials to be remembered
        _storagePresenter.clearUserCredentials();
      }
      /* Set user id on Provider for future uses */
      Provider.of<User>(context, listen: false).setUserId(userId);
      /* And navigate to main screen */
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainMenuView()),
      ).then((value) {
        /* Reset user and password fields in case user
          returns here clicking back button */
        _passwordController.clear();
        _userController.clear();
        _storagePresenter.getUserCredentials();
      });
    }else {
      // Credentials don't match, show error message and hide loading indicator
      _showErrorDialog();
    }
  }

  // Certificate Dialog (simulation)
  Future<bool> _showDigitalCertificateDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          key: new Key('digitalCertificateDialog'),
          title: Text(AppLocalizations.of(context)!.digital_certificate_title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(AppLocalizations.of(context)!.digital_certificate_message),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.connect),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    ).then((connect) => connect ?? false);
  }

  // Error Dialog
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

  @override
  void onGetCredentialsComplete(String? userId, String? password) {
    // if credentials are not saved then userId and password will be null
    if(userId != null && password != null) {
      // Credentials were saved so update text fields and checkbox
      setState(() {
        _checkboxValue = true;
        _userController.text = userId;
        _passwordController.text = password;
      });
    }
  }

  /* This shows a loading indicator with shadowed background while
  the credentials are checked on the remote database */
  buildLoadingIndicator(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CustomProgressIndicatorWidget(key: new Key('loadingIndicator'),),
        );
      });
  }

}