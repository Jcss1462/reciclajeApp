import 'package:reciclaje_app/data/model/usuario.dart';

class UsuarioList {
  final List<Usuario> beneficios;

  UsuarioList({
    this.beneficios,
  });

  factory UsuarioList.fromJson(List<dynamic> parsedJson) {
    // ignore: deprecated_member_use
    List<Usuario> beneficios = new List<Usuario>();

    beneficios = parsedJson.map((i) => Usuario.fromJson(i)).toList();

    return new UsuarioList(
      beneficios: beneficios,
    );
  }
}
