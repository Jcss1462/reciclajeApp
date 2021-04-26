import 'package:reciclaje_app/data/model/solicituddeRecoleccion.dart';

class SolicituddeRecoleccionList {
  final List<SolicituddeRecoleccion> solicituddeRecoleccion;

  SolicituddeRecoleccionList({
    this.solicituddeRecoleccion,
  });

  factory SolicituddeRecoleccionList.fromJson(List<dynamic> parsedJson) {
    // ignore: deprecated_member_use
    List<SolicituddeRecoleccion> solicituddeRecoleccion =
        // ignore: deprecated_member_use
        new List<SolicituddeRecoleccion>();

    solicituddeRecoleccion =
        parsedJson.map((i) => SolicituddeRecoleccion.fromJson(i)).toList();

    return new SolicituddeRecoleccionList(
      solicituddeRecoleccion: solicituddeRecoleccion,
    );
  }
}
