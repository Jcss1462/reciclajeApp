import 'dart:convert';

import 'package:reciclaje_app/data/model/aplicantesOfertasList.dart';
import 'package:reciclaje_app/data/model/oferta.dart';
import 'package:reciclaje_app/data/model/ofertaList.dart';
import 'package:reciclaje_app/data/network/api_provider.dart';

abstract class OfertasDatasource {
  Future<Oferta> crearOferta(Oferta nuevaOferta);
  Future<OfertaList> getMyOfertasCentrodeAcopio(String email);
  Future<dynamic> eliminarOferta(int idOferta);
  Future<AplicanteOfertasList> getAplicanteMyOferta(int idOferta);
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
}
