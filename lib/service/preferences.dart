import 'package:shared_preferences/shared_preferences.dart';

class Preferences {


  Future obtenerToken() async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    return preferences.get("token")??null;
  }

  Future setearToken(String token) async{
    SharedPreferences preferences =await SharedPreferences.getInstance();
    return preferences.setString("token",token);
  }
}

