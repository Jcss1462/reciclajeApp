import 'package:geolocator/geolocator.dart';

class GeolacatorService {
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
