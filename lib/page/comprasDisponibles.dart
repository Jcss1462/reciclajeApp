import 'package:flutter/material.dart';
import 'package:reciclaje_app/core/constants.dart';
import 'package:reciclaje_app/data/datasources/visitasRecicladoresDataSource.dart';
import 'package:reciclaje_app/data/model/ventaList.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/dialogBox.dart';
import 'package:intl/intl.dart';
import 'package:reciclaje_app/widgets/navbarCentrodeAcopio.dart';

class ComprasDisponibles extends StatefulWidget {
  const ComprasDisponibles({Key key}) : super(key: key);

  @override
  _ComprasDisponiblesState createState() => _ComprasDisponiblesState();
}

class _ComprasDisponiblesState extends State<ComprasDisponibles> {
  //variables de conexion
  Preferences preferencias = new Preferences();
  String _email;
  final formKey = GlobalKey<FormState>();
  final oCcy = new NumberFormat("#,##0.00", "en_US");

  VisitasRecicladoresDataSourceImpl visitasRecicladoresDataSourceImpl =
      new VisitasRecicladoresDataSourceImpl();
  VentasList ventas = new VentasList();
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

  Future<VentasList> getVentasDisponiblesporCentrodeAcopio() async {
    return await this
        .visitasRecicladoresDataSourceImpl
        .ventasDisponiblesporCentrodeAcopio(_email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarCentrodeAcopio(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Carro de Compras",
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
          //imagen de fondo
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
                    //mientras espera
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    default:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return FutureBuilder(
                            future: getVentasDisponiblesporCentrodeAcopio(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              switch (snapshot.connectionState) {
                                //mientras espera
                                case ConnectionState.waiting:
                                  return CircularProgressIndicator();
                                default:
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    this.ventas = snapshot.data;
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
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
                                                        .ventas
                                                        .ventas
                                                        .length,
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Column(children: [
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
                                                                4.5,
                                                            //tamaño minimo de altura
                                                            constraints:
                                                                BoxConstraints(
                                                              minWidth: 150,
                                                              minHeight: 150,
                                                            ),
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 20.0,
                                                                    bottom:
                                                                        20.0,
                                                                    left: 20,
                                                                    right: 20),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Colors.white,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.15),
                                                                  spreadRadius:
                                                                      5,
                                                                  offset:
                                                                      Offset(
                                                                          0, 3),
                                                                ),
                                                              ],
                                                            ),
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "Tipo de Residuo: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            TextStyle(
                                                                          color: Color.fromRGBO(
                                                                              46,
                                                                              99,
                                                                              238,
                                                                              1),
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              18,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        ventas
                                                                            .ventas[index]
                                                                            .tipo
                                                                            .toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
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
                                                                              18,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          5),
                                                                  SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          "Peso en Kilogramos: ",
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style:
                                                                              TextStyle(
                                                                            color: Color.fromRGBO(
                                                                                46,
                                                                                99,
                                                                                238,
                                                                                1),
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                18,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          ventas.ventas[index].peso.toString() +
                                                                              " \Kg ",
                                                                          textAlign:
                                                                              TextAlign.left,
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
                                                                      height:
                                                                          5),
                                                                  SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          "Total del Residuo: ",
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style:
                                                                              TextStyle(
                                                                            color: Color.fromRGBO(
                                                                                46,
                                                                                99,
                                                                                238,
                                                                                1),
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                18,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          "\$" +
                                                                              oCcy.format(ventas.ventas[index].total),
                                                                          textAlign:
                                                                              TextAlign.left,
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
                                                                      height:
                                                                          15),
                                                                  MaterialButton(
                                                                      height:
                                                                          50,
                                                                      minWidth:
                                                                          250,
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
                                                                        "Comprar",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 25),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder: (context) =>
                                                                                AlertDialog(
                                                                                  title: Text(
                                                                                    "Comprar Residuo",
                                                                                    style: TextStyle(
                                                                                      color: Color.fromRGBO(46, 99, 238, 1),
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontSize: 20,
                                                                                    ),
                                                                                  ),
                                                                                  content: Text(
                                                                                    "Compra de Residuo Exitosamente",
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
                                                                                                    "Compra de residuo",
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
                                                                                                        Navigator.pushNamed(context, agendaCompraCentrodeAcopio, arguments: ventas.ventas[index].idventa);
                                                                                                      },
                                                                                                    )
                                                                                                  ],
                                                                                                ));
                                                                                      },
                                                                                    ),
                                                                                    TextButton(
                                                                                      child: Text(
                                                                                        "Comprar Más",
                                                                                        style: TextStyle(
                                                                                          color: Color.fromRGBO(46, 99, 238, 1),
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontSize: 15,
                                                                                        ),
                                                                                      ),
                                                                                      onPressed: () {
                                                                                        MaterialPageRoute(builder: (context) => ComprasDisponibles());
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
                                                      ]);
                                                    })
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                              }
                            });
                      }
                  }
                }),
          ),
        ],
      ),
    );
  }
}
