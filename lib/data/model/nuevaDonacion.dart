class NuevaDonacion {
  String emailUsuario;
  int idtiporesiduoTiporesiduo;

  NuevaDonacion(this.emailUsuario, this.idtiporesiduoTiporesiduo);

  NuevaDonacion.fromJson(Map<dynamic, dynamic> json) {
    this.emailUsuario = json['email_Usuario'];
    this.idtiporesiduoTiporesiduo = json['idtiporesiduo_Tiporesiduo'];
  }

  Map<String, dynamic> toJson() {
    return {
      'email_Usuario': this.emailUsuario,
      'idtiporesiduo_Tiporesiduo': this.idtiporesiduoTiporesiduo,
    };
  }
}
