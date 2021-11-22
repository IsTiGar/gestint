
import 'package:flutter/material.dart';
import 'package:gestint/contracts/worker_view_contract.dart';
import 'package:gestint/models/worker_model.dart';
import 'package:gestint/presenters/worker_presenter.dart';
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

class MainMenuView extends StatefulWidget{

  MainMenuView({Key? key}) : super(key: key);

  @override
  State<MainMenuView> createState() => _MainMenuState();

}

class _MainMenuState extends State<MainMenuView> implements WorkerViewContract {

  late WorkerPresenter _workerPresenter;
  late Worker _worker;
  bool _isLoading = true;
  Widget bodyWidget = WelcomeWidget();
  String appBarTitle = 'Portal del personal';

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _workerPresenter = WorkerPresenter(this);
    _workerPresenter.getWorkerProfile();
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
              title: const Text('Expediente personal'),
              leading: Icon(
                Icons.folder,
                color: Color.fromARGB(255, 204, 7, 60),
                size: 30.0,
              ),
              onTap: () {
                // replace body widget
                setState(() {
                  appBarTitle = 'Expediente personal';
                  bodyWidget = PersonalFileWidget();
                });
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Documentos'),
              leading: Icon(
                Icons.description,
                color: Color.fromARGB(255, 204, 7, 60),
                size: 30.0,
              ),
              onTap: () {
                // replace body widget
                setState(() {
                  appBarTitle = 'Documentos';
                  bodyWidget = DocumentsWidget();
                });
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Datos económicos'),
              leading: Icon(
                Icons.euro,
                color: Color.fromARGB(255, 204, 7, 60),
                size: 30.0,
              ),
              onTap: () {
                // replace body widget
                setState(() {
                  appBarTitle = 'Datos económicos';
                  bodyWidget = PayrollWidget();
                });
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Formación'),
              leading: Icon(
                Icons.school,
                color: Color.fromARGB(255, 204, 7, 60),
                size: 30.0,
              ),
              onTap: () {
                // replace body widget
                setState(() {
                  appBarTitle = 'Formación';
                  //bodyWidget = ScaleWidget();
                });
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Baremación'),
              leading: Icon(
                Icons.swap_vert,
                color: Color.fromARGB(255, 204, 7, 60),
                size: 30.0,
              ),
              onTap: () {
                // replace body widget
                setState(() {
                  appBarTitle = 'Baremación';
                  bodyWidget = ScaleWidget();
                });
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Interinos disponibles'),
              leading: Icon(
                Icons.people,
                color: Color.fromARGB(255, 204, 7, 60),
                size: 30.0,
              ),
              onTap: () {
                // replace body widget
                setState(() {
                  appBarTitle = 'Interinos disponibles';
                  bodyWidget = AvailableWorkersWidget();
                });
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Trámites'),
              leading: Icon(
                Icons.schedule,
                color: Color.fromARGB(255, 204, 7, 60),
                size: 30.0,
              ),
              onTap: () {
                // replace body widget
                setState(() {
                  appBarTitle = 'Trámites';
                  bodyWidget = ProceduresWidget();
                });
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Mapa de centros'),
              leading: Icon(
                Icons.place,
                color: Color.fromARGB(255, 204, 7, 60),
                size: 30.0,
              ),
              onTap: () {
                // replace body widget
                setState(() {
                  appBarTitle = 'Mapa de centros';
                  bodyWidget = MapsWidget();
                });
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Contacto'),
              leading: Icon(
                Icons.contact_support,
                color: Color.fromARGB(255, 204, 7, 60),
                size: 30.0,
              ),
              onTap: () {
                // replace body widget
                setState(() {
                  appBarTitle = 'Contacto';
                  bodyWidget = ContactWidget();
                });
                // Close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Salir'),
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