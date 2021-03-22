import 'package:reciclaje_app/data/model/tipoResiduo.dart';

class TipoResiduoList {
  final List<TipoResiduo> tipoResiduos;

  TipoResiduoList({
    this.tipoResiduos,
  });

  factory TipoResiduoList.fromJson(List<dynamic> parsedJson) {
    // ignore: deprecated_member_use
    List<TipoResiduo> tipoResiduos = new List<TipoResiduo>();

    tipoResiduos = parsedJson.map((i) => TipoResiduo.fromJson(i)).toList();

    return new TipoResiduoList(
      tipoResiduos: tipoResiduos,
    );
  }
}
