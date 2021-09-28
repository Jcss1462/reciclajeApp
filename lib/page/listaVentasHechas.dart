import 'package:flutter/material.dart';
import 'package:reciclaje_app/data/datasources/visitasRecicladoresDataSource.dart';
import 'package:reciclaje_app/data/model/ventaList.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/dialogBox.dart';
import 'package:reciclaje_app/widgets/navbar.dart';

class ListaVentasHechas extends StatefulWidget {
  const ListaVentasHechas({Key key}) : super(key: key);

  @override
  _ListaVentasHechasState createState() => _ListaVentasHechasState();
}

class _ListaVentasHechasState extends State<ListaVentasHechas> {
  Preferences preferencias = new Preferences();
  String _email;
  VisitasRecicladoresDataSourceImpl visitasRecicladoresDataSourceImpl =
      new VisitasRecicladoresDataSourceImpl();
  VentasList ventasList = new VentasList();

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

  Future<VentasList> getListaVentaVendidas() async {
    return await this
        .visitasRecicladoresDataSourceImpl
        .getListaVentasVendidas(_email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Lista de Ventas Hechas",
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
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(snapshot.error.toString()),
                            SizedBox(
                              height: 15,
                            ),
                            MaterialButton(
                                height: 50,
                                minWidth: 250,
                                color: Color.fromRGBO(46, 99, 238, 1),
                                textColor: Colors.white,
                                child: new Text(
                                  "Volver no hay ofertas",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                  ),
                                ),
                                onPressed: () {})
                          ],
                        ),
                      );
                    } else {
                      return FutureBuilder(
                        future: getListaVentaVendidas(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return CircularProgressIndicator();
                            default:
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                this.ventasList = snapshot.data;
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
                                            itemCount:
                                                this.ventasList.ventas.length,
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
                                                        minWidth: 300,
                                                        minHeight: 120,
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
                                                              child: Row(
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
                                                                    ventasList.ventas[index].emailCentroAcopio ==
                                                                            null
                                                                        ? ""
                                                                        : ventasList
                                                                            .ventas[index]
                                                                            .emailCentroAcopio,
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
                                                              height: 5,
                                                            ),
                                                            SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              child: Row(
                                                                children: [
                                                                  Text(
                                                                    "Peso: ",
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
                                                                      fontSize:
                                                                          18,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    ventasList
                                                                        .ventas[
                                                                            index]
                                                                        .peso
                                                                        .toString(),
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
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Precio por Kg: ",
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
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  ventasList
                                                                      .ventas[
                                                                          index]
                                                                      .precioPorKiloTipo
                                                                      .toString(),
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
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
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
