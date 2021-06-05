class Agendar {
  int idVisita;
  String emailReciclador;

  Agendar(this.idVisita, this.emailReciclador);

  Agendar.fromJson(Map<dynamic, dynamic> json) {
    this.idVisita = json['idVisita'];
    this.emailReciclador = json['emailReciclador'];
  }

  Map<String, dynamic> toJson() {
    return {
      'idVisita': this.idVisita,
      'emailReciclador': this.emailReciclador,
    };
  }
}
