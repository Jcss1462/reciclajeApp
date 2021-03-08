import 'dart:convert';

import 'package:reciclaje_app/data/model/usuario.dart';
import 'package:reciclaje_app/data/network/api_provider.dart';


abstract class AsociadoDatasource {
  Future<Usuario> createUserHk(Usuario usuario);
}

class AsociadoDatasourceImpl implements AsociadoDatasource {
  ApiProvider _apiProvider = ApiProvider();
 
 @override
  Future<Usuario> createUserHk(Usuario usuario) async {
    
    String body= jsonEncode(usuario.toJson());
    final response = await _apiProvider.post("/api/v1/usuario/save", body);
    return Usuario.fromJason(response);
  }

}
