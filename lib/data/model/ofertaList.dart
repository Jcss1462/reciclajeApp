import 'package:reciclaje_app/data/model/oferta.dart';

class OfertaList {
  final List<Oferta> ofertas;

  OfertaList({
    this.ofertas,
  });

  factory OfertaList.fromJson(List<dynamic> parsedJson) {
    // ignore: deprecated_member_use
    List<Oferta> ofertas = new List<Oferta>();

    ofertas = parsedJson.map((i) => Oferta.fromJson(i)).toList();

    return new OfertaList(
      ofertas: ofertas,
    );
  }
}
