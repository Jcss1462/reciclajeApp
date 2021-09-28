import 'package:reciclaje_app/data/model/vistaRecicladore.dart';

class VisitaRecicladorList {
  final List<VisitaReciclador> visitaReciclador;

  VisitaRecicladorList({
    this.visitaReciclador,
  });

  factory VisitaRecicladorList.fromJson(List<dynamic> parsedJson) {
    // ignore: deprecated_member_use
    List<VisitaReciclador> visitaReciclador =
        // ignore: deprecated_member_use
        new List<VisitaReciclador>();

    visitaReciclador =
        parsedJson.map((i) => VisitaReciclador.fromJson(i)).toList();

    return new VisitaRecicladorList(
      visitaReciclador: visitaReciclador,
    );
  }
}
