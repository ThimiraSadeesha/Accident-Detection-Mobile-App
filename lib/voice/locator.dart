import 'package:geolocator/geolocator.dart';

Future<Position> getLocation() async {
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}
