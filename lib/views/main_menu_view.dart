
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
  bool _workerNotFound = false;
  bool _showBottomBar = false;
  // First widget to show is WelcomeWidget
  Widget bodyWidget = WelcomeWidget();
  String appBarTitle = 'Portal del personal'; // this is the same in catalan or spanish
  String bottomBarCourseHours = ''; // defined later

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
    // Get user profile information to show on drawer
    _workerPresenter.getWorkerProfile(Provider.of<User>(context, listen: false).getUserId());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: Center(
          child: bodyWidget,
      ),
      // All the drawer options can be shown in one body widget that is updated as needed
      drawer: Drawer(
        /* Add a ListView to the drawer. This ensures the user can scroll
        through the options in the drawer if there isn't enough vertical
        space to fit everything. */
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: _isLoading ? CustomProgressIndicatorWidget() : _workerNotFound? Container(child: Text(AppLocalizations.of(context)!.profile_warning), alignment: Alignment.center,) : ProfileWidget(worker: _worker),
            ),
            // Navigation block tiles
            ListTile(
              title: Text(AppLocalizations.of(context)!.personal_file),
              leading: Icon(
                Icons.folder,
                color: Theme.of(context).primaryColor,
                size: 30.0,
              ),
              onTap: () {
                // Replace body widget
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
                color: Theme.of(context).primaryColor,
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
                color: Theme.of(context).primaryColor,
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
                color: Theme.of(context).primaryColor,
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
                color: Theme.of(context).primaryColor,
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
                color: Theme.of(context).primaryColor,
                size: 30.0,
              ),
              onTap: () {
                // replace body widget
                setState(() {
                  appBarTitle = AppLocalizations.of(context)!.available_workers;
                  _showBottomBar = false;
                  bodyWidget = AvailableWorkersWidget(
                    bodyList: getBodyList(context),
                    priFunctionList: getPrimaryFunctionsList(context),
                    secFunctionList: getSecondaryFunctionsList(context),
                    fpFunctionList: getFpFunctionsList(context),
                    eoiFunctionList: getEoiFunctionsList(context),
                  );
                });
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.procedures),
              leading: Icon(
                Icons.schedule,
                color: Theme.of(context).primaryColor,
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
                color: Theme.of(context).primaryColor,
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
                color: Theme.of(context).primaryColor,
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
              title: Text(AppLocalizations.of(context)!.more_info),
              leading: Icon(
                Icons.info,
                color: Theme.of(context).primaryColor,
                size: 30.0,
              ),
              onTap: () {
                // Ask for confirmation dialog
                showAboutDialog(
                  context: context,
                  applicationVersion: '1.0.0',
                  applicationName: 'Gestint',
                  applicationLegalese: AppLocalizations.of(context)!.copyright_info,
                  applicationIcon: Image(image: AssetImage('assets/images/flag.png')),
                );
              },
            ),
            Divider(color: Theme.of(context).primaryColor,),
            ListTile(
              title: Text(AppLocalizations.of(context)!.logout),
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).primaryColor,
                size: 30.0,
              ),
              onTap: () {
                // Ask for confirmation dialog
                _showConfirmationDialog();
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
    setState(() {
      _isLoading = false;
      _workerNotFound = true;
    });
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.confirmation),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(AppLocalizations.of(context)!.logout_warning),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.yes),
              onPressed: () {
                // Clear Provider userId
                Provider.of<User>(context, listen: false).clearUserId();
                // Then close dialog
                Navigator.of(context).pop();
                //Then close drawer
                Navigator.pop(context);
                //Then return to login screen
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.no),
              onPressed: () {
                // Close dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<String> getBodyList(BuildContext context) {
    return [
      '058 ' + AppLocalizations.of(context)!.primary,
      '059 ' + AppLocalizations.of(context)!.secondary,
      '060 ' + AppLocalizations.of(context)!.fp,
      '061 ' + AppLocalizations.of(context)!.eoi,
    ];
  }

  List<String> getPrimaryFunctionsList(BuildContext context) {
    return [
      '021 ' + AppLocalizations.of(context)!.ccss,
      '022 ' + AppLocalizations.of(context)!.ccnn,
      '023 ' + AppLocalizations.of(context)!.maths,
      '024 ' + AppLocalizations.of(context)!.cast,
      '025 ' + AppLocalizations.of(context)!.english,
      '026 ' + AppLocalizations.of(context)!.french,
      '027 ' + AppLocalizations.of(context)!.ef,
      '028 ' + AppLocalizations.of(context)!.music,
    ];
  }

  List<String> getSecondaryFunctionsList(BuildContext context) {
    return [
      '001 ' + AppLocalizations.of(context)!.filo,
      '002 ' + AppLocalizations.of(context)!.greek,
      '003 ' + AppLocalizations.of(context)!.latin,
      '004 ' + AppLocalizations.of(context)!.cast,
      '005 ' + AppLocalizations.of(context)!.geo_hist,
      '006 ' + AppLocalizations.of(context)!.maths,
      '007 ' + AppLocalizations.of(context)!.fq,
      '008 ' + AppLocalizations.of(context)!.bio_geo,
      '009 ' + AppLocalizations.of(context)!.draw,
      '010 ' + AppLocalizations.of(context)!.french,
      '011 ' + AppLocalizations.of(context)!.english,
      '012 ' + AppLocalizations.of(context)!.german,
      '013 ' + AppLocalizations.of(context)!.music,
      '014 ' + AppLocalizations.of(context)!.economy,
      '015 ' + AppLocalizations.of(context)!.ef,
      '016 ' + AppLocalizations.of(context)!.technology,
    ];
  }

  List<String> getFpFunctionsList(BuildContext context) {
    return [
      '101 ' + AppLocalizations.of(context)!.cooking,
      '102 ' + AppLocalizations.of(context)!.electronic,
      '103 ' + AppLocalizations.of(context)!.aesthetic,
      '104 ' + AppLocalizations.of(context)!.installs,
      '105 ' + AppLocalizations.of(context)!.vehicle,
      '106 ' + AppLocalizations.of(context)!.hair,
      '107 ' + AppLocalizations.of(context)!.administration,
      '108 ' + AppLocalizations.of(context)!.community_services,
    ];
  }

  List<String> getEoiFunctionsList(BuildContext context) {
    return [
      '201 ' + AppLocalizations.of(context)!.german,
      '202 ' + AppLocalizations.of(context)!.english,
      '203 ' + AppLocalizations.of(context)!.spanish_foreign,
      '204 ' + AppLocalizations.of(context)!.french,
    ];
  }

}