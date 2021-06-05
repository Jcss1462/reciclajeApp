class VisitaCivil {
  String fechaHora;
  int idVisita;
  int idEstadoVisita;
  String emailPropietario;
  String emailRecolector;
  String direccion;
  String estado;

  VisitaCivil(this.fechaHora, this.idVisita, this.idEstadoVisita,
      this.emailPropietario, this.emailRecolector, this.direccion, this.estado);

  VisitaCivil.fromJson(Map<dynamic, dynamic> json) {
    this.fechaHora = json['fechahora'];
    this.idVisita = json['idvisita'];
    this.idEstadoVisita = json['idestadovisita_Estadovisita'];
    this.emailPropietario = json['emailPropietario'];
    this.emailRecolector = json['emailRecolector'];
    this.direccion = json['direccion'];
    this.estado = json['estado'];
  }

  Map<String, dynamic> toJson() {
    return {
      'fechahora': this.fechaHora,
      'idvisita': this.idVisita,
      'idestadovisita_Estadovisita': this.idEstadoVisita,
      'emailPropietario': this.emailPropietario,
      'emailRecolector': this.emailRecolector,
      'direccion': this.direccion,
      'estado': this.estado
    };
  }
}
