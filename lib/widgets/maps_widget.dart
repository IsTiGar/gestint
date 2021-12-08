import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/schools_view_contract.dart';
import 'package:gestint/models/school_model.dart';
import 'package:gestint/presenters/schools_presenter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapsWidget extends StatefulWidget {
  @override
  State<MapsWidget> createState() => MapsWidgetState();
}

class MapsWidgetState extends State<MapsWidget> implements SchoolsViewContract {

  late SchoolsPresenter _schoolsPresenter;
  final Map<String, Marker> _markers = {};

  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    _schoolsPresenter = SchoolsPresenter(this);
    _checkLocationPermission().then((value){
      print('Async done');
    });
    _getSchoolsInfo();
  }

  Future _checkLocationPermission() async {
    if (await Permission.location.request().isGranted) {
      // Access granted
      _goToMyPosition();
    }
  }

  // Get schools location coordinates
  Future _getSchoolsInfo() async {
    _schoolsPresenter.getSchools();
  }

  // Initial position, these are central Mallorca coordinates
  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(39.615689, 2.882468),
    zoom: 7,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        mapType: MapType.hybrid,
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers.values.toSet(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToMyPosition,
        child: Icon(Icons.my_location),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Future<void> _goToMyPosition() async {
    final GoogleMapController controller = await _controller.future;
    LocationData currentLocation;
    var location = new Location();
    currentLocation = await location.getLocation();

    if(currentLocation.latitude != null && currentLocation.longitude != null) {
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          zoom: 17.0,
        ),
      ));
    }

  }

  @override
  void onLoadSchoolsError() {
    _showErrorDialog();
  }

  @override
  void onLoadSchoolsComplete(List<School> schoolList) {
    setState(() {
      for (final school in schoolList) {
        final marker = Marker(
          markerId: MarkerId(school.phoneNumber),
          position: LatLng(school.locationLat, school.locationLong),
          infoWindow: InfoWindow(title: school.name, snippet: school.phoneNumber),
          onTap: () {
            // Show school info
          },
        );
        _markers[school.phoneNumber] = marker;
      }
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
              Text(AppLocalizations.of(context)!.maps_warning),
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