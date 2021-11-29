import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/charges_view_contract.dart';
import 'package:gestint/contracts/current_job_view_contract.dart';
import 'package:gestint/contracts/personal_data_contract.dart';
import 'package:gestint/contracts/personal_data_view_contract.dart';
import 'package:gestint/models/charge_model.dart';
import 'package:gestint/models/current_job_model.dart';
import 'package:gestint/models/personal_data_model.dart';
import 'package:gestint/models/user.dart';
import 'package:gestint/presenters/charges_presenter.dart';
import 'package:gestint/presenters/current_job_presenter.dart';
import 'package:gestint/presenters/personal_file_presenter.dart';
import 'package:gestint/widgets/custom_progress_indicator.dart';
import 'package:provider/provider.dart';

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
            isThreeLine: true,
            trailing: IconButton(
              icon: Icon(
                Icons.download,
                color: Color.fromARGB(255, 204, 7, 60),
                size: 30.0,
              ),
              onPressed: () {
                //TODO download something
              },
            ),
            title: Text(
              _documentsList[index].title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
              //textAlign:TextAlign.end,
            ),
            subtitle: Text(
              'Fecha de efecto: ${_documentsList[index].date}',
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
          title: const Text('Atención'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text('Se ha producido un error al recuperar su lista de cargos, disculpe las molestias y vuelva a intentarlo más tarde'),
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