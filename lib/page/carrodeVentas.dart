import 'package:flutter/material.dart';
import 'package:reciclaje_app/core/constants.dart';
import 'package:reciclaje_app/data/datasources/carroVenta_datasource.dart';
import 'package:reciclaje_app/data/model/ventaList.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/dialogBox.dart';
import 'package:reciclaje_app/widgets/navbar.dart';
import 'package:intl/intl.dart';

class CarroDeVentas extends StatefulWidget {
  const CarroDeVentas({Key key}) : super(key: key);

  @override
  _CarroDeVentasState createState() => _CarroDeVentasState();
}

class _CarroDeVentasState extends State<CarroDeVentas> {
  //variables de conexion
  Preferences preferencias = new Preferences();
  String _email;
  final formKey = GlobalKey<FormState>();
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  CarroVentasDataSourceImpl carroVentasDataSourceImpl =
      new CarroVentasDataSourceImpl();
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

  Future<VentasList> getListVentas() async {
    return await this.carroVentasDataSourceImpl.misVentas(_email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Bienvenido al Carro de Ventas",
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
                            future: getListVentas(),
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
                                                                5,
                                                            //tamaño minimo de altura
                                                            constraints:
                                                                BoxConstraints(
                                                              minWidth: 150,
                                                              minHeight: 160,
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
                                                                  Column(
                                                                    children: <
                                                                        Widget>[
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          IconButton(
                                                                              icon: Icon(
                                                                                Icons.edit_outlined,
                                                                                color: Color.fromRGBO(46, 99, 238, 1),
                                                                                size: 30,
                                                                              ),
                                                                              onPressed: () {
                                                                                showDialog(
                                                                                  context: context,
                                                                                  builder: (context) => AlertDialog(
                                                                                    title: Text(
                                                                                      "Estas seguro que desear editar la venta?",
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
                                                                                          print(ventas.ventas[index].idventa);
                                                                                          Navigator.pushNamed(context, pageEditar, arguments: ventas.ventas[index].idventa);
                                                                                        },
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                );
                                                                              }),
                                                                          //boton eliminar
                                                                          IconButton(
                                                                              icon: Icon(
                                                                                Icons.delete_outline,
                                                                                color: Color.fromRGBO(46, 99, 238, 1),
                                                                                size: 30,
                                                                              ),
                                                                              onPressed: () {
                                                                                showDialog(
                                                                                    context: context,
                                                                                    builder: (context) => AlertDialog(
                                                                                          title: Text(
                                                                                            "Estas seguro que deseas eliminar este residuo?",
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
                                                                                                print(ventas.ventas[index].idventa);
                                                                                                this.carroVentasDataSourceImpl.delVenta(ventas.ventas[index].idventa).then((value) {
                                                                                                  setState(() {});
                                                                                                });
                                                                                                //cierro la ventana
                                                                                                Navigator.pop(context);
                                                                                              },
                                                                                            ),
                                                                                          ],
                                                                                        ));
                                                                              }),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
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
