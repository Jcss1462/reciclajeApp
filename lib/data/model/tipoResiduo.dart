class TipoResiduo {
  int idtiporesiduo;
  double precio;
  String tipo;

  TipoResiduo(this.idtiporesiduo, this.precio, this.tipo);

  TipoResiduo.fromJson(Map<dynamic, dynamic> json) {
    this.idtiporesiduo = json['idtiporesiduo'];
    this.precio = json['precio'];
    this.tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    return {
      'idtiporesiduo': this.idtiporesiduo,
      'precio': this.precio,
      'tipo': this.tipo
    };
  }
}
