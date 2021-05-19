import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reciclaje_app/service/geolocator.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeolacatorService();

  Position currentLocation;

  ApplicationBloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }
}
