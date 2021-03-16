class Token {

  String token;

  Token.fromJason(Map<dynamic, dynamic> json) {
    this.token = json['token'];
  }

}

class LoginBack {

  String username;
  String password;

  LoginBack(
    this.username,
    this.password,
  );

  Map<String, dynamic> toJson() {
    return {
      'username': this.username,
      'password': this.password,
    };
  }

}