class AceptarVisita {
  int idVisita;

  AceptarVisita(this.idVisita);

  AceptarVisita.fromJson(Map<dynamic, dynamic> json) {
    this.idVisita = json['idVisita'];
  }

  Map<String, dynamic> toJson() {
    return {
      'idVisita': this.idVisita,
    };
  }
}
