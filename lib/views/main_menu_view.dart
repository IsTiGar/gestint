
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestint/models/worker_model.dart';

class MainMenuView extends StatefulWidget {
  //final WorkerPresenter workerPresenter;

  MainMenuView({Key? key/*, required this.workerPresenter*/}) : super(key: key);

  @override
  State<MainMenuView> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenuView> /*implements WorkerView*/ {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Portal del personal')),
      body: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Expanded(
              child: Text(
                'Bienvenido al portal del personal de la Consejeria de Educación y Formación Profesional de las Islas Baleares',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          )
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
              child: FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance.collection("Worker")
                  .where("id", isEqualTo: "X46959966")
                  .get(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      var list = snapshot.data!.docs.toList();
                      return Text("Name: ${list.first["lastName1"]}");
                    }

                    return CircularProgressIndicator();
                  }
              )
            ),
            ListTile(
              title: const Text('Expediente personal'),
              leading: Icon(
                Icons.folder,
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
            ListTile(
              title: const Text('Documentos'),
              leading: Icon(
                Icons.description,
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
            ListTile(
              title: const Text('Mapa de centros'),
              leading: Icon(
                Icons.place,
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

  /*@override
  void onLoadWorkerComplete(Worker worker) {
    // TODO: implement onLoadWorkerComplete
  }

  @override
  void onLoadWorkerError() {
    // TODO: implement onLoadWorkerError
  }*/
}