class Oferta {
  int idoferta;
  int cupos;
  double precioofrecidokl;
  int idEstadooferta;
  int idTiporesiduo;
  String emailCentroAcopi;
  int numeroDeAplicantes;
  String estadoOferta;
  String tipoResiduo;

  Oferta(
      /*this.idoferta,
      this.cupos,
      this.precioofrecidokl,
      this.idEstadooferta,
      this.idTiporesiduo,
      this.emailCentroAcopi,
      this.numeroDeAplicantes,
      this.estadoOferta,
      this.tipoResiduo*/
      );

  Oferta.fromJson(Map<dynamic, dynamic> json) {
    this.idoferta = json['idoferta'];
    this.cupos = json['cupos'];
    this.precioofrecidokl = json['precioofrecidokl'];
    this.idEstadooferta = json['idestadooferta_Estadooferta'];
    this.idTiporesiduo = json['idtiporesiduo_Tiporesiduo'];
    this.emailCentroAcopi = json['email_Usuario'];
    this.numeroDeAplicantes = json['numeroDeAplicantes'];
    this.estadoOferta = json['estadoOferta'];
    this.tipoResiduo = json['tipoResiduo'];
  }

  Map<String, dynamic> toJson() {
    return {
      'idoferta': this.idoferta,
      'cupos': this.cupos,
      'precioofrecidokl': this.precioofrecidokl,
      'idestadooferta_Estadooferta': this.idEstadooferta,
      'idtiporesiduo_Tiporesiduo': this.idTiporesiduo,
      'email_Usuario': this.emailCentroAcopi,
      'numeroDeAplicantes': this.numeroDeAplicantes,
      'estadoOferta': this.estadoOferta,
      'tipoResiduo': this.tipoResiduo,
    };
  }
}
