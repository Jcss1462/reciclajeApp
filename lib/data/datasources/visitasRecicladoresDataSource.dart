import 'dart:convert';

import 'package:reciclaje_app/data/model/aceptarVista.dart';
import 'package:reciclaje_app/data/model/ventaList.dart';
import 'package:reciclaje_app/data/model/ventas.dart';
import 'package:reciclaje_app/data/model/visitaRecicladorList.dart';
import 'package:reciclaje_app/data/model/vistaRecicladore.dart';
import 'package:reciclaje_app/data/network/api_provider.dart';

abstract class VisitasDatasource {
  Future<VentasList> ventasDisponiblesporCentrodeAcopio(String email);
  Future<VisitaReciclador> aplicarVistaVentas(
      VisitaReciclador visitaReciclador);
  Future<VentasList> visitasaceptadas(String email);
  Future<VentasList> ventasAplicadas(String email);
  Future<VistaRecicladorList> vistasByVentas(int idVenta);
  Future<Ventas> aceptarVisita(AceptarVisita aceptarVisita);
  Future<dynamic> delSolicitudVisita(int idVisita);
  Future<VentasList> getListaVentasVendidas(String email);
}

class VisitasDatasourceImpl implements VisitasDatasource {
  ApiProvider _apiProvider = ApiProvider();

// pantalla centro de acopio
  @override
  Future<VentasList> ventasDisponiblesporCentrodeAcopio(String email) async {
    final response = await _apiProvider.get(
        "/api/v1/visitasRecicladores/ventasDisponiblesNoaplicadasPorCentroDeAcopio/" +
            email);
    return VentasList.fromJson(response);
  }

//pantalla Aplicar a venta Reciclador
/*"idventa_Venta": 19,
    "emailCentroDeAcopio": "danielachocue3@gmail.com",
    "fechahora": "2021-06-03T22:46:00
*/
  @override
  Future<VisitaReciclador> aplicarVistaVentas(
      VisitaReciclador visitaReciclador) async {
    String body = jsonEncode(visitaReciclador.toJson());
    print(body);
    final response = await _apiProvider.post(
        "/api/v1/visitasRecicladores/aplicarVisitaVenta", body);
    print(response);
    return VisitaReciclador.fromJson(response);
  }

//centro de acopio ve todas las  compras aceptadas
  @override
  Future<VentasList> visitasaceptadas(String email) async {
    final response = await _apiProvider
        .get("/api/v1/visitasRecicladores/visitasAceptadas/" + email);
    return VentasList.fromJson(response);
  }

//Reciclador ve todas las ventas a las que aplico
  @override
  Future<VentasList> ventasAplicadas(String email) async {
    final response = await _apiProvider
        .get("/api/v1/visitasRecicladores/ventasAplicadas/" + email);
    return VentasList.fromJson(response);
  }

// Reciclador para aplicar o rechazar a la venta
  @override
  Future<VistaRecicladorList> vistasByVentas(int idVenta) async {
    final response = await _apiProvider.get(
        "/api/v1/visitasRecicladores/visitasByVentas/" + idVenta.toString());
    return VistaRecicladorList.fromJson(response);
  }

//Aceptar visita al centro de acopio en reciclador
  @override
  Future<Ventas> aceptarVisita(AceptarVisita aceptarVisita) async {
    String body = jsonEncode(aceptarVisita.toJson());
    print(body);
    final response = await _apiProvider.put(
        "/api/v1/visitasRecicladores/aceptarVisita", body);
    print(response);
    return Ventas.fromJson(response);
  }

//Rechazar visita en reciclador
  @override
  Future<dynamic> delSolicitudVisita(int idVisita) async {
    return await _apiProvider
        .del("/api/v1/visitasRecicladores/deleteVisita/" + idVisita.toString());
  }

  @override
  Future<VentasList> getListaVentasVendidas(String email) async {
    final response = await _apiProvider.get(
        "/api/v1/visitasRecicladores/ventasVendidasReciclador/" +
            email.toString());
    return VentasList.fromJson(response);
  }
}
