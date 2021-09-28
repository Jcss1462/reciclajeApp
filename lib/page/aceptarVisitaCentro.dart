import 'package:flutter/material.dart';
import 'package:reciclaje_app/data/datasources/visitasRecicladoresDataSource.dart';
import 'package:reciclaje_app/data/model/visitaRecicladorList.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/dialogBox.dart';
import 'package:reciclaje_app/widgets/navbar.dart';

class AceptarVisitaCentro extends StatefulWidget {
  final int idVenta;
  AceptarVisitaCentro(this.idVenta);
  @override
  _AceptarVisitaCentroState createState() => _AceptarVisitaCentroState();
}

class _AceptarVisitaCentroState extends State<AceptarVisitaCentro> {
  Preferences preferencias = new Preferences();
  String _email;
  int _idVenta;
  VisitasRecicladoresDataSourceImpl visitasRecicladoresDataSourceImpl =
      new VisitasRecicladoresDataSourceImpl();
  VisitaRecicladorList visitaRecicladorList = new VisitaRecicladorList();

  @override
  void initState() {
    super.initState();
    _idVenta = this.widget.idVenta;
  }

  Future<String> getEmail() async {
    return await preferencias.obtenerEmail().then((value) async {
      _email = value;
      return _email;
    });
  }

  Future<VisitaRecicladorList> getVisitasByVentas() async {
    return await this
        .visitasRecicladoresDataSourceImpl
        .visitasByVentas(_idVenta);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Lista de Ventas en Espera",
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
      body: new Stack(
        children: <Widget>[
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
                        future: getVisitasByVentas(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return CircularProgressIndicator();
                            default:
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                this.visitaRecicladorList = snapshot.data;
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: Center(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: this
                                                .visitaRecicladorList
                                                .visitaReciclador
                                                .length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
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
                                                              7,
                                                      constraints:
                                                          BoxConstraints(
                                                        minWidth: 160,
                                                        minHeight: 200,
                                                      ),
                                                      padding: EdgeInsets.only(
                                                          top: 20.0,
                                                          bottom: 20.0,
                                                          left: 20,
                                                          right: 20),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.25),
                                                              spreadRadius: 5,
                                                              offset:
                                                                  Offset(0, 3),
                                                            ),
                                                          ]),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: <Widget>[
                                                            SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "Centro: ",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
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
                                                                              .bold,
                                                                      fontSize:
                                                                          18,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    visitaRecicladorList
                                                                        .visitaReciclador[
                                                                            index]
                                                                        .emailCentroDeAcopio,
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
                                                                      fontSize:
                                                                          18,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  "Fecha: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
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
                                                                            .bold,
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  visitaRecicladorList
                                                                      .visitaReciclador[
                                                                          index]
                                                                      .fechaHora,
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
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Column(
                                                              children: <
                                                                  Widget>[
                                                                Center(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      MaterialButton(
                                                                        height:
                                                                            40,
                                                                        minWidth:
                                                                            50,
                                                                        color: Color.fromRGBO(
                                                                            46,
                                                                            99,
                                                                            238,
                                                                            1),
                                                                        textColor:
                                                                            Colors.white,
                                                                        child:
                                                                            new Text(
                                                                          "Aceptar",
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
                                                                              context: context,
                                                                              builder: (context) => AlertDialog(
                                                                                    title: Text(
                                                                                      "Aceptando Visita",
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
                                                                                          /*AceptarSolicitud aceptarSolicitud = new AceptarSolicitud(visitaRecicladorList.visitaReciclador[index].idcarroDonacion, solicitudes.solicituddeRecoleccion[index].emailReciclador);
                                                                                          this.recoleccionDonacionDataSourceImpl.aceptarSolicitud(aceptarSolicitud).then((value) {
                                                                                            showDialog(
                                                                                                context: context,
                                                                                                builder: (context) => AlertDialog(
                                                                                                      title: Text(
                                                                                                        "Solicitud Aceptada",
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
                                                                                                            Navigator.pushNamed(context, carrodeDonacionCivil);
                                                                                                            setState(() {});
                                                                                                          },
                                                                                                        ),
                                                                                                      ],
                                                                                                    ));
                                                                                          }).onError((error, stackTrace) {
                                                                                            showDialog(context: context, builder: (context) => DialogBox("Error al eliminar la visita", error.toString()));
                                                                                          });
                                                                                        */
                                                                                        },
                                                                                      ),
                                                                                    ],
                                                                                  ));
                                                                        },
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            45,
                                                                      ),
                                                                      MaterialButton(
                                                                        height:
                                                                            40,
                                                                        minWidth:
                                                                            50,
                                                                        color: Colors
                                                                            .red,
                                                                        textColor:
                                                                            Colors.white,
                                                                        child:
                                                                            new Text(
                                                                          "Rechazar",
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
                                                                          /*
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (context) => AlertDialog(
                                                                                    title: Text(
                                                                                      "Eliminando Visita",
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
                                                                                          this.recoleccionDonacionDataSourceImpl.eliminarSolicitud(solicitudes.solicituddeRecoleccion[index].idsolicitud).then((value) {
                                                                                            showDialog(
                                                                                                context: context,
                                                                                                builder: (context) => AlertDialog(
                                                                                                      title: Text(
                                                                                                        "Solicitud Eliminada",
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
                                                                                                            setState(() {});
                                                                                                          },
                                                                                                        ),
                                                                                                      ],
                                                                                                    ));
                                                                                          }).onError((error, stackTrace) {
                                                                                            showDialog(context: context, builder: (context) => DialogBox("Error al eliminar la visita", error.toString()));
                                                                                          });
                                                                                        },
                                                                                      ),
                                                                                    ],
                                                                                  ));
                                                                        */
                                                                        },
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            15,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                          }
                        },
                      );
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
