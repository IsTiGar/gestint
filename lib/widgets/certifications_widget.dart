import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/certifications_view_contract.dart';
import 'package:gestint/models/certification_model.dart';
import 'package:gestint/models/user.dart';
import 'package:gestint/presenters/certifications_presenter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'custom_progress_indicator.dart';

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
            subtitle: Text(
              '${AppLocalizations.of(context)!.from}: ${_certificationList[index].qualification} ${AppLocalizations.of(context)!.to} ${_certificationList[index].award}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            ),
            dense: false,
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(color: Theme.of(context).primaryColor),
      ),
    );
  }

  @override
  void onLoadCertificationsComplete(List<Certification> certificationList) {
    setState(() {
      _certificationList = certificationList;
      _certificationsNotFound = false;
      _isLoading = false;
    });
  }

  @override
  void onLoadCertificationsError() {
    setState(() {
      _isLoading = false;
      _certificationsNotFound = true;
      _showErrorDialog();
    });
  }

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