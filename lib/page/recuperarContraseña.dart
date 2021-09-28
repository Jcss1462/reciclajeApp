import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reciclaje_app/service/authentication_service.dart';
import 'package:reciclaje_app/widgets/dialogBox.dart';

class RecuperarContrasena extends StatefulWidget {
  const RecuperarContrasena({Key key}) : super(key: key);

  @override
  _RecuperarContrasenaState createState() => _RecuperarContrasenaState();
}

class _RecuperarContrasenaState extends State<RecuperarContrasena> {
  //variables de conexion
  final formKey = GlobalKey<FormState>();
  bool isLoad = false;
  String correoRecuperacion;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Recuperar Contraseña",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/fondo.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.15,
              height: MediaQuery.of(context).size.height / 2.3,
              constraints: BoxConstraints(
                minWidth: 160,
                minHeight: 160,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
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
                //Formulario
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                      top: 5.0, bottom: 30.0, left: 40, right: 40),
                  child: Column(
                    children: [
                      Text(
                        "Recuperar Contraseña",
                        style: TextStyle(
                          color: Color.fromRGBO(46, 99, 238, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 27,
                        ),
                      ),
                      SizedBox(height: 50),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            //Cantidad del residuo
                            new Container(
                              child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: "Ingrese su correo electrónico",
                                      contentPadding: EdgeInsets.all(11),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(46, 99, 238, 1),
                                            width: 0.5,
                                          ))),

                                  //Validacion
                                  onSaved: (value) {
                                    correoRecuperacion = value;
                                  },
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "LLenar el campo";
                                    } else {
                                      return null;
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50),
                      MaterialButton(
                          height: 50,
                          minWidth: 150,
                          color: Color.fromRGBO(46, 99, 238, 1),
                          textColor: Colors.white,
                          child: new Text(
                            "Recuperar Contraseña",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () async {
                            if (formKey.currentState.validate()) {
                              //activo la pantalla de carga
                              setState(() {
                                isLoad = true;
                              });
                              formKey.currentState.save();
                              debugPrint(this.correoRecuperacion);

                              //accedo por firebase
                              final model =
                                  context.read<AutenticationService>();

                              model
                                  .restablecerPassword(
                                      email: this.correoRecuperacion)
                                  .then((value) {
                                setState(() {
                                  isLoad = false;
                                });
                                showDialog(
                                  context: context,
                                  builder: (context) => DialogBox(
                                      "Correo de recuperación enviado",
                                      "Se ha enviado un mail de recuperacion de contraseña a su cuenta de correo electrónico"),
                                );
                              }).onError((error, stackTrace) {
                                setState(() {
                                  isLoad = false;
                                });
                                debugPrint(
                                    "Error al enviar correo de recuperación");
                                showDialog(
                                  context: context,
                                  builder: (context) => DialogBox(
                                      "Error al enviar correo de recuperación",
                                      error.toString()),
                                );
                              });
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
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
          )
        ],
      ),
    );
  }
}
