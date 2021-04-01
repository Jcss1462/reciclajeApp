import 'dart:convert';

import 'package:reciclaje_app/data/model/usuario.dart';
import 'package:reciclaje_app/data/model/usuarioList.dart';
import 'package:reciclaje_app/data/network/api_provider.dart';


abstract class UsuarioDatasource {
  Future<Usuario> createUserHk(Usuario usuario);
  Future<Usuario> findById(String email);
  Future<UsuarioList> findAll();
}

class UsuarioDatasourceImpl implements UsuarioDatasource {
  ApiProvider _apiProvider = ApiProvider();
 
 @override
  Future<Usuario> createUserHk(Usuario usuario) async {
    
    String body= jsonEncode(usuario.toJson());
    final response = await _apiProvider.post("/api/v1/usuario/save", body);
    return Usuario.fromJson(response);
  }

  @override
  Future<UsuarioList> findAll() async {
  
    final response = await _apiProvider.get("/api/v1/usuario/findAll");
    return UsuarioList.fromJson(response);
 
  }

  @override
  Future<Usuario> findById(String email) async {
  
    final response = await _apiProvider.get("/api/v1/usuario/findById/"+email);
    return Usuario.fromJson(response);
 
  }

}
