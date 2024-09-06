import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:math' show cos, sqrt, asin;

const String API_KEY = 'AIzaSyDJe5ZbrJYaerJn_iaKVrabZ1ZRGjKgBV0';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  Set<Marker> _markers = {};
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  late Position _currentPosition;
  late StreamSubscription<Position> _positionStream;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _markers = _createMarkers();
    _startLocationUpdates();
  }

  @override
  void dispose() {
    _positionStream.cancel();
    super.dispose();
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
      });
      _updateCameraPosition(position.latitude, position.longitude, zoom: 14.0);
    } catch (e) {
      print('Error: $e');
    }
  }

  void _startLocationUpdates() {
    var locationOptions = LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10);
    _positionStream = Geolocator.getPositionStream(locationSettings: locationOptions).listen((Position position) {
      setState(() {
        _currentPosition = position;
        _updateCameraPosition(position.latitude, position.longitude, zoom: 14.0);
      });
    });
  }

  Set<Marker> _createMarkers() {
    List<LatLng> locations = [
      const LatLng(7.546420, 80.448871), // Location 1
      const LatLng(8.546420, 90.448871), // Location 2
      const LatLng(9.546420, 85.448871), // Location 3
      const LatLng(10.546420, 84.448871), // Location 4
      const LatLng(11.546420, 83.448871), // Location 5
    ];
    return locations.asMap().entries.map((entry) {
      int idx = entry.key;
      LatLng loc = entry.value;
      return Marker(
        markerId: MarkerId("$idx"),
        position: loc,
        infoWindow: InfoWindow(title: "Location ${idx + 1}"),
        onTap: () => _updateCameraPosition(loc.latitude, loc.longitude),
      );
    }).toSet();
  }

  Future<void> _updateCameraPosition(double lat, double lng, {double zoom = 14.0}) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition position = CameraPosition(target: LatLng(lat, lng), zoom: zoom);
    controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: const CameraPosition(target: LatLng(6.883907, 80.017341), zoom: 10.0),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                setState(() {
                  _markers = _createMarkers();
                });
              },
              markers: _markers,
              polylines: Set<Polyline>.of(polylines.values),
              onTap: (LatLng position) {
                _addMarker(position, 'Selected Location');
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addMarker(LatLng position, String id) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(id),
          position: position,
          infoWindow: InfoWindow(title: id),
        ),
      );
    });
  }
}
