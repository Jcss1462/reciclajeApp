import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:reciclaje_app/data/model/placeSearch.dart';

class PlacesService {
  final key = '';

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&key=$key');
    final response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }
}
