import 'package:http/http.dart' as http;
import 'package:reciclaje_app/data/model/place.dart';
import 'dart:convert' as convert;
import 'package:reciclaje_app/data/model/placeSearch.dart';
import 'package:reciclaje_app/globalVariables/globalVariables.dart';

class PlacesService {
  final key = apiKeYMaps;

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=routes&key=$key');
    final response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  Future<Place> getPlace(String placeId) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResult);
  }

  Future<List<Place>> getPlaces(String direccion) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$direccion&key=$key');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}
