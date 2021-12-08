import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/personal_data_view_contract.dart';
import 'package:gestint/models/personal_data_model.dart';
import 'package:gestint/models/user.dart';
import 'package:gestint/presenters/personal_file_presenter.dart';
import 'package:gestint/widgets/custom_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// This widget shows some user personal info like name, email, birth, phone number, etc.
/// This info corresponds to the first Personal file tabs

class PersonalDataWidget extends StatefulWidget{

  PersonalDataWidget({Key? key}) : super(key: key);

  @override
  State<PersonalDataWidget> createState() => _PersonalDataWidgetState();

}

class _PersonalDataWidgetState extends State<PersonalDataWidget> implements PersonalDataViewContract {

  bool _isLoading = true;
  bool _personalDataNotFound = false;
  late PersonalData _personalData;
  late PersonalDataPresenter _personalDataPresenter;

  @override
  void initState() {
    super.initState();
    _personalDataPresenter = PersonalDataPresenter(this);
    _personalDataPresenter.getPersonalData(Provider.of<User>(context, listen: false).getUserId());
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
      child: _isLoading ? CustomProgressIndicatorWidget() : _personalDataNotFound ? SizedBox.shrink() : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.identification_data,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 2,
          ),
          Text('${AppLocalizations.of(context)!.name}: ${_personalData.firstName} ${_personalData.lastName1} ${_personalData.lastName2}'),
          Text('NIF: ${_personalData.nif}'),
          Text('${AppLocalizations.of(context)!.nationality}: ${_personalData.nationality}'),
          SizedBox(height: 20,),
          Text(
            AppLocalizations.of(context)!.birth_data,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 2,
          ),
          Text('${AppLocalizations.of(context)!.birth_date}: ${_personalData.dateOfBirth}'),
          Text('${AppLocalizations.of(context)!.gender}: ${_personalData.gender}'),
          Text('${AppLocalizations.of(context)!.province}: ${_personalData.birthProvince}'),
          Text('${AppLocalizations.of(context)!.city}: ${_personalData.birthCity}'),
          Text('${AppLocalizations.of(context)!.country}: ${_personalData.birthCountry}'),
          SizedBox(height: 20,),
          Text(
            AppLocalizations.of(context)!.contact_data,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 2,
          ),
          Text('${AppLocalizations.of(context)!.address}: ${_personalData.address}'),
          Text('${AppLocalizations.of(context)!.city}: ${_personalData.city}'),
          Text('${AppLocalizations.of(context)!.province}: ${_personalData.province}'),
          Text('${AppLocalizations.of(context)!.phone_number}: ${_personalData.phoneNumber}'),
          Text('${AppLocalizations.of(context)!.email}: ${_personalData.emailAddress}'),
        ],
      ),
    );
  }

  // update data list
  @override
  void onLoadPersonalDataComplete(PersonalData personalData) {
    setState(() {
      _personalData = personalData;
      _personalDataNotFound = false;
      _isLoading = false;
    });
  }

  // Something happened retrieving the list
  @override
  void onLoadPersonalDataError() {
    setState(() {
      _isLoading = false;
      _personalDataNotFound = true;
      _showErrorDialog();
    });
  }

  // Show error dialog if app fail getting the user documents
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
              Text(AppLocalizations.of(context)!.personal_data_warning),
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