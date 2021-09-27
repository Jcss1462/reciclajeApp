class VisitaReciclador {
  int idvisitareciclador;
  int idestadovisita;
  String emailCentroDeAcopio;
  int idventa;
  String fechaHora;

  VisitaReciclador();

  VisitaReciclador.fromJson(Map<dynamic, dynamic> json) {
    this.idvisitareciclador = json['idvisitareciclador'];
    this.idestadovisita = json['idestadovisita_Estadovisita'];
    this.emailCentroDeAcopio = json['emailCentroDeAcopio'];
    this.idventa = json['idventa_Venta'];
    this.fechaHora = json['fechahora'];
  }

  Map<String, dynamic> toJson() {
    return {
      'idvisitareciclador': this.idvisitareciclador,
      'idestadovisita_Estadovisita': this.idestadovisita,
      'emailCentroDeAcopio': this.emailCentroDeAcopio,
      'idventa_Venta': this.idventa,
      'fechahora': this.fechaHora,
    };
  }
}
