import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/widgets.dart';
// import 'package:geolocator/geolocator.dart';

class PoliceStations extends StatefulWidget {
  PoliceStations({Key key}) : super(key: key);

  @override
  _PoliceStationsState createState() => _PoliceStationsState();
}

class _PoliceStationsState extends State<PoliceStations> {
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  // Location _location = Location();
  static const LatLng _center =
      const LatLng(17.479952520074985, 78.33599582289442);

  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _markers.addAll([
        Marker(
            markerId: MarkerId('p1'),
            position: LatLng(17.429855626234204, 78.43652165327988),
            icon: BitmapDescriptor.defaultMarker),
        Marker(
            markerId: MarkerId('p2'),
            position: LatLng(17.502569513460983, 78.31708085701307),
            icon: BitmapDescriptor.defaultMarker),
        Marker(
            markerId: MarkerId('p3'),
            infoWindow: InfoWindow(title: "Kukutpally Police Station"),
            position: LatLng(17.50488476496054, 78.39185273760285),
            icon: BitmapDescriptor.defaultMarker),
        Marker(
            markerId: MarkerId('p4'),
            position: LatLng(17.494697437698715, 78.41321613205707),
            icon: BitmapDescriptor.defaultMarker),
        Marker(
            markerId: MarkerId('p5'),
            position: LatLng(17.437730505611103, 78.40884634682781),
            icon: BitmapDescriptor.defaultMarker)
      ]);
    });
    _controller.complete(controller);

    // Position position = await Geolocator()
    //     .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    // _controller.animateCamera(CameraUpdate.newCameraPosition(
    //     CameraPosition(target: LatLng(position.latitude, position.longitude))));
    // GeolocationStatus geolocationStatus =
    //     await Geolocator().checkGeolocationPermissionStatus();
    // _location.onLocationChanged.listen((event) {
    //   _controller.animateCamera(CameraUpdate.newCameraPosition(
    //       CameraPosition(target: LatLng(event.latitude, event.longitude))));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: _markers,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }
}
