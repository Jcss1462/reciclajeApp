import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Future obtenerToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get("token") ?? null;
  }

  Future setearToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString("token", token);
  }

  Future setearEmail(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("email: " + email + " guradado en preferencias");
    return preferences.setString("email", email);
  }

  Future obtenerEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get("email") ?? null;
  }

  Future setearTipo(int idTipoUsuario) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("tipo de usuario: " +
        idTipoUsuario.toString() +
        " guradado en preferencias");
    return preferences.setInt("idtipousuario", idTipoUsuario);
  }

  /*Future obtenerIdTipoResiduo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get("idTipoResiduo") ?? null;
  }*/

}
