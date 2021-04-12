class Donaciones {
  int iddonacion;
  String emailUsuario;
  String tipo;

  Donaciones(this.iddonacion, this.emailUsuario);

  Donaciones.fromJson(Map<dynamic, dynamic> json) {
    this.emailUsuario = json['email_Usuario'];
    this.tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    return {'email_Usuario': this.emailUsuario, 'tipo': this.tipo};
  }
}
