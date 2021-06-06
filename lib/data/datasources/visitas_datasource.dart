import 'dart:convert';

import 'package:reciclaje_app/data/model/agendar.dart';
import 'package:reciclaje_app/data/model/idVisita.dart';
import 'package:reciclaje_app/data/model/visitaCivil.dart';
import 'package:reciclaje_app/data/model/vistasCivilList.dart';
import 'package:reciclaje_app/data/network/api_provider.dart';

abstract class VisitasDatasource {
  Future<VisitaCivilList> visitasDisponibles();
  Future<VisitaCivil> agendar(Agendar agenda);
  Future<VisitaCivilList> misVisitasAgendadasReciclador(String email);
  Future<VisitaCivilList> misVisitasActivasCivil(String email);
  Future<VisitaCivil> cancelarVisitaReciclador(Agendar agenda);
  Future<VisitaCivil> nuevaVisita(VisitaCivil visitaCivil);
  Future<dynamic> eliminarVisitaCivil(int idVisita);
  Future<VisitaCivil> confirmarRecoleccion(IdVista idVista);
}

class VisitasDatasourceImpl implements VisitasDatasource {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<VisitaCivilList> visitasDisponibles() async {
    final response =
        await _apiProvider.get("/api/v1/visitas/visitasDisponibles");
    return VisitaCivilList.fromJson(response);
  }

  @override
  Future<VisitaCivil> agendar(Agendar agenda) async {
    String body = jsonEncode(agenda.toJson());
    print(body);
    final response = await _apiProvider.put("/api/v1/visitas/agendar", body);
    print(response);
    return VisitaCivil.fromJson(response);
  }

  @override
  Future<VisitaCivilList> misVisitasAgendadasReciclador(String email) async {
    final response = await _apiProvider
        .get("/api/v1/visitas/misVisitasAgendadasReciclador/" + email);
    return VisitaCivilList.fromJson(response);
  }

  @override
  Future<VisitaCivil> cancelarVisitaReciclador(Agendar agenda) async {
    String body = jsonEncode(agenda.toJson());
    print(body);
    final response = await _apiProvider.put(
        "/api/v1/visitas/cancelarVisitaReciclador", body);
    print(response);
    return VisitaCivil.fromJson(response);
  }

  @override
  Future<VisitaCivil> nuevaVisita(VisitaCivil visitaCivil) async {
    String body = jsonEncode(visitaCivil.toJson());
    print(body);
    final response =
        await _apiProvider.post("/api/v1/visitas/nuevaVisita", body);
    print(response);
    return VisitaCivil.fromJson(response);
  }

  @override
  Future<VisitaCivilList> misVisitasActivasCivil(String email) async {
    final response = await _apiProvider
        .get("/api/v1/visitas/misVisitasActivasCivil/" + email);
    return VisitaCivilList.fromJson(response);
  }

  @override
  Future<dynamic> eliminarVisitaCivil(int idVisita) async {
    return await _apiProvider
        .del("/api/v1/visitas/eliminarVisitaCivil/" + idVisita.toString());
  }

  @override
  Future<VisitaCivil> confirmarRecoleccion(IdVista idVista) async {
    String body = jsonEncode(idVista.toJson());
    print(body);
    final response =
        await _apiProvider.put("/api/v1/visitas/confirmarRecoleccion", body);
    print(response);
    return VisitaCivil.fromJson(response);
  }
}
