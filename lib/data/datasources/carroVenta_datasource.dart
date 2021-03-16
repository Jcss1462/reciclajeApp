import 'package:reciclaje_app/data/model/ventaList.dart';
import 'package:reciclaje_app/data/network/api_provider.dart';


abstract class CarroVentasDataSource {
  
  Future<VentasList> misVentas(String email);

  Future<dynamic> delVenta(int idVenta);
}

class CarroVentasDataSourceImpl implements CarroVentasDataSource {
  ApiProvider _apiProvider = ApiProvider();
 

  @override
  Future<VentasList> misVentas(String email) async {
  
    final response = await _apiProvider.get("/api/v1/carritoVentas/findMyVentas/"+email);
    print(response);
    return VentasList.fromJson(response);
 
  }

  @override
  Future<dynamic> delVenta(int idVenta) async {
  

    return await _apiProvider.del("/api/v1/carritoVentas/deleteVenta/"+idVenta.toString());
 
  }

}
