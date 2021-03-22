class TipoResiduo {
  int idtipoResiduo;
  double precio;
  String tipo;

  TipoResiduo(this.idtipoResiduo, this.precio, this.tipo);

  TipoResiduo.fromJson(Map<dynamic, dynamic> json) {
    this.idtipoResiduo = json['idtipoResiduo'];
    this.precio = json['precio'];
    this.tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    return {
      'idtipoResiduo': this.idtipoResiduo,
      'precio': this.precio,
      'tipo': this.tipo
    };
  }
}
