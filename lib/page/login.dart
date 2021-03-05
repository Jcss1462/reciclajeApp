import 'package:flutter/material.dart';
import 'package:reciclaje_app/core/constants.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
      children: <Widget>[
        //imagen de fondo
        new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),

        //formulario
        new Center(
          //recuadro blanco contenedor
          child: Container(
            width: MediaQuery.of(context).size.width / 1.3,
            height: MediaQuery.of(context).size.height / 1.33,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: SingleChildScrollView(
                              child: Container(
                  decoration: BoxDecoration(
                      //color: Colors.black,
                      ),
                  padding: EdgeInsets.only(
                      top: 30.0, bottom: 30.0, left: 40, right: 40),
                  child: Column(
                    //contenido
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                            color: Color.fromRGBO(46, 99, 238, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 28),
                      ),
                      SizedBox(height: 35),
                      Form(
                        //paso el global key
                        key: formKey,
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  contentPadding: EdgeInsets.all(11),
                                  filled: true,
                                  fillColor: Color.fromRGBO(207, 207, 207, 0.4),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(46, 99, 238, 1),
                                        width: 0.5,
                                      )),
                                ),
                                onSaved: (value) {
                                  email = value;
                                },
                                //valido los datos
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Llene este campo";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 35),
                            Container(
                              height: 50,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Contraseña",
                                  contentPadding: EdgeInsets.all(11),
                                  filled: true,
                                  fillColor: Color.fromRGBO(207, 207, 207, 0.4),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      borderSide: BorderSide(
                                        color: Color.fromRGBO(46, 99, 238, 1),
                                        width: 0.5,
                                      )),
                                ),
                                onSaved: (value) {
                                  password = value;
                                },
                                //valido los datos
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Llene este campo";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      MaterialButton(
                        height: 50,
                        minWidth: 150,
                        color: Color.fromRGBO(46, 99, 238, 1),
                        textColor: Colors.white,
                        child: new Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        //logeo
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            debugPrint(this.email);
                            debugPrint(this.password);
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text("¿No estas resgistrado?"),
                      SizedBox(height: 5),
                      MaterialButton(
                        height: 40,
                        minWidth: 220,
                        color: Colors.white,
                        textColor: Colors.white,
                        child: new Text(
                          "Crear cuenta aqui",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color.fromRGBO(46, 99, 238, 1)),
                        ),
                        //valido y guardo
                        onPressed:  () => Navigator.pushNamed(context, registerRoute),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
