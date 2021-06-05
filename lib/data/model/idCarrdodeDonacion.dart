class IdCarrodeDonacion {
  int carroId;

  IdCarrodeDonacion(this.carroId);

  IdCarrodeDonacion.fromJson(Map<dynamic, dynamic> json) {
    this.carroId = json['carroId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'carroId': this.carroId,
    };
  }
}
