import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/schools_view_contract.dart';
import 'package:gestint/models/school_model.dart';
import 'package:gestint/presenters/schools_presenter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

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
    //TODO
    /*final status = await Permission.location.serviceStatus;
    final isGpsActive = status == ServiceStatus.enabled;
    if(!isGpsActive) {
      print('Gps no activo');
    }*/
    if (await Permission.location.request().isGranted) {
      // Permiso concedido
      _goToMyPosition();
    }

  }

  Future _getSchoolsInfo() async {
    _schoolsPresenter.getSchools();
  }

  // Initial position, these are central Mallorca coordinates
  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(39.615689, 2.882468),
    zoom: 20,
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
        backgroundColor: Color.fromARGB(255, 204, 7, 60),
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
    // TODO: implement onLoadSchoolsError
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
            //TODO
          },
        );
        _markers[school.phoneNumber] = marker;
      }
    });
  }
}