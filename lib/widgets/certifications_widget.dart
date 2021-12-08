import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/certifications_view_contract.dart';
import 'package:gestint/models/certification_model.dart';
import 'package:gestint/models/user.dart';
import 'package:gestint/presenters/certifications_presenter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'custom_progress_indicator.dart';

/// This widget shows a list of user certifications
/// This info corresponds to the fifth Personal file tabs

class CertificationsWidget extends StatefulWidget {
  const CertificationsWidget({Key? key}) : super(key: key);

  @override
  State<CertificationsWidget> createState() => _CertificationsWidgetState();
}

class _CertificationsWidgetState extends State<CertificationsWidget> implements CertificationsViewContract {

  late CertificationsPresenter _certificationsPresenter;
  late List<Certification> _certificationList;
  bool _isLoading = true;
  bool _certificationsNotFound = false;

  @override
  void initState() {
    super.initState();
    _certificationsPresenter = CertificationsPresenter(this);
    _certificationsPresenter.getCertifications(Provider.of<User>(context, listen: false).getUserId());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: _isLoading ? CustomProgressIndicatorWidget() : _certificationsNotFound? SizedBox.shrink() : ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: _certificationList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              _certificationList[index].title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.qualification}: ${_certificationList[index].qualification}',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                _certificationList[index].award ? '${AppLocalizations.of(context)!.award}: ${AppLocalizations.of(context)!.yes}' : '${AppLocalizations.of(context)!.award}: ${AppLocalizations.of(context)!.no}',
                  style: TextStyle(
                      fontSize: 14
                  ),
                ),
              ],
            ),
            dense: false,
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(color: Theme.of(context).primaryColor),
      ),
    );
  }

  // update certification list
  @override
  void onLoadCertificationsComplete(List<Certification> certificationList) {
    setState(() {
      _certificationList = certificationList;
      _certificationsNotFound = false;
      _isLoading = false;
    });
  }

  // Something happened retrieving the list
  @override
  void onLoadCertificationsError() {
    setState(() {
      _isLoading = false;
      _certificationsNotFound = true;
      _showErrorDialog();
    });
  }

  // Show error dialog if app fail getting the user certifications list
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
              Text(AppLocalizations.of(context)!.certifications_warning),
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