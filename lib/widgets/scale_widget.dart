import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/scale_view_contract.dart';
import 'package:gestint/models/scale_model.dart';
import 'package:gestint/presenters/scale_presenter.dart';

import 'custom_progress_indicator.dart';
import 'underlinedTextWidget.dart';

class ScaleWidget extends StatefulWidget {
  const ScaleWidget({Key? key}) : super(key: key);

  @override
  State<ScaleWidget> createState() => _ScaleWidgetState();
}

class _ScaleWidgetState extends State<ScaleWidget> implements ScaleViewContract {

  late ScalePresenter _scalePresenter;

  late Scale _scale;
  bool _isLoading = true;
  bool _scaleNotFound = false;
  double _cellPadding = 5;

  @override
  void initState() {
    super.initState();

    _scalePresenter = ScalePresenter(this);
    _scalePresenter.getScale('X46959966');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: _isLoading ? CustomProgressIndicatorWidget() : _scaleNotFound? SizedBox.shrink() : Column(
        children: [
          UnderlinedTextWidget(text: '1. Experiencia docente', cellPadding: 5),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: {
              0: FlexColumnWidth(1.0),
              1: IntrinsicColumnWidth(), // i want this one to take the rest available space
            },
            //border: TableBorder.all(),
            children: [
              TableRow(
                children: [
                  Container(
                    padding: EdgeInsets.all(_cellPadding),
                    child: Text(
                      '1.1 Centros públicos',
                      textAlign:TextAlign.start,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(_cellPadding),
                    child: Text(
                      _scale.publicExp.toString(),
                      textAlign:TextAlign.end,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Container(
                    padding: EdgeInsets.all(_cellPadding),
                    child: Text(
                      '1.2 Centros privados',
                      textAlign:TextAlign.start,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(_cellPadding),
                    child: Text(
                      _scale.privateExp.toString(),
                      textAlign:TextAlign.end,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Container(
                    padding: EdgeInsets.all(_cellPadding),
                    child: Text(
                      '1.3 Universidades',
                      textAlign:TextAlign.start,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(_cellPadding),
                    child: Text(
                      _scale.universityExp.toString(),
                      textAlign:TextAlign.end,
                    ),
                  ),
                ],
              )
            ]
          ),
          SizedBox(height: 10,),
          UnderlinedTextWidget(text: '2. Formación académica', cellPadding: 5),
          Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FlexColumnWidth(1.0),
                1: IntrinsicColumnWidth(), // i want this one to take the rest available space
              },
              //border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    Container(
                      padding: EdgeInsets.all(_cellPadding),
                      child: Text(
                        '2.1 Nota del expediente académico',
                        textAlign:TextAlign.start,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(_cellPadding),
                      child: Text(
                        _scale.academicQual.toString(),
                        textAlign:TextAlign.end,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      padding: EdgeInsets.all(_cellPadding),
                      child: Text(
                        '2.2 Doctorado y premios extraordinarios',
                        textAlign:TextAlign.start,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(_cellPadding),
                      child: Text(
                        _scale.phd.toString(),
                        textAlign:TextAlign.end,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      padding: EdgeInsets.all(_cellPadding),
                      child: Text(
                        '2.3 Otras titulaciones universitarias',
                        textAlign:TextAlign.start,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(_cellPadding),
                      child: Text(
                        _scale.other.toString(),
                        textAlign:TextAlign.end,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      padding: EdgeInsets.all(_cellPadding),
                      child: Text(
                        '2.4 Titulaciones de régimen especial',
                        textAlign:TextAlign.start,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(_cellPadding),
                      child: Text(
                        _scale.special.toString(),
                        textAlign:TextAlign.end,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Container(
                      padding: EdgeInsets.all(_cellPadding),
                      child: Text(
                        '2.5 Titulaciones de catalán',
                        textAlign:TextAlign.start,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(_cellPadding),
                      child: Text(
                        _scale.catalan.toString(),
                        textAlign:TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ]
          ),
          SizedBox(height: 10,),
          UnderlinedTextWidget(text: '3. Formación permanente', cellPadding: 5),
          Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FlexColumnWidth(1.0),
                1: IntrinsicColumnWidth(), // i want this one to take the rest available space
              },
              //border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    Container(
                      padding: EdgeInsets.all(_cellPadding),
                      child: Text(
                        'Total de horas: ${_scale.coursesHours}',
                        textAlign:TextAlign.start,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(_cellPadding),
                      child: Text(
                        _scale.courses.toString(),
                        textAlign:TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ]
          ),
          SizedBox(height: 25,),
          Text(
            'Puntuación total: ${_scale.calculateTotalScale()}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ]
      ),
    );
  }

  @override
  void onLoadScaleComplete(Scale scale) {
    setState(() {
      _scale = scale;
      _scaleNotFound = false;
      _isLoading = false;
    });
  }

  @override
  void onLoadScaleError() {
    setState(() {
      _isLoading = false;
      _scaleNotFound = true;
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
              Text('Se ha producido un error al recuperar esta baremación'),
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