
import 'package:flutter/material.dart';
import 'package:gestint/contracts/worker_view_contract.dart';
import 'package:gestint/models/user.dart';
import 'package:gestint/models/worker_model.dart';
import 'package:gestint/presenters/worker_presenter.dart';
import 'package:gestint/widgets/courses_finished_widget.dart';
import 'package:gestint/widgets/custom_progress_indicator.dart';
import 'package:gestint/widgets/payroll_widget.dart';
import 'package:gestint/widgets/personal_file_widget.dart';
import 'package:gestint/widgets/available_workers_widget.dart';
import 'package:gestint/widgets/contact_widget.dart';
import 'package:gestint/widgets/documents_widget.dart';
import 'package:gestint/widgets/maps_widget.dart';
import 'package:gestint/widgets/procedures_widget.dart';
import 'package:gestint/widgets/scale_widget.dart';
import 'package:gestint/widgets/profile_widget.dart';
import 'package:gestint/widgets/welcome_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainMenuView extends StatefulWidget{

  MainMenuView({Key? key}) : super(key: key);

  @override
  State<MainMenuView> createState() => _MainMenuState();

}

class _MainMenuState extends State<MainMenuView> implements WorkerViewContract {

  late WorkerPresenter _workerPresenter;
  late Worker _worker;
  bool _isLoading = true;
  bool _showBottomBar = false;
  Widget bodyWidget = WelcomeWidget();
  String appBarTitle = 'Portal del personal';
  String bottomBarCourseHours = '';

  // callback function
  void _onHoursCallback(double hours) {
    setState(() {
      bottomBarCourseHours = hours.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _workerPresenter = WorkerPresenter(this);
    _workerPresenter.getWorkerProfile(Provider.of<User>(context, listen: false).getUserId());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: Center(
          child: bodyWidget,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 204, 7, 60),
              ),
              child: _isLoading ? CustomProgressIndicatorWidget() : ProfileWidget(worker: _worker),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.personal_file),
              leading: Icon(
                Icons.folder,
                color: Color.fromARGB(255, 204, 7, 60),
                size: 30.0,
              ),
              onTap: () {
                // replace body widget
                setState(() {
                  appBarTitle = AppLocalizations.of(context)!.personal_file;
                  _showBottomBar = false;
                  bodyWidget = PersonalFileWidget();
                });
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.documents),
              leading: Icon(
                Icons.description,
                color: Color.fromARGB(255, 204, 7, 60),
                size: 30.0,
              ),
              onTap: () {
                // replace body widget
                setState(() {
                  appBarTitle = AppLocalizations.of(context)!.documents;
                  _showBottomBar = false;
                  bodyWidget = DocumentsWidget();
                });
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.economical_data),
              leading: Icon(
                Icons.euro,
                color: Color.fromARGB(255, 204, 7, 60),
                size: 30.0,
              ),
              onTap: () {
                // replace body widget
                setState(() {
                  appBarTitle = AppLocalizations.of(context)!.economical_data;
                  _showBottomBar = false;
                  bodyWidget = PayrollWidget();
                });
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.education),
              leading: Icon(
                Icons.school,
                color: Color.fromARGB(255, 204, 7, 60),
                size: 30.0,
              ),
              onTap: () {
                // replace body widget
                setState(() {
                  appBarTitle = AppLocalizations.of(context)!.education;
                  _showBottomBar = true;
                  bodyWidget = CoursesFinishedWidget(onHoursCallback: _onHoursCallback);
                });
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.scale),
              leading: Icon(
                Icons.swap_vert,
                color: Color.fromARGB(255, 204, 7, 60),
                size: 30.0,
              ),
              onTap: () {
                // replace body widget
                setState(() {
                  appBarTitle = AppLocalizations.of(context)!.scale;
                  _showBottomBar = false;
                  bodyWidget = ScaleWidget();
                });
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.available_workers),
              leading: Icon(
                Icons.people,
                color: Color.fromARGB(255, 204, 7, 60),
                size: 30.0,
              ),
              onTap: () {
                // replace body widget
                setState(() {
                  appBarTitle = AppLocalizations.of(context)!.available_workers;
                  _showBottomBar = false;
                  bodyWidget = AvailableWorkersWidget();
                });
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.procedures),
              leading: Icon(
                Icons.schedule,
                color: Color.fromARGB(255, 204, 7, 60),
                size: 30.0,
              ),
              onTap: () {
                // replace body widget
                setState(() {
                  appBarTitle = AppLocalizations.of(context)!.procedures;
                  _showBottomBar = false;
                  bodyWidget = ProceduresWidget();
                });
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.school_map),
              leading: Icon(
                Icons.place,
                color: Color.fromARGB(255, 204, 7, 60),
                size: 30.0,
              ),
              onTap: () {
                // replace body widget
                setState(() {
                  appBarTitle = AppLocalizations.of(context)!.school_map;
                  _showBottomBar = false;
                  bodyWidget = MapsWidget();
                });
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.contact),
              leading: Icon(
                Icons.contact_support,
                color: Color.fromARGB(255, 204, 7, 60),
                size: 30.0,
              ),
              onTap: () {
                // replace body widget
                setState(() {
                  appBarTitle = AppLocalizations.of(context)!.contact;
                  _showBottomBar = false;
                  bodyWidget = ContactWidget();
                });
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.logout),
              leading: Icon(
                Icons.logout,
                color: Color.fromARGB(255, 204, 7, 60),
                size: 30.0,
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Visibility(
        visible: _showBottomBar,
        child: BottomAppBar(
          color: Theme.of(context).primaryColor,
          child: new Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${AppLocalizations.of(context)!.total_hours}: ${bottomBarCourseHours.toString()}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                Text(AppLocalizations.of(context)!.course_request, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
              ],
            )
          )
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Visibility(
        visible: _showBottomBar,
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          elevation: 4.0,
          child: const Icon(
            Icons.add,
            size: 24.0,
            color: Colors.white,
          ),
          onPressed: () {
            //TODO ir a la pantalla de cursos
          },
        ),
      )
    );
  }

  @override
  void onLoadWorkerComplete(Worker worker) {
    setState(() {
      _worker = worker;
      _isLoading = false;
    });
  }

  @override
  void onLoadWorkerError() {
    // TODO: implement onLoadWorkerError, show message or something
  }

}