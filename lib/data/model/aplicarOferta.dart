class AplicarOferta {
  int idaplicacion;
  int idOferta;
  String emailUsuario;

  AplicarOferta();

  AplicarOferta.fromJson(Map<dynamic, dynamic> json) {
    this.idaplicacion = json['idaplicacion'];
    this.idOferta = json['idoferta_Ofertas'];
    this.emailUsuario = json['email_Usuario'];
  }

  Map<String, dynamic> toJson() {
    return {
      'idoferta_Ofertas': this.idOferta,
      'email_Usuario': this.emailUsuario,
    };
  }
}
