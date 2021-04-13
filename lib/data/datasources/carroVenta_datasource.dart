import 'dart:convert';

import 'package:reciclaje_app/data/model/nuevaVenta.dart';
import 'package:reciclaje_app/data/model/tipoResiduoList.dart';
import 'package:reciclaje_app/data/model/ventaList.dart';
import 'package:reciclaje_app/data/model/ventas.dart';
import 'package:reciclaje_app/data/network/api_provider.dart';

abstract class CarroVentasDataSource {
  Future<VentasList> misVentas(String email);

  Future<dynamic> delVenta(int idVenta);

  Future<TipoResiduoList> obtenerTiposResiduos();

  Future<NuevaVenta> crearVenta(NuevaVenta nuevaVenta);

  Future<Ventas> findByIdVentas(int idVenta);

  Future<Ventas> editVenta(Ventas venta);
}

class CarroVentasDataSourceImpl implements CarroVentasDataSource {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<VentasList> misVentas(String email) async {
    final response =
        await _apiProvider.get("/api/v1/carritoVentas/findMyVentas/" + email);
    print(response);
    return VentasList.fromJson(response);
  }

  @override
  Future<dynamic> delVenta(int idVenta) async {
    return await _apiProvider
        .del("/api/v1/carritoVentas/deleteVenta/" + idVenta.toString());
  }

  @override
  Future<TipoResiduoList> obtenerTiposResiduos() async {
    final response =
        await _apiProvider.get("/api/v1/carritoVentas/listTipoResiduo");
    print(response);
    return TipoResiduoList.fromJson(response);
  }

  @override
  Future<Ventas> findByIdVentas(int idVenta) async {
    final response = await _apiProvider
        .get("/api/v1/carritoVentas/ventaInfo/" + idVenta.toString());
    return Ventas.fromJson(response);
  }

  @override
  Future<NuevaVenta> crearVenta(NuevaVenta nuevaVenta) async {
    String body = jsonEncode(nuevaVenta.toJson());
    print(body);
    final response =
        await _apiProvider.post("/api/v1/carritoVentas/nuevaVenta", body);
    print(response);
    return NuevaVenta.fromJson(response);
  }

  @override
  Future<Ventas> editVenta(Ventas venta) async {
    String body = jsonEncode(venta.toJson());
    print(body);
    final response =
        await _apiProvider.put("/api/v1/carritoVentas/updateVenta", body);
    print(response);
    return Ventas.fromJson(response);
  }
}
