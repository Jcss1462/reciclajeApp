class NuevaVenta {

  double peso;
  double total;
  String emailUsuario;
  int idtiporesiduoTiporesiduo;

  NuevaVenta(this.peso, this.total, this.emailUsuario, this.idtiporesiduoTiporesiduo);

  NuevaVenta.fromJson(Map<dynamic, dynamic> json) {
    this.peso = json['peso'];
    this.total = json['total'];
    this.emailUsuario = json['email_Usuario'];
    this.idtiporesiduoTiporesiduo = json['idtiporesiduo_Tiporesiduo'];
  }

  Map<String, dynamic> toJson() {
    return {
      'peso': this.peso,
      'total': this.total,
      'email_Usuario': this.emailUsuario,
      'idtiporesiduo_Tiporesiduo': this.idtiporesiduoTiporesiduo,
    };
  }
}
