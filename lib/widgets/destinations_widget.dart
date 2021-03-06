import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/destinations_view_contract.dart';
import 'package:gestint/models/destination_model.dart';
import 'package:gestint/models/user.dart';
import 'package:gestint/presenters/destinations_presenter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'custom_progress_indicator.dart';

/// This widget shows a list of user past and present destinations (where, when and total time in destination)
/// This info corresponds to the third Personal file tabs

class DestinationsWidget extends StatefulWidget {
  const DestinationsWidget({Key? key}) : super(key: key);

  @override
  State<DestinationsWidget> createState() => _DestinationsWidgetState();
}

class _DestinationsWidgetState extends State<DestinationsWidget> implements DestinationsViewContract {

  late DestinationsPresenter _destinationsPresenter;
  late List<Destination> _destinationsList;
  bool _isLoading = true;
  bool _destinationsNotFound = false;

  @override
  void initState() {
    super.initState();
    _destinationsPresenter = DestinationsPresenter(this);
    _destinationsPresenter.getDestinations(Provider.of<User>(context, listen: false).getUserId());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: _isLoading ? CustomProgressIndicatorWidget() : _destinationsNotFound? SizedBox.shrink() : ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: _destinationsList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              _destinationsList[index].school,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.from}: ${_destinationsList[index].startDate} ${AppLocalizations.of(context)!.to} ${_destinationsList[index].endDate}',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  buildTimeString(_destinationsList[index].calculateTime()),
                  style: TextStyle(
                      fontSize: 14,
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

  // update destinations list
  @override
  void onLoadDestinationsComplete(List<Destination> destinationsList) {
    setState(() {
      _destinationsList = destinationsList;
      _destinationsNotFound = false;
      _isLoading = false;
    });
  }

  // Something happened retrieving the list
  @override
  void onLoadDestinationsError() {
    setState(() {
      _isLoading = false;
      _destinationsNotFound = true;
      _showErrorDialog();
    });
  }

  // Show error dialog if app fail getting the user destinations
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
              Text(AppLocalizations.of(context)!.destinations_warning),
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