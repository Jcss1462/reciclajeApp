import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reciclaje_app/core/constants.dart';
import 'package:reciclaje_app/data/datasources/login_datasource.dart';
import 'package:reciclaje_app/data/datasources/usuario_datasource.dart';
import 'package:reciclaje_app/data/model/login_back.dart';
import 'package:reciclaje_app/service/authentication_service.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/dialogBox.dart';

import '../core/constants.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  bool isLoad = false;
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
            height: MediaQuery.of(context).size.height / 1.48,
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
                                obscureText: true,
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
                            //activo la pantalla de carga
                            setState(() {
                              isLoad = true;
                            });
                            formKey.currentState.save();
                            debugPrint(this.email);
                            debugPrint(this.password);

                            //accedo por firebase
                            final model = context.read<AutenticationService>();
                            model
                                .singIn(
                                    email: this.email, password: this.password)
                                .then((value) {
                              if (value.user.emailVerified == false) {
                                setState(() {
                                  isLoad = false;
                                });
                                debugPrint("Debe confirmar cuenta");
                                showDialog(
                                  context: context,
                                  builder: (context) => DialogBox(
                                      "Cuenta no verificada",
                                      "Porfavor verifique su cuenta\ncon el enlace enviado a su correo"),
                                );
                              } else {
                                //si el login es exitoso, accedo al back para obtener el token
                                LoginDatasourceImpl loginDataSource =
                                    new LoginDatasourceImpl();
                                loginDataSource
                                    .loginBack(this.email, value.user.uid)
                                    .then((value) {
                                  //guardo el token y los datos importantes en las preferencias
                                  Token token = value;
                                  //debugPrint(token.token);
                                  Preferences preference = new Preferences();
                                  preference.setearToken(token.token);
                                  //guardo el email y el tipo de usuario
                                  UsuarioDatasourceImpl usuarioDatasource =
                                      new UsuarioDatasourceImpl();
                                  usuarioDatasource
                                      .findById(this.email)
                                      .then((value) {
                                    preference.setearEmail(value.email);
                                    preference.setearTipo(value.idtipousuario);

                                    //redirijo segun el tipo de usuario
                                    if (value.idtipousuario == 1) {
                                      setState(() {
                                        isLoad = false;
                                      });
                                      debugPrint(
                                          "Inicio secion un Reciclador Oficial");
                                      //redirijo a la pantalla inicial
                                      Navigator.pushNamed(
                                          context, inicioReciclador);
                                    } else if (value.idtipousuario == 2) {
                                      setState(() {
                                        isLoad = false;
                                      });
                                      debugPrint(
                                          "Inicio secion un Ciudadano Civil");
                                      Navigator.pushNamed(
                                          context, inicioCiudadanoCivil);
                                    } else if (value.idtipousuario == 3) {
                                      setState(() {
                                        isLoad = false;
                                      });
                                      debugPrint(
                                          "Inicio secion un Centro de Acopio");
                                      Navigator.pushNamed(
                                          context, inicioCentrodeAcopio);
                                    } else {
                                      setState(() {
                                        isLoad = false;
                                      });
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            DialogBox("No eres reciclador", ""),
                                      );
                                    }
                                  }).onError((error, stackTrace) {
                                    setState(() {
                                      isLoad = false;
                                    });
                                    showDialog(
                                      context: context,
                                      builder: (context) => DialogBox(
                                          "Problema guardando preferencias de usuarios",
                                          error),
                                    );
                                  });
                                }).onError((error, stackTrace) {
                                  setState(() {
                                    isLoad = false;
                                  });
                                  debugPrint("Problema obteniendo el token");
                                  showDialog(
                                    context: context,
                                    builder: (context) => DialogBox(
                                        "Problema obteniendo el token",
                                        this.email),
                                  );
                                });
                              }
                            }).onError((error, stackTrace) {
                              setState(() {
                                isLoad = false;
                              });
                              debugPrint("Error al iniciar seción");
                              showDialog(
                                context: context,
                                builder: (context) => DialogBox(
                                    "Error al iniciar seción",
                                    error.toString()),
                              );
                            });
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text("¿No estas resgistrado?"),
                      SizedBox(height: 5),
                      //boton a registro
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
                        onPressed: () =>
                            Navigator.pushNamed(context, registerRoute),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text("¿Olvidaste tu contraseña?"),
                      SizedBox(height: 5),
                      //boton a registro
                      MaterialButton(
                          height: 40,
                          minWidth: 220,
                          color: Colors.white,
                          textColor: Colors.white,
                          child: new Text(
                            "Recuperar contraseña",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color.fromRGBO(46, 99, 238, 1)),
                          ),
                          //valido y guardo
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text(
                                        "¿Desea recuperara su contraseña?",
                                        style: TextStyle(
                                          color: Color.fromRGBO(46, 99, 238, 1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text(
                                            'Ok',
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  46, 99, 238, 1),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pushNamed(
                                                context, recuperarContrasena);
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    )).onError((error, stackTrace) {
                              showDialog(
                                  context: context,
                                  builder: (context) => DialogBox(
                                      "Error al eliminar la visita",
                                      error.toString()));
                            });
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        // Loader
        Visibility(
          visible: isLoad,
          child: Positioned(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(200, 255, 255, 255),
                ),
                child: Center(child: CircularProgressIndicator())),
          ),
        ),
      ],
    ));
  }
}
