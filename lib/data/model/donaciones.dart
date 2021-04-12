class Donaciones {
  int idDonacion;
  String emailPropietario;
  int idtiporesiduo;
  String tipo;

  Donaciones(
      this.idDonacion, this.idtiporesiduo, this.emailPropietario, this.tipo);

  Donaciones.fromJson(Map<dynamic, dynamic> json) {
    this.idDonacion = json['iddonacion'];
    this.idtiporesiduo = json['idtiporesiduo_Tiporesiduo'];
    this.emailPropietario = json['emailPropietario'];
    this.tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    return {
      'iddonacion': this.idDonacion,
      'idtiporesiduo_Tiporesiduo': this.idtiporesiduo,
      'emailPropietario': this.emailPropietario,
      'tipo': this.tipo,
    };
  }
}
