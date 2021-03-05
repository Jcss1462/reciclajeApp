import 'package:flutter/material.dart';

import  'package:reciclaje_app/page/index.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({Key key}) : super(key: key);

  @override
  _RegitroState createState() => _RegitroState();
}

class _RegitroState extends State<RegistroPage> {
  final formKey = GlobalKey<FormState>();

  String nombre;
  String apellido;
  String email;
  String password;
  String direccion;

  String usuario;

  final allChecked = CheckBoxModal(title: "Al checked");
  final checkBoxList = [
    CheckBoxModal(
        title: 'Civil: ',
        descripcion:
            'Solicita que uno de nuestro Recicaldores recoja tus residuos reciclables.'),
    CheckBoxModal(
        title: 'Reciclador:',
        descripcion:
            'Obten Ingresos recogiendo residuos reciclables a travez de la ciudad y vendiendolos a empresas verdes.'),
    CheckBoxModal(
        title: 'Empresa: ',
        descripcion:
            'Usa esta app para programar y gestionar la recolección de los residuos reciclables que necesites para tu producción.')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(
                    "assets/images/background.png"),
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
                          color: Color.fromRGBO(46, 99, 238, 1), fontSize: 28),
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
                                    fontSize: 20),
                              ),
                              ...checkBoxList
                                  .map(
                                    (item) => CheckboxListTile(
                                      title: Text(item.title),
                                      value: item.value,
                                      onChanged: (val) {
                                        setState(() {
                                          item.value = val;
                                          if (val == true) {
                                            usuario = item.title;
                                          }
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
                        style: TextStyle(fontSize: 20),
                      ),

                      //Registrar

                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          debugPrint(this.nombre);
                          debugPrint(this.apellido);
                          debugPrint(this.email);
                          debugPrint(this.password);
                          debugPrint(this.direccion);
                          debugPrint(this.usuario);
                        }
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Usuario Registrado"),
                            content:
                                Text("El Usuario fue Registrado Correctamenta"),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Ok'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                              ),
                            ],
                          ),
                        );
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
        ],
      ),
    );
  }
}

class CheckBoxModal {
  String title;
  String descripcion;
  bool value;
  CheckBoxModal({@required this.title, this.descripcion, this.value = false});
}
