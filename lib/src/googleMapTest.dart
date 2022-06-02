import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mive/src/permission.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  // final Completer<GoogleMapController> _controller = Completer();
  //
  // void _currentLocation() async {
  //   final GoogleMapController controller = await _controller.future;
  //   LocationData? currentLocation;
  //   var location = Location();
  //   try {
  //     currentLocation = await location.getLocation();
  //   } on Exception {
  //     currentLocation = null;
  //   }
  //
  //   controller.animateCamera(CameraUpdate.newCameraPosition(
  //     CameraPosition(
  //       bearing: 0,
  //       target: LatLng(currentLocation!.latitude!.toDouble(), currentLocation.longitude!.toDouble()),
  //       zoom: 14.0,
  //     ),
  //   ));
  // }

  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController? _controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!),zoom: 15),
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        // onMapCreated: (GoogleMapController controller) {
        //   _controller.complete(controller);
        // },
        initialCameraPosition: CameraPosition(target: _initialcameraposition),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _currentLocation,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

}