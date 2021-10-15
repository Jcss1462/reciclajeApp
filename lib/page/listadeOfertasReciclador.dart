import 'package:flutter/material.dart';
import 'package:reciclaje_app/core/constants.dart';
import 'package:reciclaje_app/data/datasources/ofertas_datasource.dart';
import 'package:reciclaje_app/data/model/aplicarOferta.dart';
import 'package:reciclaje_app/data/model/ofertaList.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/dialogBox.dart';
import 'package:reciclaje_app/widgets/navbar.dart';

class ListaOfertasReciclador extends StatefulWidget {
  ListaOfertasReciclador({Key key}) : super(key: key);
  @override
  _ListaOfertasRecicladorState createState() => _ListaOfertasRecicladorState();
}

class _ListaOfertasRecicladorState extends State<ListaOfertasReciclador> {
  Preferences preferencias = new Preferences();
  String _email;
  OfertasDatasourceImpl ofertasDatasourceImpl = new OfertasDatasourceImpl();
  OfertaList ofertaList = new OfertaList();

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

  Future<OfertaList> getListOfertasbyReciclador() async {
    return await this
        .ofertasDatasourceImpl
        .getOfertasDisponiblesbyReciclador(_email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Lista de Ofertas",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.money_outlined, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, listaOfertasAplicadas);
              }),
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
                        future: getListOfertasbyReciclador(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              padding: EdgeInsets.only(
                                  top: 20.0, bottom: 20.0, left: 20, right: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(snapshot.error.toString()),
                                ],
                              ),
                            );
                          }
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return CircularProgressIndicator();
                            default:
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                this.ofertaList = snapshot.data;
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: Center(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          this.ofertaList.ofertas.length == 0
                                              ? Text(
                                                  "No hay ofertas disponibles",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                )
                                              : ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: this
                                                      .ofertaList
                                                      .ofertas
                                                      .length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
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
                                                                7,
                                                            constraints:
                                                                BoxConstraints(
                                                              minWidth: 150,
                                                              minHeight: 170,
                                                            ),
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 20.0,
                                                                    bottom: 5.0,
                                                                    left: 10,
                                                                    right: 20),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Colors
                                                                    .white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.25),
                                                                    spreadRadius:
                                                                        5,
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            3),
                                                                  ),
                                                                ]),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Row(
                                                                            children: [
                                                                              Text(
                                                                                "Tipo de Residuo: ",
                                                                                textAlign: TextAlign.left,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(
                                                                                  color: Color.fromRGBO(46, 99, 238, 1),
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 18,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                ofertaList.ofertas[index].tipoResiduo,
                                                                                textAlign: TextAlign.left,
                                                                                style: TextStyle(
                                                                                  color: Color.fromRGBO(46, 99, 238, 1),
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontSize: 18,
                                                                                ),
                                                                              ),
                                                                            ]),
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              "Precio por Kilo: ",
                                                                              textAlign: TextAlign.left,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(
                                                                                color: Color.fromRGBO(46, 99, 238, 1),
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 18,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              "\$",
                                                                              style: TextStyle(
                                                                                color: Color.fromRGBO(46, 99, 238, 1),
                                                                                fontWeight: FontWeight.normal,
                                                                                fontSize: 15,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              ofertaList.ofertas[index].precioofrecidokl.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                color: Color.fromRGBO(46, 99, 238, 1),
                                                                                fontWeight: FontWeight.normal,
                                                                                fontSize: 18,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              "Cupos: ",
                                                                              textAlign: TextAlign.left,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(
                                                                                color: Color.fromRGBO(46, 99, 238, 1),
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 18,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              ofertaList.ofertas[index].cupos.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                color: Color.fromRGBO(46, 99, 238, 1),
                                                                                fontWeight: FontWeight.normal,
                                                                                fontSize: 18,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              "/",
                                                                              style: TextStyle(
                                                                                color: Color.fromRGBO(46, 99, 238, 1),
                                                                                fontWeight: FontWeight.normal,
                                                                                fontSize: 15,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              ofertaList.ofertas[index].numeroDeAplicantes.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                color: Color.fromRGBO(46, 99, 238, 1),
                                                                                fontWeight: FontWeight.normal,
                                                                                fontSize: 18,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
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
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            MaterialButton(
                                                                              height: 40,
                                                                              minWidth: 50,
                                                                              color: Color.fromRGBO(46, 99, 238, 1),
                                                                              textColor: Colors.white,
                                                                              child: new Text(
                                                                                "Aceptar",
                                                                                style: TextStyle(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 18,
                                                                                ),
                                                                              ),
                                                                              onPressed: () {
                                                                                showDialog(
                                                                                    context: context,
                                                                                    builder: (context) => AlertDialog(
                                                                                          title: Text(
                                                                                            "Aceptando Oferta",
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
                                                                                                AplicarOferta aplicarOferta = new AplicarOferta();
                                                                                                aplicarOferta.emailUsuario = _email;
                                                                                                aplicarOferta.idOferta = ofertaList.ofertas[index].idoferta;
                                                                                                this.ofertasDatasourceImpl.aplicarOferta(aplicarOferta).then((value) {
                                                                                                  showDialog(
                                                                                                      context: context,
                                                                                                      builder: (context) => AlertDialog(
                                                                                                            title: Text(
                                                                                                              "Aplicación Realizada",
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
                                                                                                                  Navigator.pushNamed(context, listadeOfertasReciclador);
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
                                                                              },
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
