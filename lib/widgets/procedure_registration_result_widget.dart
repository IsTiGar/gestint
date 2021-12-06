import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProcedureRegistrationResultWidget extends StatelessWidget {

  final bool success;

  const ProcedureRegistrationResultWidget({Key? key, required this.success}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String resultMessage = success ? AppLocalizations.of(context)!.procedure_success_message
        : AppLocalizations.of(context)!.procedure_failure_message;
    String goToMainMessage = success ? AppLocalizations.of(context)!.go_to_main_ok
        : AppLocalizations.of(context)!.go_to_main_not_ok;
    String appBarTitle = success ? AppLocalizations.of(context)!.success_appbar_title
        : AppLocalizations.of(context)!.failure_appbar_title;
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false, // remove back arrow button,
              title: Text(appBarTitle)
          ),
          body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                success ? Icon(
                  Icons.check_circle,
                  color: Color.fromARGB(255, 50, 129, 75),
                  size: 150.0,
                ) : Icon(
                  Icons.error,
                  color: Theme.of(context).primaryColor,
                  size: 50.0,
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Text(
                    resultMessage,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: Text(
                    goToMainMessage,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Return to main menu
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          // avoid user to go back to previous screen
          return false;
        }
    );
  }
}