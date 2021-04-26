class SolicituddeRecoleccion {
  int idsolicitud;
  int idcarroDonacion;
  String emailReciclador;

  SolicituddeRecoleccion(
      this.idsolicitud, this.idcarroDonacion, this.emailReciclador);

  SolicituddeRecoleccion.fromJson(Map<dynamic, dynamic> json) {
    this.idsolicitud = json['idsolicitud'];
    this.idcarroDonacion = json['idcarrodonacion_Carrodonaciones'];
    this.emailReciclador = json['emailReciclador'];
  }

  Map<String, dynamic> toJson() {
    return {
      'idsolicitud': this.idsolicitud,
      'idcarrodonacion_Carrodonaciones': this.idcarroDonacion,
      'emailReciclador': this.emailReciclador
    };
  }
}
