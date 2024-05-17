import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  Set<Marker> _mapMarkers = {}; // Renamed variable to avoid conflicts
  late CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(6.87170, 80.01758),
    zoom: 14.0,
  ); // Declare _kInitialPosition with default value

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Get current location when the widget initializes
    _mapMarkers = _createMarkers(); // Updated variable name
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _kInitialPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14.0,
        );
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Set<Marker> _createMarkers() {
    return {
      Marker(
        markerId: MarkerId("123"),
        position: LatLng(7.546420, 80.448871),
        infoWindow: InfoWindow(title: "Shop 1"),
        onTap: () => handleTap("123"),
      ),
      Marker(
        markerId: MarkerId("456"),
        position: LatLng(8.546420, 90.448871),
        infoWindow: InfoWindow(title: "Shop 2"),
        onTap: () => handleTap("456"),
      ),
      Marker(
        markerId: MarkerId("678"),
        position: LatLng(9.546420, 85.448871),
        infoWindow: InfoWindow(title: "Shop 3"),
        onTap: () => handleTap("678"),
      ),
    };
  }

  void handleTap(String id) {
    print("Shop pressed $id");
  }

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(6.87170, 80.01758),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kInitialPosition,
        myLocationEnabled: true, // Enable showing user's location
        myLocationButtonEnabled: true, // Enable "Go to My Location" button
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _mapMarkers, // Updated variable name
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('Go to My Location'), // Set a meaningful label
        icon: const Icon(Icons.gps_fixed, color: Colors.black),
        backgroundColor: Colors.white,
        tooltip: 'Go to My Location', // Add a tooltip for accessibility
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
