import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reciclaje_app/data/datasources/usuario_datasource.dart';
import 'package:reciclaje_app/data/model/usuario.dart';
import 'package:reciclaje_app/service/authentication_service.dart';

//import 'package:reciclaje_app/page/index.dart';
import 'package:reciclaje_app/widgets/dialogBox.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({Key key}) : super(key: key);

  @override
  _RegitroState createState() => _RegitroState();
}

class _RegitroState extends State<RegistroPage> {
  final formKey = GlobalKey<FormState>();

  bool isLoad = false;

  String nombre;
  String apellido;
  String email;
  String password;
  String direccion;

  String usuario;
  int idUsuario = 0;

  List<CheckBoxModal> userList = [];

  @override
  void initState() {
    userList.add(CheckBoxModal(
        title: 'Ciudadano Consciente',
        id: 2,
        descripcion: 'Ciudadano que recicla en su hogar',
        value: false));
    userList.add(CheckBoxModal(
        title: 'Reciclador',
        id: 1,
        descripcion: 'Persona que trabaje por medio del reciclaje',
        value: false));
    userList.add(CheckBoxModal(
        title: 'Empresa',
        id: 3,
        descripcion: 'Empresa legalmente conformada',
        value: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          //Recuadro Blanco
          new Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.3,
              height: MediaQuery.of(context).size.height / 1.2,
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
                  //Formulario
                  child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    top: 30.0, bottom: 30.0, left: 40, right: 40),
                child: Column(
                  children: [
                    Text(
                      "Registro",
                      style: TextStyle(
                          color: Color.fromRGBO(46, 99, 238, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          //Campos
                          Container(
                            height: 50,
                            //Nombre
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Nombre",
                                contentPadding: EdgeInsets.all(11),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(46, 99, 238, 1),
                                    width: 0.5,
                                  ),
                                ),
                              ),

                              //Validacion
                              onSaved: (value) {
                                nombre = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "llenar el campo";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),

                          //Apellido
                          SizedBox(height: 15),
                          Container(
                            height: 50,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Apellido",
                                contentPadding: EdgeInsets.all(11),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(46, 99, 238, 1),
                                    width: 0.5,
                                  ),
                                ),
                              ),

                              //Validacion
                              onSaved: (value) {
                                apellido = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "llenar el campo";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),

                          //Email
                          SizedBox(height: 15),
                          Container(
                            height: 50,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Email",
                                contentPadding: EdgeInsets.all(11),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(46, 99, 238, 1),
                                    width: 0.5,
                                  ),
                                ),
                              ),

                              //validacion
                              onSaved: (value) {
                                email = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "llenar el campo";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),

                          //password
                          SizedBox(height: 15),
                          Container(
                            height: 50,
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Password",
                                contentPadding: EdgeInsets.all(11),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(46, 99, 238, 1),
                                    width: 0.5,
                                  ),
                                ),
                              ),

                              //validacion
                              onSaved: (value) {
                                password = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "llenar el campo";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),

                          //direccion
                          SizedBox(height: 15),
                          Container(
                            height: 50,
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Dirección",
                                contentPadding: EdgeInsets.all(11),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(46, 99, 238, 1),
                                    width: 0.5,
                                  ),
                                ),
                              ),

                              //validacion
                              onSaved: (value) {
                                direccion = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "llenar el campo";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          //Check Box
                          SizedBox(height: 15),
                          new Column(
                            children: [
                              Text(
                                "Tipo de Usuario",
                                style: TextStyle(
                                    color: Color.fromRGBO(46, 99, 238, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              ...userList
                                  .map(
                                    (item) => CheckboxListTile(
                                      title: Text(
                                        item.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      subtitle: Text(item.descripcion),
                                      value: item.value,
                                      onChanged: (val) {
                                        setState(() {
                                          userList.forEach((element) {
                                            element.value = false;
                                          });
                                          item.value = true;
                                          usuario = item.title;
                                          idUsuario = item.id;
                                        });
                                      },
                                    ),
                                  )
                                  .toList()
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    MaterialButton(
                      height: 50,
                      minWidth: 150,
                      color: Color.fromRGBO(46, 99, 238, 1),
                      textColor: Colors.white,
                      child: new Text(
                        "Registrar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                      //Registrar

                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          setState(() {
                            isLoad = true;
                          });

                          if (this.idUsuario != 0) {
                            formKey.currentState.save();
                            debugPrint(this.nombre);
                            debugPrint(this.apellido);
                            debugPrint(this.email);
                            debugPrint(this.password);
                            debugPrint(this.direccion);
                            debugPrint(this.usuario);
                            print(this.idUsuario);
                            //guardo en firebase
                            final model = context.read<AutenticationService>();

                            model
                                .singUp(
                                    email: this.email, password: this.password)
                                .then(
                                    //si el registro en firebase no falla, envia email de confirmacion
                                    (valRegfb) => model.sendEmailVerification()
                                            //si el envio del correo sale bien
                                            .then((valEmailVerf) {
                                          ////////////////////////////////////////////////////////////////////////////
                                          //operacion backend iniciada

                                          //obtengo el uid del usuario
                                          debugPrint(valRegfb.user.uid);
                                          //guardo en el backend
                                          Usuario newUser = new Usuario(
                                              this.email,
                                              this.direccion,
                                              this.apellido,
                                              this.nombre,
                                              true,
                                              valRegfb.user.uid,
                                              this.idUsuario);
                                          debugPrint(newUser.email);

                                          UsuarioDatasourceImpl dataSource =
                                              new UsuarioDatasourceImpl();

                                          dataSource
                                              .createUserHk(newUser)
                                              .then((value) {
                                            setState(() {
                                              isLoad = false;
                                            });
                                            showDialog(
                                              context: context,
                                              builder: (context) => DialogBox(
                                                  "Cuenta creada con exito",
                                                  "Te enviamos un email de verificacion"),
                                            );
                                          }).onError((error, stackTrace) {
                                            setState(() {
                                              isLoad = false;
                                            });
                                            showDialog(
                                              context: context,
                                              builder: (context) => DialogBox(
                                                  "Errro al crear cuenta en el backend",
                                                  "Error:" + error.toString()),
                                            );
                                          });
                                          //operacion backend terminada
                                          ////////////////////////////////////////////////////////////////////////////
                                        }).onError((error, stackTrace) {
                                          setState(() {
                                            isLoad = false;
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (context) => DialogBox(
                                                  "Error al enviar el email",
                                                  "Tu cuenta fue creada pero hubo problemas con el email de verificacion\n\nError:" +
                                                      error.error.toString()));
                                        }))
                                //si el registro en firebase falla
                                .onError((error, stackTrace) {
                              setState(() {
                                isLoad = false;
                              });
                              showDialog(
                                  context: context,
                                  builder: (context) => DialogBox(
                                      "Error al registrar en firebase",
                                      "Error:" + error.toString()));
                            });
                          } else {
                            setState(() {
                              isLoad = false;
                            });
                            showDialog(
                                context: context,
                                builder: (context) => DialogBox(
                                    "Tipo de usuario no seleccionado",
                                    "Porfavor seleccionar un tipo de usuario"));
                          }
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    )
                  ],
                ),
              )),
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
      ),
    );
  }
}

class CheckBoxModal {
  String title;
  int id;
  String descripcion;
  bool value;
  CheckBoxModal(
      {@required this.title,
      @required this.id,
      this.descripcion,
      this.value = false});
}
