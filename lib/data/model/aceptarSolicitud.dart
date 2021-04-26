class AceptarSolicitud {
  int idcarrodonacion;
  String emailReciclador;

  AceptarSolicitud(this.idcarrodonacion, this.emailReciclador);

  AceptarSolicitud.fromJson(Map<dynamic, dynamic> json) {
    this.idcarrodonacion = json['carroDonacionId'];
    this.emailReciclador = json['email'];
  }

  Map<String, dynamic> toJson() {
    return {
      'carroDonacionId': this.idcarrodonacion,
      'email': this.emailReciclador,
    };
  }
}
