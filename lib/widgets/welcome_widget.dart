import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// This widget shows a welcome message, this is the first screen user can see when is logged

class WelcomeWidget extends StatelessWidget {

  WelcomeWidget ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Expanded(
        child: Text(
          AppLocalizations.of(context)!.welcome_message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}