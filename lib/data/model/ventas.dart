class Ventas {
  String fechaventa;
  int idventa;
  double peso;
  double total;
  int idestadoventaEstadoventa;
  String emailUsuario;
  String tipo;
  double precioPorKiloTipo;

  Ventas(this.fechaventa, this.idventa, this.peso, this.total,
      this.idestadoventaEstadoventa, this.emailUsuario, this.precioPorKiloTipo);

  Ventas.fromJson(Map<dynamic, dynamic> json) {
    this.fechaventa = json['fechaventa'];
    this.idventa = json['idventa'];
    this.peso = json['peso'];
    this.total = json['total'];
    this.idestadoventaEstadoventa = json['idestadoventa_Estadoventa'];
    this.emailUsuario = json['email_Usuario'];
    this.tipo = json['tipo'];
    this.precioPorKiloTipo = json['precioPorKiloTipo'];
  }

  Map<String, dynamic> toJson() {
    return {
      'fechaventa': this.fechaventa,
      'idventa': this.idventa,
      'peso': this.peso,
      'total': this.total,
      'idestadoventa_Estadoventa': this.idestadoventaEstadoventa,
      'email_Usuario': this.emailUsuario,
      'tipo': this.tipo,
      'precioPorKiloTipo': this.precioPorKiloTipo
    };
  }
}
