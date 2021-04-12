import 'dart:convert';

import 'package:reciclaje_app/data/model/donaciones.dart';
import 'package:reciclaje_app/data/model/donacionesList.dart';
import 'package:reciclaje_app/data/model/nuevaDonacion.dart';
import 'package:reciclaje_app/data/model/tipoResiduoList.dart';
import 'package:reciclaje_app/data/network/api_provider.dart';

abstract class CarroDonacionesDataSource {
  Future<DonacionesList> misDonaciones(String email);

  Future<dynamic> delDonacion(int idDonacion);

  Future<TipoResiduoList> obtenerTiposResiduos();

  Future<NuevaDonacion> crearDonacion(NuevaDonacion nuevaDonacion);

  Future<Donaciones> findByIdDonaciones(int idDonacion);
}

class CarroDonacionesDataSourceImpl implements CarroDonacionesDataSource {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<DonacionesList> misDonaciones(String email) async {
    final response =
        await _apiProvider.get("/api/v1/carritoVentas/findMyVentas/" + email);
    print(response);
    return DonacionesList.fromJson(response);
  }

  @override
  Future<dynamic> delDonacion(int idVenta) async {
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
  Future<Donaciones> findByIdDonaciones(int idVenta) async {
    final response = await _apiProvider
        .get("/api/v1/carritoVentas/ventaInfo/" + idVenta.toString());
    return Donaciones.fromJson(response);
  }

  @override
  Future<NuevaDonacion> crearDonacion(NuevaDonacion nuevaDonacion) async {
    String body = jsonEncode(nuevaDonacion.toJson());
    print(body);
    final response =
        await _apiProvider.post("/api/v1/carritoVentas/nuevaVenta", body);
    print(response);
    return NuevaDonacion.fromJson(response);
  }
}
