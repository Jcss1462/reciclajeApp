import 'dart:convert';

import 'package:reciclaje_app/data/model/donacionesList.dart';
import 'package:reciclaje_app/data/model/nuevaDonacion.dart';
import 'package:reciclaje_app/data/network/api_provider.dart';

abstract class CarroDonacionesDataSource {
  Future<DonacionesList> misDonaciones(String email);

  Future<dynamic> delDonacion(int idDonacion);

  Future<NuevaDonacion> crearDonacion(NuevaDonacion nuevaDonacion);
}

class CarroDonacionesDataSourceImpl implements CarroDonacionesDataSource {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<DonacionesList> misDonaciones(String email) async {
    final response = await _apiProvider
        .get("/api/v1/carritoDonacion/misDonacionesActuales/" + email);
    print(response);
    return DonacionesList.fromJson(response);
  }

  @override
  Future<dynamic> delDonacion(int idDonacion) async {
    return await _apiProvider
        .del("/api/v1/carritoDonacion/deleteDonacion/" + idDonacion.toString());
  }

  @override
  Future<NuevaDonacion> crearDonacion(NuevaDonacion nuevaDonacion) async {
    String body = jsonEncode(nuevaDonacion.toJson());
    print(body);
    final response =
        await _apiProvider.post("/api/v1/carritoDonacion/nuevaDonacion", body);
    print(response);
    return NuevaDonacion.fromJson(response);
  }
}
