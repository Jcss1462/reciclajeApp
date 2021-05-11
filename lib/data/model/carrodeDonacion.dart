class CarrodeDonacion {
  int idcarrodonacion;
  String emailCivil;
  int idestadodonacion;
  String emailRecolector;
  String direccionRecoleccion;

  CarrodeDonacion(
      this.idcarrodonacion, this.emailCivil, this.idestadodonacion, this.emailRecolector, this.direccionRecoleccion);

  CarrodeDonacion.fromJson(Map<dynamic, dynamic> json) {
    this.idcarrodonacion = json['idcarrodonacion'];
    this.emailCivil = json['email_Usuario'];
    this.idestadodonacion = json['idestadodonacion_Estadocarrodonacion'];
    this.emailRecolector = json['email_Recolector'];
    this.direccionRecoleccion = json['direccionRecoleccion'];
  }

  Map<String, dynamic> toJson() {
    return {
      'idcarrodonacion': this.idcarrodonacion,
      'email_Usuario': this.emailCivil,
      'destadodonacion_Estadocarrodonacion': this.idestadodonacion,
      'email_Recolector': this.emailRecolector,
      'direccionRecoleccion': this.direccionRecoleccion,
    };
  }
}