import 'dart:convert';

import 'package:reciclaje_app/data/model/aplicacionRecoleccion.dart';
import 'package:reciclaje_app/data/model/carrodeDonacionList.dart';
import 'package:reciclaje_app/data/model/solicituddeRecoleccionList.dart';
import 'package:reciclaje_app/data/network/api_provider.dart';

abstract class RecoleccionDonacionDataSource {
  Future<CarrodeDonacionList> donacionesDisponibles();
  Future<AplicacionRecoleccion> aplicacionaRecolectar(
      AplicacionRecoleccion appRecolecion);
  Future<SolicituddeRecoleccionList> misSolicitudes(String email);
}

class RecoleccionDonacionDataSourceImpl
    implements RecoleccionDonacionDataSource {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<CarrodeDonacionList> donacionesDisponibles() async {
    final response =
        await _apiProvider.get("/api/v1/recoleccion/allDonacionesByEnable");
    print(response);
    return CarrodeDonacionList.fromJson(response);
  }

  @override
  Future<AplicacionRecoleccion> aplicacionaRecolectar(
      AplicacionRecoleccion appRecolecion) async {
    String body = jsonEncode(appRecolecion.toJson());
    print(body);
    final response = await _apiProvider.post(
        "/api/v1/recoleccion/aplicacionARecolectar", body);
    print(response);
    return AplicacionRecoleccion.fromJson(response);
  }

  @override
  Future<SolicituddeRecoleccionList> misSolicitudes(String email) async {
    final response =
        await _apiProvider.get("api/v1/recoleccion/misSolicitudes/" + email);
    print(response);
    return SolicituddeRecoleccionList.fromJson(response);
  }
}
