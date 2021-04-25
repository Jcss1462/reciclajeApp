import 'package:reciclaje_app/data/model/carrodeDonacion.dart';

class CarrodeDonacionList {
  final List<CarrodeDonacion> solicitudes;

  CarrodeDonacionList({
    this.solicitudes,
  });

  factory CarrodeDonacionList.fromJson(List<dynamic> parsedJson) {
    // ignore: deprecated_member_use
    List<CarrodeDonacion> solicitudes = new List<CarrodeDonacion>();

    solicitudes =
        parsedJson.map((i) => CarrodeDonacion.fromJson(i)).toList();

    return new CarrodeDonacionList(
      solicitudes: solicitudes,
    );
  }
}
