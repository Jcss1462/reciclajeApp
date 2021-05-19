import 'package:reciclaje_app/data/model/location.dart';

class Geometry {
  Location location;

  Geometry({this.location});

  factory Geometry.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Geometry(location: parsedJson['location']);
  }
}
