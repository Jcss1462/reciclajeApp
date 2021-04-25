import 'package:flutter/material.dart';
import 'package:reciclaje_app/data/datasources/carroDonacion_datasource.dart';
import 'package:reciclaje_app/data/model/donacionesList.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/navbarCiudadanoCivil.dart';

class ListaRecicladores extends StatefulWidget {
  ListaRecicladores({Key key}) : super(key: key);
  @override
  _ListaRecicladoresState createState() => _ListaRecicladoresState();
}

class _ListaRecicladoresState extends State<ListaRecicladores> {
  Preferences preferencias = new Preferences();
  String _email;
  CarroDonacionesDataSourceImpl carroDonacionDataSourceImpl =
      new CarroDonacionesDataSourceImpl();
  DonacionesList donaciones = new DonacionesList();

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

  Future<DonacionesList> getListDonaciones() async {
    return await this.carroDonacionDataSourceImpl.misDonaciones(_email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarCiudadanoCivil(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Lista de Recicladores",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
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
                        future: getListDonaciones(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return CircularProgressIndicator();
                            default:
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                this.donaciones = snapshot.data;
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
                                                .donaciones
                                                .donaciones
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
                                                      constraints:
                                                          BoxConstraints(
                                                        minWidth: 150,
                                                        minHeight: 150,
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
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Reciclador: ",
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
                                                                  "Alejandro Cosme",
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
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Tiempo Apoximado ",
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
                                                                  "10 min",
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
                                                            SizedBox(height: 15,),
                                                            Column(
                                                              children: <
                                                                  Widget>[
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    MaterialButton(
                                                                      height:
                                                                          40,
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
                                                                            context:
                                                                                context,
                                                                            builder: (context) =>
                                                                                AlertDialog(
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
                                                                                      onPressed: null,
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
                                                                                    onPressed: null,
                                                                                    ),
                                                                                  ],
                                                                                ));
                                                                      },
                                                                    ),
                                                                    SizedBox(width: 45,),
                                                                    MaterialButton(
                                                                      height:
                                                                          40,
                                                                      minWidth:
                                                                          50,
                                                                      color: Colors.red,
                                                                      textColor:
                                                                          Colors
                                                                              .white,
                                                                      child:
                                                                          new Text(
                                                                        "Cancelar",
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
                                                                                    "Cancelando Visita",
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
                                                                                      onPressed: null,
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
                                                                                    onPressed: null,
                                                                                    ),
                                                                                  ],
                                                                                ));
                                                                      },
                                                                    )
                                                                  ],
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
