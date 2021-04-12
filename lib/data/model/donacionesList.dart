import 'package:reciclaje_app/data/model/donaciones.dart';

class DonacionesList {
  final List<Donaciones> donaciones;

  DonacionesList({
    this.donaciones,
  });

  factory DonacionesList.fromJson(List<dynamic> parsedJson) {
    // ignore: deprecated_member_use
    List<Donaciones> donaciones = new List<Donaciones>();

    donaciones = parsedJson.map((i) => Donaciones.fromJson(i)).toList();

    return new DonacionesList(
      donaciones: donaciones,
    );
  }
}
