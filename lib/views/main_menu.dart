import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Portal del personal')),
      body: const Center(
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
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 204, 7, 60),
              ),
              child: Text('Drawer Header'),
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
}