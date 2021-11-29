import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/scale_view_contract.dart';
import 'package:gestint/models/scale_model.dart';
import 'package:gestint/models/user.dart';
import 'package:gestint/presenters/scale_presenter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    _scalePresenter.getScale(Provider.of<User>(context, listen: false).getUserId());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: _isLoading ? CustomProgressIndicatorWidget() : _scaleNotFound? SizedBox.shrink() : Column(
        children: [
          UnderlinedTextWidget(text: '1. ${AppLocalizations.of(context)!.teaching_exp}', cellPadding: 5),
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
                      '1.1 ${AppLocalizations.of(context)!.public_schools}',
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
                      '1.2 ${AppLocalizations.of(context)!.private_schools}',
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
                      '1.3 ${AppLocalizations.of(context)!.universities}',
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
          UnderlinedTextWidget(text: '2. ${AppLocalizations.of(context)!.academic_training}', cellPadding: 5),
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
                        '2.1 ${AppLocalizations.of(context)!.file_qualification}',
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
                        '2.2 ${AppLocalizations.of(context)!.phd_extra}',
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
                        '2.3 ${AppLocalizations.of(context)!.other_degrees}',
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
                        '2.4 ${AppLocalizations.of(context)!.special_degrees}',
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
                        '2.5 ${AppLocalizations.of(context)!.catalan_degrees}',
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
          UnderlinedTextWidget(text: '3. ${AppLocalizations.of(context)!.training}', cellPadding: 5),
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
                        '${AppLocalizations.of(context)!.total_hours}: ${_scale.coursesHours}',
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
            '${AppLocalizations.of(context)!.total_score}: ${_scale.calculateTotalScale()}',
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
          title: Text(AppLocalizations.of(context)!.warning),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(AppLocalizations.of(context)!.scale_warning),
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