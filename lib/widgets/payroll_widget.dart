import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/payroll_view_contract.dart';
import 'package:gestint/models/payroll_model.dart';
import 'package:gestint/presenters/payroll_presenter.dart';
import 'package:gestint/widgets/custom_progress_indicator.dart';
import 'package:gestint/widgets/underlinedTextWidget.dart';

class PayrollWidget extends StatefulWidget {
  const PayrollWidget({Key? key}) : super(key: key);

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
  final monthList = <String>['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];
  final yearList = <String>[];

  late Payroll _payroll;
  bool _isLoading = true;
  bool _payrollNotFound = false;

  double _cellPadding = 5;

  @override
  void initState() {
    super.initState();
    DateTime now = new DateTime.now();
    _currentMonth = now.month; //from 1 to 12
    _monthValue = monthConversionToString(_currentMonth-1);
    _currentYear = now.year;
    // if december then set past year
    if(_currentMonth-1==0) _currentYear = _currentYear-1;
    for (int j = 0; j < 10; j++) {
      yearList.add((_currentYear-j).toString());
    }
    _yearValue = _currentYear.toString();

    _payrollPresenter = PayrollPresenter(this);
    _payrollPresenter.getPayroll('X46959966', _currentMonth-1, _currentYear);
  }

  String monthConversionToString (int currentMonth) {
    String currentMonthString = 'Enero';
    switch(currentMonth) {
      case 0: currentMonthString = 'Diciembre';
      break;
      case 1: currentMonthString = 'Enero';
      break;
      case 2: currentMonthString = 'Febrero';
      break;
      case 3: currentMonthString = 'Marzo';
      break;
      case 4: currentMonthString = 'Abril';
      break;
      case 5: currentMonthString = 'Mayo';
      break;
      case 6: currentMonthString = 'Junio';
      break;
      case 7: currentMonthString = 'Julio';
      break;
      case 8: currentMonthString = 'Agosto';
      break;
      case 9: currentMonthString = 'Septiembre';
      break;
      case 10: currentMonthString = 'Octubre';
      break;
      case 11: currentMonthString = 'Noviembre';
      break;
      /*case 12: currentMonthString = 'Diciembre';
      break;*/
    }
    return currentMonthString;
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Nómina de'),
              DropdownButton(
                value: _monthValue,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                //style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                    height: 2,
                    color: Color.fromARGB(255, 204, 7, 60)
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _isLoading = true;
                    _monthValue = newValue!;
                    _payrollPresenter.getPayroll('X46959966', monthList.indexOf(_monthValue)+1 , _currentYear);
                  });
                },
                items: monthList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Text('de'),
              DropdownButton<String>(
                value: _yearValue,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                //style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                    height: 2,
                    color: Color.fromARGB(255, 204, 7, 60)
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _isLoading = true;
                    _yearValue = newValue!;
                    _payrollPresenter.getPayroll('X46959966', _currentMonth, int.parse(_yearValue));
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
          // Payroll info
          _isLoading ? CustomProgressIndicatorWidget() : _payrollNotFound? SizedBox.shrink() : Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            defaultColumnWidth: IntrinsicColumnWidth(),
            //border: TableBorder.all(),
            children: [
              TableRow(
                children: [
                  UnderlinedTextWidget(text: 'Concepto', cellPadding: _cellPadding),
                  Container(
                    padding: EdgeInsets.all(_cellPadding),
                    child: UnderlinedTextWidget(
                        text: 'Devengos',
                        cellPadding: _cellPadding
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(_cellPadding),
                    child: UnderlinedTextWidget(
                        text: 'Retenciones',
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
                        'Sueldo base',
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
                        'Complemento de destinación',
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
                        'Indemnización residencia',
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
                        'Complemento general',
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
                        'Complemento comunidad autónoma',
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
                        'Contribución CC',
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
                          text: 'Total devengos',
                          cellPadding: _cellPadding
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(_cellPadding),
                      child: UnderlinedTextWidget(
                          text: 'Total retenciones',
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
                        text: 'Líquido',
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
          )
        ],
      ),
    );
  }

  @override
  void onLoadPayrollComplete(Payroll payroll) {
    setState(() {
      _payroll = payroll;
      _payrollNotFound = false;
      _isLoading = false;
    });
  }

  @override
  void onLoadPayrollError() {
    setState(() {
      _isLoading = false;
      _payrollNotFound = true;
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
              Text('Se ha producido un error al recuperar esta nómina o esta nómina no existe'),
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