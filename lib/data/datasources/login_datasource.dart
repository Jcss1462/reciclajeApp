import 'dart:convert';

import 'package:reciclaje_app/data/model/login_back.dart';
import 'package:reciclaje_app/data/network/api_provider.dart';


abstract class LoginDatasource {
  Future<Token> loginBack(String username, String password);
}

class LoginDatasourceImpl implements LoginDatasource {
  ApiProvider _apiProvider = ApiProvider();
 
 @override
  Future<Token> loginBack(String username, String password) async {

    print("password: "+password);

    LoginBack log=new LoginBack(username,password);
    String body= jsonEncode(log.toJson());
    final response = await _apiProvider.post("/login", body);
    return Token.fromJason(response);
  }

}
