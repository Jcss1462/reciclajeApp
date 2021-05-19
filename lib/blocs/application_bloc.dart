import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reciclaje_app/data/model/placeSearch.dart';
import 'package:reciclaje_app/service/geolocator.dart';
import 'package:reciclaje_app/service/places_service.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeolacatorService();
  final placesService = PlacesService();

  Position currentLocation;
  List<PlaceSearch> searchResults;

  ApplicationBloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }
}
