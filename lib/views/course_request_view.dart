
import 'package:flutter/material.dart';
import 'package:gestint/contracts/courses_view_contract.dart';
import 'package:gestint/contracts/single_procedure_view_contract.dart';
import 'package:gestint/helpers/helper.dart';
import 'package:gestint/models/course_model.dart';
import 'package:gestint/models/current_job_model.dart';
import 'package:gestint/models/user.dart';
import 'package:gestint/presenters/courses_presenter.dart';
import 'package:gestint/presenters/single_procedure_presenter.dart';
import 'package:gestint/widgets/available_job_info_widget.dart';
import 'package:gestint/widgets/course_info_widget.dart';
import 'package:gestint/widgets/custom_progress_indicator.dart';
import 'package:gestint/widgets/procedure_registration_result_widget.dart';
import 'package:gestint/widgets/underlinedTextWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CourseRequestView extends StatefulWidget{

  final Map<String, String> cepList;

  CourseRequestView({Key? key, required this.cepList}) : super(key: key);

  @override
  State<CourseRequestView> createState() => _CourseRequestViewState();

}

class _CourseRequestViewState extends State<CourseRequestView> implements CoursesViewContract {

  late CoursesPresenter _coursesPresenter;
  late List<Course> _courseList;
  bool _coursesNotFound = true;
  bool _isLoading = false;
  late Helper _helper;
  late String _cepValue;

  @override
  void initState() {
    super.initState();
    _helper = new Helper(context);
    _cepValue = widget.cepList.keys.first;
    _coursesPresenter = CoursesPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.courses)),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            DropdownButton(
              isExpanded: true,
              value: _cepValue,
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
                  _cepValue = newValue!;
                });
              },
              items: widget.cepList.keys
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
                _coursesPresenter.getCourses(_helper.getCepCode(_cepValue));
                setState(() {
                  _isLoading = true;
                });
              },
              child: Text(AppLocalizations.of(context)!.show_button_text),
            ),
            SizedBox(height: 10),
            _isLoading ? Expanded(child: CustomProgressIndicatorWidget())
                : _coursesNotFound ? SizedBox.shrink()
                : _courseList.length==0 ? Column(children: [SizedBox(height: 30,), Text(AppLocalizations.of(context)!.zero_results)])
                :ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: _courseList.length,
              itemBuilder: (BuildContext context, int index) {
                return CourseInfoWidget(course: _courseList[index],);
              },
              separatorBuilder: (BuildContext context, int index) => Divider(color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    );
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
              Text(AppLocalizations.of(context)!.job_warning),
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

  /* This shows a loading indicator with shadowed background while
  the credentials are checked on the remote database */
  buildLoadingIndicator(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CustomProgressIndicatorWidget(),
          );
        });
  }

  @override
  void onLoadCoursesComplete(List<Course> courseList) {
    setState(() {
      _courseList = courseList;
      _coursesNotFound = false;
      _isLoading = false;
    });
  }

  @override
  void onLoadCoursesError() {
    setState(() {
      _isLoading = false;
      _coursesNotFound = true;
      _showErrorDialog();
    });
  }

}