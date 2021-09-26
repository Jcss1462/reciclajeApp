import 'package:reciclaje_app/data/model/aplicanteOferta.dart';

class AplicanteOfertasList {
  final List<AplicanteOferta> aplicantes;

  AplicanteOfertasList({this.aplicantes});

  factory AplicanteOfertasList.fromJson(List<dynamic> parsedJson) {
    // ignore: deprecated_member_use
    List<AplicanteOferta> aplicantes = new List<AplicanteOferta>();

    aplicantes = parsedJson.map((i) => AplicanteOferta.fromJson(i)).toList();

    return new AplicanteOfertasList(
      aplicantes: aplicantes,
    );
  }
}
