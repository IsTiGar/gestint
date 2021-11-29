import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/courses_finished_view_contract.dart';
import 'package:gestint/contracts/destinations_view_contract.dart';
import 'package:gestint/contracts/documents_view_contract.dart';
import 'package:gestint/models/course_finished_model.dart';
import 'package:gestint/models/destination_model.dart';
import 'package:gestint/models/document_model.dart';
import 'package:gestint/models/user.dart';
import 'package:gestint/presenters/courses_finished_presenter.dart';
import 'package:gestint/presenters/destinations_presenter.dart';
import 'package:gestint/presenters/documents_presenter.dart';
import 'package:gestint/widgets/course_finished_info_widget.dart';
import 'package:provider/provider.dart';

import 'custom_progress_indicator.dart';

class CoursesFinishedWidget extends StatefulWidget {

  final Function onHoursCallback;

  const CoursesFinishedWidget({Key? key, required this.onHoursCallback}) : super(key: key);

  @override
  State<CoursesFinishedWidget> createState() => _CoursesFinishedWidgetState();
}

class _CoursesFinishedWidgetState extends State<CoursesFinishedWidget> implements CoursesFinishedViewContract {

  late CoursesFinishedPresenter _coursesFinishedPresenter;
  late List<CourseFinished> _courseFinishedList;
  bool _isLoading = true;
  bool _coursesNotFound = false;

  @override
  void initState() {
    super.initState();
    _coursesFinishedPresenter = CoursesFinishedPresenter(this);
    _coursesFinishedPresenter.getCoursesFinished(Provider.of<User>(context, listen: false).getUserId());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: _isLoading ? CustomProgressIndicatorWidget() : _coursesNotFound? SizedBox.shrink() : ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: _courseFinishedList.length,
        itemBuilder: (BuildContext context, int index) {
          return CourseFinishedInfoWidget(courseFinished: _courseFinishedList[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  @override
  void onLoadCoursesFinishedComplete(List<CourseFinished> courseList) {
    double totalHours = 0;
    for(var course in courseList) {
      totalHours += course.hours;
    }
    setState(() {
      _courseFinishedList = courseList;
      _coursesNotFound = false;
      _isLoading = false;
      widget.onHoursCallback(totalHours);
    });
  }

  @override
  void onLoadCoursesFinishedError() {
    setState(() {
      _isLoading = false;
      _coursesNotFound = true;
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
              Text('Se ha producido un error al recuperar sus cursos'),
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