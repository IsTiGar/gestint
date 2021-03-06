import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/current_job_view_contract.dart';
import 'package:gestint/helpers/helper.dart';
import 'package:gestint/models/current_job_model.dart';
import 'package:gestint/models/user.dart';
import 'package:gestint/presenters/current_job_presenter.dart';
import 'package:gestint/widgets/custom_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// This widget shows the user current job (where and job info)
/// This info corresponds to the second Personal file tabs

class CurrentJobWidget extends StatefulWidget{

  CurrentJobWidget({Key? key}) : super(key: key);

  @override
  State<CurrentJobWidget> createState() => _CurrentJobWidgetState();

}

class _CurrentJobWidgetState extends State<CurrentJobWidget> implements CurrentJobViewContract {

  bool _isLoading = true;
  late CurrentJob _currentJob;
  late CurrentJobPresenter _currentJobPresenter;
  bool _currentJobNotFound = false;
  late Helper _helper;

  @override
  void initState() {
    super.initState();
    _helper = new Helper(context);
    _currentJobPresenter = CurrentJobPresenter(this);
    _currentJobPresenter.getCurrentJob(Provider.of<User>(context, listen: false).getUserId());
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
      child: _isLoading ? CustomProgressIndicatorWidget() : _currentJobNotFound ? SizedBox.shrink() : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.school_data,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 2,
          ),
          Text('${AppLocalizations.of(context)!.school_service} ${_currentJob.school}'),
          Text('${AppLocalizations.of(context)!.school_city} ${_currentJob.city}'),
          SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.job_data,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 2,
          ),
          Text('${AppLocalizations.of(context)!.type} ${_helper.getTypeString(_currentJob.type)}'),
          _currentJob.partTime ? Text(AppLocalizations.of(context)!.part_time_yes) : Text(AppLocalizations.of(context)!.part_time_no),
          Text('${AppLocalizations.of(context)!.body} ${_helper.getBodyString(_currentJob.body)}'),
          Text('${AppLocalizations.of(context)!.function} ${_helper.getFunctionString(_currentJob.function)}'),
        ],
      ),
    );
  }

  // update job info
  @override
  void onLoadCurrentJobComplete(CurrentJob currentJob) {
    setState(() {
      _currentJob = currentJob;
      _currentJobNotFound = false;
      _isLoading = false;
    });
  }

  // Something happened retrieving the info
  @override
  void onLoadCurrentJobError() {
    setState(() {
      _isLoading = false;
      _currentJobNotFound = true;
      _showErrorDialog();
    });
  }

  // Show error dialog if app fail getting the user current situation
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
              Text(AppLocalizations.of(context)!.current_job_warning),
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