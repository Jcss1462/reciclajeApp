import 'package:reciclaje_app/data/model/vistasCivilList.dart';
import 'package:reciclaje_app/data/network/api_provider.dart';

abstract class VisitasDatasource {
  Future<VisitaCivilList> visitasDisponibles();
}

class VisitasDatasourceImpl implements VisitasDatasource {
  ApiProvider _apiProvider = ApiProvider();

  @override
  Future<VisitaCivilList> visitasDisponibles() async {
    final response =
        await _apiProvider.get("/api/v1/visitas/visitasDisponibles");
    return VisitaCivilList.fromJson(response);
  }
}
