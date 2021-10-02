import 'package:flutter/material.dart';
import 'package:reciclaje_app/data/datasources/visitas_datasource.dart';
import 'package:reciclaje_app/data/model/agendar.dart';
import 'package:reciclaje_app/data/model/vistasCivilList.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/dialogBox.dart';
import 'package:reciclaje_app/widgets/navbar.dart';

class VisitaDisponibleProgramada extends StatefulWidget {
  const VisitaDisponibleProgramada({Key key}) : super(key: key);

  @override
  _VisitaDisponibleProgramadaState createState() =>
      _VisitaDisponibleProgramadaState();
}

class _VisitaDisponibleProgramadaState
    extends State<VisitaDisponibleProgramada> {
  Preferences preferencias = new Preferences();
  String _email;
  VisitasDatasourceImpl visitasDatasourceImpl = new VisitasDatasourceImpl();
  VisitaCivilList solicitudes = new VisitaCivilList();
  @override
  void initState() {
    super.initState();
  }

  Future<String> getEmail() async {
    return await preferencias.obtenerEmail().then((value) async {
      _email = value;
      return _email;
    });
  }

  Future<VisitaCivilList> getVisitasDisponiblesProgrmadas() async {
    return await this.visitasDatasourceImpl.visitasDisponibles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Visita Disponibles a Programar",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                            title: Text(
                              "Cerrar Sesión",
                              style: TextStyle(
                                color: Color.fromRGBO(46, 99, 238, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            content: Text(
                              "Esta seguro que desea cerrar la sesión",
                            ),
                            actions: <Widget>[
                              TextButton(
                                  child: Text(
                                    'Ok',
                                    style: TextStyle(
                                      color: Color.fromRGBO(46, 99, 238, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  onPressed: () {
                                    //eliminamos todas las preferencias y re dirigimos a Login
                                    Preferences preferences = new Preferences();
                                    preferences
                                        .eliminarPreferencias()
                                        .then((value) {
                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                    }).onError((error, stackTrace) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => DialogBox(
                                            "Error al cerrar sesión",
                                            error.toString()),
                                      );
                                    });
                                  }),
                              TextButton(
                                child: Text(
                                  "Cancelar",
                                  style: TextStyle(
                                    color: Color.fromRGBO(46, 99, 238, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ]));
              })
        ],
      ),
      body: new Stack(children: <Widget>[
        new Container(
          decoration: BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/fondo.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        new Center(
          child: FutureBuilder(
            future: getEmail(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return FutureBuilder(
                      future: getVisitasDisponiblesProgrmadas(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return CircularProgressIndicator();
                          default:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              this.solicitudes = snapshot.data;
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: Center(
                                    child: SingleChildScrollView(
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              this.solicitudes.visitas.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Column(children: [
                                              Card(
                                                elevation: 5,
                                                child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            80,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            5,
                                                    constraints: BoxConstraints(
                                                      minWidth: 150,
                                                      minHeight: 250,
                                                    ),
                                                    padding: EdgeInsets.only(
                                                        top: 20.0,
                                                        left: 20,
                                                        right: 20),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.15),
                                                          spreadRadius: 5,
                                                          offset: Offset(0, 3),
                                                        )
                                                      ],
                                                    ),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(children: <
                                                          Widget>[
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Usuario: ",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        46,
                                                                        99,
                                                                        238,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                solicitudes
                                                                    .visitas[
                                                                        index]
                                                                    .emailPropietario,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          46,
                                                                          99,
                                                                          238,
                                                                          1),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize: 18,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 6,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Fecha y Hora: ",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        46,
                                                                        99,
                                                                        238,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                solicitudes
                                                                        .visitas[
                                                                            index]
                                                                        .fechaHora
                                                                        .substring(
                                                                            0,
                                                                            10) +
                                                                    "     " +
                                                                    solicitudes
                                                                        .visitas[
                                                                            index]
                                                                        .fechaHora
                                                                        .substring(
                                                                            11,
                                                                            16),
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          46,
                                                                          99,
                                                                          238,
                                                                          1),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize: 18,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 6,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Dirección: ",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        46,
                                                                        99,
                                                                        238,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                solicitudes
                                                                    .visitas[
                                                                        index]
                                                                    .direccion,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          46,
                                                                          99,
                                                                          238,
                                                                          1),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize: 18,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Column(
                                                            children: <Widget>[
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  MaterialButton(
                                                                    height: 40,
                                                                    minWidth:
                                                                        50,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            46,
                                                                            99,
                                                                            238,
                                                                            1),
                                                                    textColor:
                                                                        Colors
                                                                            .white,
                                                                    child:
                                                                        new Text(
                                                                      "Agendar",
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            18,
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder: (context) =>
                                                                              AlertDialog(
                                                                                title: Text(
                                                                                  "Agendado Visita",
                                                                                  style: TextStyle(
                                                                                    color: Color.fromRGBO(46, 99, 238, 1),
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: 20,
                                                                                  ),
                                                                                ),
                                                                                actions: <Widget>[
                                                                                  TextButton(
                                                                                    child: Text(
                                                                                      'Cancelar',
                                                                                      style: TextStyle(
                                                                                        color: Color.fromRGBO(46, 99, 238, 1),
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 15,
                                                                                      ),
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      Navigator.pop(context);
                                                                                    },
                                                                                  ),
                                                                                  TextButton(
                                                                                    child: Text(
                                                                                      'Continuar',
                                                                                      style: TextStyle(
                                                                                        color: Color.fromRGBO(46, 99, 238, 1),
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 15,
                                                                                      ),
                                                                                    ),
                                                                                    onPressed: () {
                                                                                      Agendar agenda = new Agendar(solicitudes.visitas[index].idVisita, _email);
                                                                                      visitasDatasourceImpl.agendar(agenda).then((value) {
                                                                                        showDialog(
                                                                                          context: context,
                                                                                          builder: (context) => AlertDialog(
                                                                                              title: Text(
                                                                                                "Asignacion exitosa",
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
                                                                                                      color: Color.fromRGBO(46, 99, 238, 1),
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      fontSize: 15,
                                                                                                    ),
                                                                                                  ),
                                                                                                  onPressed: () {
                                                                                                    Navigator.pop(context);
                                                                                                    Navigator.pop(context);
                                                                                                  },
                                                                                                ),
                                                                                              ]),
                                                                                        ).then((value) {
                                                                                          setState(() {});
                                                                                        });
                                                                                      }).onError((error, stackTrace) {
                                                                                        showDialog(
                                                                                          context: context,
                                                                                          builder: (context) => DialogBox("Error al Asignar", error.toString()),
                                                                                        );
                                                                                      });
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              ));
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ]),
                                                      ]),
                                                    )),
                                              )
                                            ]);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                              );
                            }
                        }
                      },
                    );
                  }
              }
            },
          ),
        )
      ]),
    );
  }
}
