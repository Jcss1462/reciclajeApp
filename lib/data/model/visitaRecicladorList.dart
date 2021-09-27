import 'package:reciclaje_app/data/model/vistaRecicladore.dart';

class VistaRecicladorList {
  final List<VisitaReciclador> visitaReciclador;

  VistaRecicladorList({
    this.visitaReciclador,
  });

  factory VistaRecicladorList.fromJson(List<dynamic> parsedJson) {
    // ignore: deprecated_member_use
    List<VisitaReciclador> visitaReciclador =
        // ignore: deprecated_member_use
        new List<VisitaReciclador>();

    visitaReciclador =
        parsedJson.map((i) => VisitaReciclador.fromJson(i)).toList();

    return new VistaRecicladorList(
      visitaReciclador: visitaReciclador,
    );
  }
}
