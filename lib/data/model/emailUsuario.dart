class EmailUsuario {
  String emailUsuario;

  EmailUsuario(this.emailUsuario);

  EmailUsuario.fromJson(Map<dynamic, dynamic> json) {
    this.emailUsuario = json['emailUsuario'];
  }

  Map<String, dynamic> toJson() {
    return {
      'emailUsuario': this.emailUsuario,
    };
  }
}
