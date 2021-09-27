class Ventas {
  String fechaventa;
  int idventa;
  double peso;
  double total;
  int idestadoventaEstadoventa;
  int idtiporesiduo;
  String emailUsuario;
  String tipo;
  double precioPorKiloTipo;
  String emailCentroAcopio;

  Ventas(
      this.fechaventa,
      this.idventa,
      this.peso,
      this.total,
      this.idestadoventaEstadoventa,
      this.idtiporesiduo,
      this.emailUsuario,
      this.precioPorKiloTipo);

  Ventas.fromJson(Map<dynamic, dynamic> json) {
    this.fechaventa = json['fechaventa'];
    this.idventa = json['idventa'];
    this.peso = json['peso'];
    this.total = json['total'];
    this.idestadoventaEstadoventa = json['idestadoventa_Estadoventa'];
    this.idtiporesiduo = json['idtiporesiduo_Tiporesiduo'];
    this.emailUsuario = json['email_Usuario'];
    this.tipo = json['tipo'];
    this.precioPorKiloTipo = json['precioPorKiloTipo'];
    this.emailCentroAcopio = json['emailCentroDeAcopio'];
  }

  Map<String, dynamic> toJson() {
    return {
      'fechaventa': this.fechaventa,
      'idventa': this.idventa,
      'peso': this.peso,
      'total': this.total,
      'idestadoventa_Estadoventa': this.idestadoventaEstadoventa,
      'idtiporesiduo_Tiporesiduo': this.idtiporesiduo,
      'email_Usuario': this.emailUsuario,
      'tipo': this.tipo,
      'precioPorKiloTipo': this.precioPorKiloTipo,
      'emailCentroDeAcopio': this.emailCentroAcopio
    };
  }
}
