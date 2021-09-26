class AplicanteOferta {
  int idaplicacion;
  int idOfertas;
  String emailUsuario;

  AplicanteOferta(this.idaplicacion, this.idOfertas, this.emailUsuario);

  AplicanteOferta.fromJson(Map<dynamic, dynamic> json) {
    this.idaplicacion = json['idaplicacion'];
    this.idOfertas = json['idoferta_Ofertas'];
    this.emailUsuario = json['email_Usuario'];
  }

  Map<String, dynamic> toJson() {
    return {
      'idaplicacion': this.idaplicacion,
      'idoferta_Ofertas': this.idOfertas,
      'email_Usuario': this.emailUsuario,
    };
  }
}
