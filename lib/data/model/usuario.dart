class Usuario {

  String email;
  String direccion;
  String apellido;
  String nombre;
  bool enable;
  String password;
  int idtipousuario;


  Usuario(
    this.email,
    this.direccion,
    this.apellido,
    this.nombre,
    this.enable,
    this.password,
    this.idtipousuario
  );

  Usuario.fromJason(Map<dynamic, dynamic> json) {
    this.email = json['email'];
    this.direccion = json['direccion'];
    this.apellido = json['apellido'];
    this.nombre = json['nombre'];
    this.enable = json['enable'];
    this.password = json['password'];
    this.idtipousuario = json['idtipousuario_Tipousuario'];
  }

  Map<String, dynamic> toJson() {
    return {
      'email': this.email,
      'direccion': this.direccion,
      'apellido': this.apellido,
      'nombre': this.nombre,
      'enable': this.enable,
      'password': this.password,
      'idtipousuario_Tipousuario': this.idtipousuario,
    };
  }
}

