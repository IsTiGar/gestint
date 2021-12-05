import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/available_workers_view_contract.dart';
import 'package:gestint/models/worker_full_model.dart';
import 'package:gestint/presenters/available_workers_presenter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'custom_progress_indicator.dart';

class AvailableWorkersWidget extends StatefulWidget {

  final List<String> bodyList;
  final List<String> priFunctionList;
  final List<String> secFunctionList;
  final List<String> fpFunctionList;
  final List<String> eoiFunctionList;

  AvailableWorkersWidget(
      {Key? key,
        required this.bodyList,
        required this.priFunctionList,
        required this.secFunctionList,
        required this.fpFunctionList,
        required this.eoiFunctionList}) : super(key: key);

  @override
  State<AvailableWorkersWidget> createState() => _AvailableWorkersWidgetState();
  }

  class _AvailableWorkersWidgetState extends State<AvailableWorkersWidget> implements AvailableWorkersViewContract {

  late AvailableWorkersPresenter _availableWorkersPresenter;

  late List<WorkerFull> _availableWorkersList;
  bool _isLoading = false;
  bool _availableWorkersNotFound = true;

  late String _bodyValue;
  late String _functionValue;

  @override
  void initState() {
    super.initState();
    _bodyValue = widget.bodyList.first;
    _functionValue = widget.priFunctionList.first;
    _availableWorkersPresenter = AvailableWorkersPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          DropdownButton(
            isExpanded: true,
            value: _bodyValue,
            hint: Text(AppLocalizations.of(context)!.choose_body),
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            underline: Container(
                height: 2,
                color: Theme.of(context).primaryColor
            ),
            onChanged: (String? newValue) {
              setState(() {
                _bodyValue = newValue!;
                _functionValue = getFunctionList(context).first;
              });
            },
            items: widget.bodyList
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          DropdownButton<String>(
            isExpanded: true,
            value: _functionValue,
            hint: Text(AppLocalizations.of(context)!.choose_function),
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            underline: Container(
                height: 2,
                color: Theme.of(context).primaryColor
            ),
            onChanged: (String? newValue) {
              setState(() {
                _functionValue = newValue!;
              });
            },
            items: getFunctionList(context)
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _availableWorkersPresenter.getAvailableWorkers(getCode(context, _bodyValue), getCode(context, _functionValue));
              setState(() {
                _isLoading = true;
              });
            },
            child: Text(AppLocalizations.of(context)!.show_button_text),
          ),
          SizedBox(height: 10),
          _isLoading ? Expanded(child: CustomProgressIndicatorWidget())
              : _availableWorkersNotFound ? SizedBox.shrink()
              : _availableWorkersList.length==0 ? Column(children: [SizedBox(height: 30,), Text(AppLocalizations.of(context)!.zero_results)])
              :ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: _availableWorkersList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      trailing: Text(_availableWorkersList[index].score.toStringAsFixed(3)),
                      title: Text(
                        '${index+1}. ${_availableWorkersList[index].lastName1} ${_availableWorkersList[index].lastName2}, ${_availableWorkersList[index].firstName}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle: Text(
                        _availableWorkersList[index].trained ? '${AppLocalizations.of(context)!.trained}: ${AppLocalizations.of(context)!.yes}' : '${AppLocalizations.of(context)!.trained}: ${AppLocalizations.of(context)!.no}',
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
        ]
      ),
    );
  }

  String getCode(BuildContext context, String string) {
    String code = string.substring(0, 3); // returns first 3 characters (the code)
    return code;
  }

  List<String> getFunctionList(BuildContext context) {
    List<String>? _functionList;
    String bodyCode = getCode(context, _bodyValue);

    switch (bodyCode) {
      case '058':
        // Primary school
        _functionList = widget.priFunctionList;
        break;
      case '059':
        // Secondary school
        _functionList = widget.secFunctionList;
        break;
      case '060':
        // Fp school
        _functionList = widget.fpFunctionList;
        break;
      case '061':
        // Eoi school
        _functionList = widget.eoiFunctionList;
        break;
      default: _functionList = widget.priFunctionList;
        break;
    }
    return _functionList;
  }

  @override
  void onLoadAvailableWorkersComplete(List<WorkerFull> availableWorkersList) {
    setState(() {
      _availableWorkersList = availableWorkersList;
      _availableWorkersNotFound = false;
      _isLoading = false;
    });
  }

  @override
  void onLoadAvailableWorkersError() {
    setState(() {
      _isLoading = false;
      _availableWorkersNotFound = true;
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
              Text(AppLocalizations.of(context)!.available_workers_warning),
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