class NuevaDonacion {
  String emailPropietario;
  int idtiporesiduo;

  NuevaDonacion(this.idtiporesiduo, this.emailPropietario);

  NuevaDonacion.fromJson(Map<dynamic, dynamic> json) {
    this.emailPropietario = json['emailPropietario'];
    this.idtiporesiduo = json['idtiporesiduo_Tiporesiduo'];
  }

  Map<String, dynamic> toJson() {
    return {
      'emailPropietario': this.emailPropietario,
      'idtiporesiduo_Tiporesiduo': this.idtiporesiduo
    };
  }
}
