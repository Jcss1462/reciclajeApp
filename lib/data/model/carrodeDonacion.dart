class CarrodeDonacion {
  int idcarrodonacion;
  String emailCivil;
  int idestadodonacion;

  CarrodeDonacion(
      this.idcarrodonacion, this.emailCivil, this.idestadodonacion);

  CarrodeDonacion.fromJson(Map<dynamic, dynamic> json) {
    this.idcarrodonacion = json['idcarrodonacion'];
    this.emailCivil = json['email_Usuario'];
    this.idestadodonacion = json['destadodonacion_Estadocarrodonacion'];
  }

  Map<String, dynamic> toJson() {
    return {
      'idcarrodonacion': this.idcarrodonacion,
      'email_Usuario': this.emailCivil,
      'destadodonacion_Estadocarrodonacion': this.idestadodonacion,
    };
  }
}