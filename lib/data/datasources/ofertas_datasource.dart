import 'dart:convert';
import 'package:reciclaje_app/data/model/aplicantesOfertasList.dart';
import 'package:reciclaje_app/data/model/aplicarOferta.dart';
import 'package:reciclaje_app/data/model/oferta.dart';
import 'package:reciclaje_app/data/model/ofertaList.dart';
import 'package:reciclaje_app/data/network/api_provider.dart';

abstract class OfertasDatasource {
  Future<Oferta> crearOferta(Oferta nuevaOferta);
  Future<OfertaList> getMyOfertasCentrodeAcopio(String email);
  Future<dynamic> eliminarOferta(int idOferta);
  Future<AplicanteOfertasList> getAplicanteMyOferta(int idOferta);
  Future<OfertaList> getOfertasDisponiblesbyReciclador(String email);
  Future<AplicarOferta> aplicarOferta(AplicarOferta aplicarOferta);
  Future<AplicanteOfertasList> getMisAplicaciones(String email);
  Future<dynamic> eliminarAplicacion(int idAplicacion);
}

class OfertasDatasourceImpl implements OfertasDatasource {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<Oferta> crearOferta(Oferta nuevaOferta) async {
    String body = jsonEncode(nuevaOferta.toJson());
    print(body);
    final response =
        await _apiProvider.post("/api/v1/ofertas/nuevaOferta", body);
    print(response);
    return Oferta.fromJson(response);
  }

  @override
  Future<OfertaList> getMyOfertasCentrodeAcopio(String email) async {
    final response =
        await _apiProvider.get("/api/v1/ofertas/findMyOfertas/" + email);
    print(response);
    return OfertaList.fromJson(response);
  }

  @override
  Future<dynamic> eliminarOferta(int idOferta) async {
    return await _apiProvider
        .del("/api/v1/ofertas/deleteOferta/" + idOferta.toString());
  }

  @override
  Future<AplicanteOfertasList> getAplicanteMyOferta(int idOferta) async {
    final response = await _apiProvider
        .get("/api/v1/ofertas/aplicantesByOferta/" + idOferta.toString());
    print(response);
    return AplicanteOfertasList.fromJson(response);
  }

  @override
  Future<OfertaList> getOfertasDisponiblesbyReciclador(String email) async {
    final response = await _apiProvider
        .get("/api/v1/ofertas/allOfertasDiponiblesByReciclador/" + email);
    print(response);
    return OfertaList.fromJson(response);
  }

  @override
  Future<AplicarOferta> aplicarOferta(AplicarOferta aplicarOferta) async {
    String body = jsonEncode(aplicarOferta.toJson());
    print(body);
    final response =
        await _apiProvider.post("/api/v1/ofertas/aplicarOferta", body);
    print(response);
    return AplicarOferta.fromJson(response);
  }

  @override
  Future<AplicanteOfertasList> getMisAplicaciones(String email) async {
    final response = await _apiProvider
        .get("/api/v1/ofertas/myAplicacionesDisponiblesReciclador/" + email);
    print(response);
    return AplicanteOfertasList.fromJson(response);
  }

  @override
  Future<dynamic> eliminarAplicacion(int idAplicacion) async {
    return await _apiProvider
        .del("/api/v1/ofertas/deleteAplicacion/" + idAplicacion.toString());
  }
}
