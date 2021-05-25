import 'package:flutter/material.dart';
import 'package:reciclaje_app/data/datasources/recoleccionDonacion_datasource.dart';
import 'package:reciclaje_app/data/model/aplicacionRecoleccion.dart';
import 'package:reciclaje_app/data/model/carrodeDonacionList.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/dialogBox.dart';
import 'package:reciclaje_app/widgets/navbar.dart';

class VisitaCivilesDisponibles extends StatefulWidget {
  VisitaCivilesDisponibles({Key key}) : super(key: key);
  @override
  _VisitaCivilesDisponiblesState createState() =>
      _VisitaCivilesDisponiblesState();
}

class _VisitaCivilesDisponiblesState extends State<VisitaCivilesDisponibles> {
  Preferences preferencias = new Preferences();
  String _email;
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

  Future<CarrodeDonacionList> getListSolicitudes() async {
    return await this
        .recoleccionDonacionDataSourceImpl
        .carrosDisponiblesNoAplicados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Visita a Civiles",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
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
                      future: getListSolicitudes(),
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
                                                      minHeight: 230,
                                                    ),
                                                    padding: EdgeInsets.only(
                                                        top: 20.0,
                                                        bottom: 20.0,
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
                                                      child: Column(
                                                        children: <Widget>[
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
                                                                  fontSize: 18,
                                                                ),
                                                              ),
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
                                                                  fontSize: 18,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 6,
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
                                                                      .solicitudes[
                                                                          index]
                                                                      .direccionRecoleccion,
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
                                                          SizedBox(height: 25),
                                                          MaterialButton(
                                                            height: 50,
                                                            minWidth: 250,
                                                            color:
                                                                Color.fromRGBO(
                                                                    46,
                                                                    99,
                                                                    238,
                                                                    1),
                                                            textColor:
                                                                Colors.white,
                                                            child: new Text(
                                                              "Agendar Visita",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 25),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              print(
                                                                  "email solicitante: " +
                                                                      _email);
                                                              print("carrito de donacion: " +
                                                                  solicitudes
                                                                      .solicitudes[
                                                                          index]
                                                                      .idcarrodonacion
                                                                      .toString());

                                                              AplicacionRecoleccion
                                                                  aplicacionRecoleccion =
                                                                  new AplicacionRecoleccion(
                                                                      solicitudes
                                                                          .solicitudes[
                                                                              index]
                                                                          .idcarrodonacion
                                                                          .toInt(),
                                                                      _email);
                                                              this
                                                                  .recoleccionDonacionDataSourceImpl
                                                                  .aplicacionaRecolectar(
                                                                      aplicacionRecoleccion)
                                                                  .then(
                                                                      (value) {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (context) =>
                                                                      DialogBox(
                                                                          "Aplicación exitosa",
                                                                          "Esperar la aceptación del usuario civil"),
                                                                ).then((value) {
                                                                  setState(
                                                                      () {});
                                                                });
                                                              }).onError((error,
                                                                      stackTrace) {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder: (context) =>
                                                                      DialogBox(
                                                                          "Error al Aplicar",
                                                                          error
                                                                              .toString()),
                                                                );
                                                              });
                                                            },
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
