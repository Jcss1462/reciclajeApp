class IdVista {
  int visitaId;

  IdVista(this.visitaId);

  IdVista.fromJson(Map<dynamic, dynamic> json) {
    this.visitaId = json['visitaId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'visitaId': this.visitaId,
    };
  }
}
