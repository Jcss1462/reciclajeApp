
import 'package:reciclaje_app/data/model/venta.dart';

class VentasList {
  final List<Ventas> ventas;

  VentasList({
    this.ventas,
  });

  factory VentasList.fromJson(List<dynamic> parsedJson) {
    // ignore: deprecated_member_use
    List<Ventas> ventas = new List<Ventas>();

    ventas = parsedJson.map((i) => Ventas.fromJson(i)).toList();

    return new VentasList(
      ventas: ventas,
    );
  }
}
