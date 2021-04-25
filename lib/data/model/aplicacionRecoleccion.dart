class AplicacionRecoleccion {
  int idcarrodonacion;
  String emailReciclador;

  AplicacionRecoleccion(
      this.idcarrodonacion, this.emailReciclador);

  AplicacionRecoleccion.fromJson(Map<dynamic, dynamic> json) {
    this.idcarrodonacion = json['idcarrodonacion_Carrodonaciones'];
    this.emailReciclador  = json['emailReciclador'];
  }

  Map<String, dynamic> toJson() {
    return {
      'idcarrodonacion_Carrodonaciones': this.idcarrodonacion,
      'emailReciclador': this.emailReciclador,
    };
  }
}