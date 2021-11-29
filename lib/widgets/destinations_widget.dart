import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/destinations_view_contract.dart';
import 'package:gestint/contracts/documents_view_contract.dart';
import 'package:gestint/models/destination_model.dart';
import 'package:gestint/models/document_model.dart';
import 'package:gestint/models/user.dart';
import 'package:gestint/presenters/destinations_presenter.dart';
import 'package:gestint/presenters/documents_presenter.dart';
import 'package:provider/provider.dart';

import 'custom_progress_indicator.dart';

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
              //textAlign:TextAlign.end,
            ),
            subtitle: Text(
              'Desde: ${_destinationsList[index].startDate} hasta ${_destinationsList[index].endDate}',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
              //textAlign:TextAlign.end,
            ),
            dense: false,
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  @override
  void onLoadDestinationsComplete(List<Destination> destinationsList) {
    setState(() {
      _destinationsList = destinationsList;
      _destinationsNotFound = false;
      _isLoading = false;
    });
  }

  @override
  void onLoadDestinationsError() {
    setState(() {
      _isLoading = false;
      _destinationsNotFound = true;
      _showErrorDialog();
    });
  }

  Future<void> _showErrorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atención'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text('Se ha producido un error al recuperar su hoja de servicios'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Entendido'),
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