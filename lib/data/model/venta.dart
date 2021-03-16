class Residuo {
  String name;
  int peso;
  int total;

  Residuo({this.name, this.peso, this.total});
}

class Ventas {
  String fechaventa;
  int idventa;
  double peso;
  double total;
  int idestadoventaEstadoventa;
  String emailUsuario;

  Ventas(this.fechaventa, this.idventa, this.peso, this.total, this.idestadoventaEstadoventa,
      this.emailUsuario);

  Ventas.fromJson(Map<dynamic, dynamic> json) {
    this.fechaventa = json['fechaventa'];
    this.idventa = json['idventa'];
    this.peso = json['peso'];
    this.total = json['total'];
    this.idestadoventaEstadoventa = json['idestadoventa_Estadoventa'];
    this.emailUsuario = json['email_Usuario'];
  }

  Map<String, dynamic> toJson() {
    return {
      'fechaventa': this.fechaventa,
      'idventa': this.idventa,
      'peso': this.peso,
      'total': this.total,
      'idestadoventa_Estadoventa': this.idestadoventaEstadoventa,
      'email_Usuario': this.emailUsuario
    };
  }

}
