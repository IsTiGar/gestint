import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/charges_view_contract.dart';
import 'package:gestint/models/charge_model.dart';
import 'package:gestint/models/user.dart';
import 'package:gestint/presenters/charges_presenter.dart';
import 'package:gestint/widgets/custom_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ChargesWidget extends StatefulWidget{

  ChargesWidget({Key? key}) : super(key: key);

  @override
  State<ChargesWidget> createState() => _ChargesWidgetState();

}

class _ChargesWidgetState extends State<ChargesWidget> implements ChargesViewContract {

  bool _isLoading = true;
  late List<Charge> _chargesList;
  late ChargesPresenter _chargesPresenter;
  bool _chargesNotFound = false;

  @override
  void initState() {
    super.initState();
    _chargesPresenter = ChargesPresenter(this);
    _chargesPresenter.getCharges(Provider.of<User>(context, listen: false).getUserId());
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
      child: _isLoading ? CustomProgressIndicatorWidget() : _chargesNotFound ? SizedBox.shrink() : ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: _chargesList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              _chargesList[index].type,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
              //textAlign:TextAlign.end,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.school}: ${_chargesList[index].school}',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  '${AppLocalizations.of(context)!.start_data}: ${_chargesList[index].startDate}',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  '${AppLocalizations.of(context)!.end_data}: ${_chargesList[index].endDate}',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  buildTimeString(_chargesList[index].calculateTime()),
                  style: TextStyle(
                      fontSize: 14,
                  ),
                ),
              ]
            ),
            dense: false,
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(color: Theme.of(context).primaryColor),
      ),
    );
  }

  @override
  void onLoadChargesComplete(List<Charge> chargeList) {
    setState(() {
      _chargesList = chargeList;
      _isLoading = false;
    });
  }

  @override
  void onLoadChargesError() {
    setState(() {
      _isLoading = false;
      _chargesNotFound = true;
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
              Text(AppLocalizations.of(context)!.charges_warning),
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

  String buildTimeString(List timeList) {
    return '${timeList[0]} ${AppLocalizations.of(context)!.years}, ${timeList[1]} ${AppLocalizations.of(context)!.months} ${AppLocalizations.of(context)!.and} ${timeList[2]} ${AppLocalizations.of(context)!.days}';
  }

}