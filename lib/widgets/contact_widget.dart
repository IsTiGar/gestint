import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppLocalizations.of(context)!.contact_main_message,
            textAlign: TextAlign.center,
            style:TextStyle(fontSize: 16)),
          SizedBox(height: 20),
          Text(AppLocalizations.of(context)!.economical_data, style: TextStyle(fontWeight: FontWeight.bold)),
          const Text('nomines@dgpdocen.caib.es'),
          SizedBox(height: 20),
          Text(AppLocalizations.of(context)!.pri_workers, style: TextStyle(fontWeight: FontWeight.bold)),
          const Text('primaria@dgpdocen.caib.es'),
          SizedBox(height: 20),
          Text(AppLocalizations.of(context)!.sec_workers, style: TextStyle(fontWeight: FontWeight.bold)),
          const Text('secundaria@dgpdocen.caib.es'),
          SizedBox(height: 20),
          Text(AppLocalizations.of(context)!.education_recognition, style: TextStyle(fontWeight: FontWeight.bold)),
          const Text('sfhc@dgpice.caib.es'),
        ],
      ),
    );
  }
}