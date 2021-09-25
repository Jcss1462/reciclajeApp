import 'package:flutter/material.dart';
import 'package:reciclaje_app/core/constants.dart';
import 'package:reciclaje_app/data/datasources/recoleccionDonacion_datasource.dart';
import 'package:reciclaje_app/data/model/carrodeDonacionList.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/dialogBox.dart';
import 'package:reciclaje_app/widgets/navbar.dart';

class ListaVentasSolicitadas extends StatefulWidget {
  const ListaVentasSolicitadas({Key key}) : super(key: key);
  @override
  _ListaVentasSolicitadasState createState() => _ListaVentasSolicitadasState();
}

class _ListaVentasSolicitadasState extends State<ListaVentasSolicitadas> {
  Preferences preferencias = new Preferences();
  String _email;
  final formKey = GlobalKey<FormState>();
  RecoleccionDonacionDataSourceImpl recoleccionDonacionDataSourceImpl =
      new RecoleccionDonacionDataSourceImpl();
  CarrodeDonacionList solicitudes = new CarrodeDonacionList();

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

  Future<CarrodeDonacionList> getListSolicitudesAgendadas() async {
    return await this
        .recoleccionDonacionDataSourceImpl
        .recicladorCarrosAsignados(_email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Ventas SolicitadasS",
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
            decoration: new BoxDecoration(
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
                        future: getListSolicitudesAgendadas(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
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
                                              itemCount: this
                                                  .solicitudes
                                                  .solicitudes
                                                  .length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    Card(
                                                      elevation: 5,
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            80,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            6,
                                                        constraints:
                                                            BoxConstraints(
                                                          minWidth: 150,
                                                          minHeight: 200,
                                                        ),
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 20.0,
                                                                bottom: 30.0,
                                                                left: 20,
                                                                right: 20),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Colors.white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.15),
                                                                spreadRadius: 5,
                                                                offset: Offset(
                                                                    0, 3),
                                                              ),
                                                            ]),
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: <Widget>[
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Centro",
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
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 2,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    solicitudes
                                                                        .solicitudes[
                                                                            index]
                                                                        .emailCivil,
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
                                                                          15,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Dirección: ",
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
                                                                          .solicitudes[
                                                                              index]
                                                                          .direccionRecoleccion,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color.fromRGBO(
                                                                            46,
                                                                            99,
                                                                            238,
                                                                            1),
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontSize:
                                                                            15,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 15),
                                                              MaterialButton(
                                                                  height: 50,
                                                                  minWidth: 250,
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
                                                                    "Ver Solicitud",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            25),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder: (context) =>
                                                                            AlertDialog(
                                                                              title: Text(
                                                                                "Vender Residuo",
                                                                                style: TextStyle(
                                                                                  color: Color.fromRGBO(46, 99, 238, 1),
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 20,
                                                                                ),
                                                                              ),
                                                                              content: Text(
                                                                                "Venta de Residuo Exitosamente",
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
                                                                                    showDialog(
                                                                                        context: context,
                                                                                        builder: (context) => AlertDialog(
                                                                                              title: Text(
                                                                                                "Venta de residuo",
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
                                                                                                    'Contiunar',
                                                                                                    style: TextStyle(
                                                                                                      color: Color.fromRGBO(46, 99, 238, 1),
                                                                                                      fontWeight: FontWeight.bold,
                                                                                                      fontSize: 15,
                                                                                                    ),
                                                                                                  ),
                                                                                                  onPressed: () {
                                                                                                    Navigator.popAndPushNamed(context, aceptarVisitaCentro);
                                                                                                  },
                                                                                                )
                                                                                              ],
                                                                                            ));
                                                                                  },
                                                                                ),
                                                                                TextButton(
                                                                                  child: Text(
                                                                                    "Vender Más",
                                                                                    style: TextStyle(
                                                                                      color: Color.fromRGBO(46, 99, 238, 1),
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontSize: 15,
                                                                                    ),
                                                                                  ),
                                                                                  onPressed: () {
                                                                                    MaterialPageRoute(builder: (context) => ListaVentasSolicitadas());
                                                                                  },
                                                                                )
                                                                              ],
                                                                            ));
                                                                  }),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
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
          )
        ],
      ),
    );
  }
}
