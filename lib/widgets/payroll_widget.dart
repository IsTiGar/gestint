import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/payroll_view_contract.dart';
import 'package:gestint/models/payroll_model.dart';
import 'package:gestint/models/user.dart';
import 'package:gestint/presenters/payroll_presenter.dart';
import 'package:gestint/widgets/custom_progress_indicator.dart';
import 'package:gestint/widgets/underlinedTextWidget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// This widget shows a payroll info, can be downloaded in real life
/// The app shows a fake downloading message due to I have not access to real documents
/// It shows the last month payroll automatically but user can retrieve any payroll of the last 10 years

class PayrollWidget extends StatefulWidget {

  final List<String> monthList;

  PayrollWidget({Key? key, required this.monthList}) : super(key: key);

  @override
  State<PayrollWidget> createState() => _PayrollWidgetState();
}

class _PayrollWidgetState extends State<PayrollWidget> implements PayrollViewContract {

  late PayrollPresenter _payrollPresenter;

  late String _monthValue;
  late int _currentMonth;
  late String _yearValue;
  late int _currentYear;
  var payrollList = <Payroll>[];
  final yearList = <String>[];

  late Payroll _payroll;
  bool _isLoading = true;
  bool _payrollNotFound = false;

  double _cellPadding = 5;

  @override
  void initState() {
    super.initState();
    DateTime now = new DateTime.now();
    _currentMonth = now.month; // from 1 to 12
    // get the more recent payroll (past month) automatically
    _monthValue = widget.monthList[_currentMonth-2];
    _currentYear = now.year;
    // if december then set past year
    if(_currentMonth-1==0) _currentYear = _currentYear-1;
    // user can get payrolls from the past 10 years
    for (int j = 0; j < 10; j++) {
      yearList.add((_currentYear-j).toString());
    }
    _yearValue = _currentYear.toString();
    // Search this payroll automatically on the repository
    _payrollPresenter = PayrollPresenter(this);
    _payrollPresenter.getPayroll(Provider.of<User>(context, listen: false).getUserId(), _currentMonth-1, _currentYear);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('${AppLocalizations.of(context)!.payroll} ${AppLocalizations.of(context)!.of_word}'),
                  DropdownButton(
                    value: _monthValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                        height: 2,
                        color: Theme.of(context).primaryColor
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _isLoading = true;
                        _monthValue = newValue!;
                        _payrollPresenter.getPayroll(
                            Provider.of<User>(context, listen: false).getUserId(),
                            widget.monthList.indexOf(_monthValue)+1 , _currentYear);
                      });
                    },
                    items: widget.monthList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Text(AppLocalizations.of(context)!.of_word),
                  DropdownButton<String>(
                    value: _yearValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                        height: 2,
                        color: Theme.of(context).primaryColor
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _isLoading = true;
                        _yearValue = newValue!;
                        _payrollPresenter.getPayroll(
                            Provider.of<User>(context, listen: false).getUserId(),
                            _currentMonth,
                            int.parse(_yearValue)
                        );
                      });
                    },
                    items: yearList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              ),
              SizedBox(height: 10,),
              // Payroll info, this time the information is shown in a table with no borders
              _isLoading ? CustomProgressIndicatorWidget() : _payrollNotFound ? SizedBox.shrink() : Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    defaultColumnWidth: IntrinsicColumnWidth(),
                    children: [
                      TableRow(
                          children: [
                            UnderlinedTextWidget(text: AppLocalizations.of(context)!.concept, cellPadding: _cellPadding),
                            Container(
                              padding: EdgeInsets.all(_cellPadding),
                              child: UnderlinedTextWidget(
                                  text: AppLocalizations.of(context)!.accruals,
                                  cellPadding: _cellPadding
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(_cellPadding),
                              child: UnderlinedTextWidget(
                                  text: AppLocalizations.of(context)!.with_holdings,
                                  cellPadding: _cellPadding
                              ),
                            ),
                          ]
                      ),
                      TableRow(
                          children: [
                            Container(
                              padding: EdgeInsets.all(_cellPadding),
                              child: Text(
                                AppLocalizations.of(context)!.base_salary,
                                textAlign:TextAlign.start,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(_cellPadding),
                              child: Text(
                                _payroll.base.toString(),
                                textAlign:TextAlign.end,
                              ),
                            ),
                            Container(),
                          ]
                      ),
                      TableRow(
                          children: [
                            Container(
                              padding: EdgeInsets.all(_cellPadding),
                              child: Text(
                                AppLocalizations.of(context)!.destination_complement,
                                textAlign:TextAlign.start,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(_cellPadding),
                              child: Text(
                                _payroll.destinationComplement.toString(),
                                textAlign:TextAlign.end,
                              ),
                            ),
                            Container(),
                          ]
                      ),
                      TableRow(
                          children: [
                            Container(
                              padding: EdgeInsets.all(_cellPadding),
                              child: Text(
                                AppLocalizations.of(context)!.residence_complement,
                                textAlign:TextAlign.start,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(_cellPadding),
                              child: Text(
                                _payroll.residenceComplement.toString(),
                                textAlign:TextAlign.end,
                              ),
                            ),
                            Container(),
                          ]
                      ),
                      TableRow(
                          children: [
                            Container(
                              padding: EdgeInsets.all(_cellPadding),
                              child: Text(
                                AppLocalizations.of(context)!.general_complement,
                                textAlign:TextAlign.start,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(_cellPadding),
                              child: Text(
                                _payroll.generalComplement.toString(),
                                textAlign:TextAlign.end,
                              ),
                            ),
                            Container(),
                          ]
                      ),
                      TableRow(
                          children: [
                            Container(
                              padding: EdgeInsets.all(_cellPadding),
                              child: Text(
                                AppLocalizations.of(context)!.community_complement,
                                textAlign:TextAlign.start,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(_cellPadding),
                              child: Text(
                                _payroll.communityComplement.toString(),
                                textAlign:TextAlign.end,
                              ),
                            ),
                            Container(),
                          ]
                      ),
                      TableRow(
                          children: [
                            Container(
                              padding: EdgeInsets.all(_cellPadding),
                              child: Text(
                                'IRPF ${_payroll.irpf} %',
                                textAlign:TextAlign.start,
                              ),
                            ),
                            Container(),
                            Container(
                              padding: EdgeInsets.all(_cellPadding),
                              child: Text(
                                _payroll.calculateIrpf().toStringAsFixed(2),
                                textAlign:TextAlign.end,
                              ),
                            ),
                          ]
                      ),
                      TableRow(
                          children: [
                            Container(
                              padding: EdgeInsets.all(_cellPadding),
                              child: Text(
                                AppLocalizations.of(context)!.contribution,
                                textAlign:TextAlign.start,
                              ),
                            ),
                            Container(),
                            Container(
                              padding: EdgeInsets.all(_cellPadding),
                              child: Text(
                                _payroll.contribution.toString(),
                                textAlign:TextAlign.end,
                              ),
                            ),
                          ]
                      ),
                      TableRow(
                          children: [
                            Container(),
                            Container(
                              padding: EdgeInsets.all(_cellPadding),
                              child: UnderlinedTextWidget(
                                  text: AppLocalizations.of(context)!.total_accruals,
                                  cellPadding: _cellPadding
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(_cellPadding),
                              child: UnderlinedTextWidget(
                                  text: AppLocalizations.of(context)!.total_with_holdings,
                                  cellPadding: _cellPadding
                              ),
                            ),
                          ]
                      ),
                      TableRow(
                          children: [
                            Container(),
                            Container(
                              padding: EdgeInsets.all(_cellPadding),
                              child: Text(
                                _payroll.calculateAccrual().toString(),
                                textAlign:TextAlign.end,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(_cellPadding),
                              child: Text(
                                _payroll.calculateTaxes().toStringAsFixed(2),
                                textAlign:TextAlign.end,
                              ),
                            ),
                          ]
                      ),
                      TableRow(
                          children: [
                            UnderlinedTextWidget(
                                text: AppLocalizations.of(context)!.total_salary,
                                cellPadding: _cellPadding
                            ),
                            Container(),
                            Container()
                          ]
                      ),
                      TableRow(
                          children: [
                            Container(
                              padding: EdgeInsets.all(_cellPadding),
                              child: Text(
                                _payroll.calculateSalary().toStringAsFixed(2),
                                textAlign:TextAlign.end,
                              ),
                            ),
                            Container(),
                            Container()
                          ]
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          // show fab only if payroll is available to download
          _payrollNotFound ? SizedBox.shrink() : Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
              onPressed: (){
                // I have not access to the real documents, show a fake downloading document message to the user for now
                final scaffold = ScaffoldMessenger.of(context);
                scaffold.showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(context)!.downloading),
                      action: SnackBarAction(label: AppLocalizations.of(context)!.ok, onPressed: scaffold.hideCurrentSnackBar),
                    )
                );
              },
              child: const Icon(
                Icons.download,
                size: 24.0,
                color: Colors.white,
                ),
            ),
          )
        ],
      )
    );
  }

  // Update payroll info to show
  @override
  void onLoadPayrollComplete(Payroll payroll) {
    setState(() {
      _payroll = payroll;
      _payrollNotFound = false;
      _isLoading = false;
    });
  }

  // Show error dialog
  @override
  void onLoadPayrollError() {
    setState(() {
      _isLoading = false;
      _payrollNotFound = true;
      _showErrorDialog();
    });
  }

  // show dialog if app can't get the payroll
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
              Text(AppLocalizations.of(context)!.payroll_warning),
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