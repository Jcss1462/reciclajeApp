import 'dart:convert';

import 'package:reciclaje_app/data/model/aceptarSolicitud.dart';
import 'package:reciclaje_app/data/model/aplicacionRecoleccion.dart';
import 'package:reciclaje_app/data/model/carrodeDonacion.dart';
import 'package:reciclaje_app/data/model/carrodeDonacionList.dart';
import 'package:reciclaje_app/data/model/idCarrdodeDonacion.dart';
import 'package:reciclaje_app/data/model/solicituddeRecoleccionList.dart';
import 'package:reciclaje_app/data/network/api_provider.dart';

abstract class RecoleccionDonacionDataSource {
  Future<CarrodeDonacionList> donacionesDisponibles();
  Future<AplicacionRecoleccion> aplicacionaRecolectar(
      AplicacionRecoleccion appRecolecion);
  Future<SolicituddeRecoleccionList> misSolicitudes(String email);
  Future<CarrodeDonacion> aceptarSolicitud(AceptarSolicitud aceptarSolicitud);
  Future<CarrodeDonacionList> carrosDisponiblesNoAplicados();
  Future<CarrodeDonacionList> recicladorCarrosAsignados(String email);
  Future<CarrodeDonacionList> findMyAplicationsReciclador(String email);
  Future<CarrodeDonacion> removerDeLaRuta(IdCarrodeDonacion idCarrodeDonacion);
  Future<dynamic> eliminarSolicitud(int idSolicitud);
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
        await _apiProvider.get("/api/v1/recoleccion/misSolicitudes/" + email);
    print(response);
    return SolicituddeRecoleccionList.fromJson(response);
  }

  @override
  Future<CarrodeDonacion> aceptarSolicitud(
      AceptarSolicitud aceptarSolicitud) async {
    String body = jsonEncode(aceptarSolicitud.toJson());
    print(body);
    final response =
        await _apiProvider.put("/api/v1/recoleccion/aceptarSolicitud", body);
    print(response);
    return CarrodeDonacion.fromJson(response);
  }

  @override
  Future<CarrodeDonacionList> carrosDisponiblesNoAplicados() async {
    final response = await _apiProvider.get(
        "/api/v1/recoleccion/findAllByByEnableNoAplicados/jcss1462@gmail.com");
    print(response);
    return CarrodeDonacionList.fromJson(response);
  }

  @override
  Future<CarrodeDonacionList> recicladorCarrosAsignados(String email) async {
    final response = await _apiProvider
        .get("/api/v1/recoleccion/findAllMyCarsAsign/" + email);
    print(response);
    return CarrodeDonacionList.fromJson(response);
  }

  @override
  Future<CarrodeDonacionList> findMyAplicationsReciclador(String email) async {
    final response = await _apiProvider
        .get("/api/v1/recoleccion/findMyAplicationsReciclador/" + email);
    print(response);
    return CarrodeDonacionList.fromJson(response);
  }

  @override
  Future<CarrodeDonacion> removerDeLaRuta(
      IdCarrodeDonacion idCarrodeDonacion) async {
    String body = jsonEncode(idCarrodeDonacion.toJson());
    print(body);
    final response =
        await _apiProvider.put("/api/v1/recoleccion/removerDeLaRuta", body);
    print(response);
    return CarrodeDonacion.fromJson(response);
  }

  @override
  Future<dynamic> eliminarSolicitud(int idSolicitud) async {
    return await _apiProvider
        .del("/api/v1/recoleccion/eliminarSolicitud/" + idSolicitud.toString());
  }
}
