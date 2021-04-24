import 'package:flutter/material.dart';
import 'package:reciclaje_app/data/datasources/carroVenta_datasource.dart';
import 'package:reciclaje_app/data/model/ventaList.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/navbar.dart';

class VisitaCiviles extends StatefulWidget {
  VisitaCiviles({Key key}) : super(key: key);
  @override
  _VisitaCivilesState createState() => _VisitaCivilesState();
}

class _VisitaCivilesState extends State<VisitaCiviles> {
  Preferences preferencias = new Preferences();
  String _email;
  final formKey = GlobalKey<FormState>();
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
                      future: getListVentas(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return CircularProgressIndicator();
                          default:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              this.ventas = snapshot.data;
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
                                          itemCount: this.ventas.ventas.length,
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
                                                      minHeight: 350,
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
                                                                "Luz Mary Cabal",
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
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Fecha: ",
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
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "28-04-2021",
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
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Hora: ",
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
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "14:00",
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
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "Carrera 22a oeste # 7-50",
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
                                                          Column(
                                                            children: <Widget>[
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .check_box_outlined,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            46,
                                                                            99,
                                                                            238,
                                                                            1),
                                                                    size: 30,
                                                                  ),
                                                                  IconButton(
                                                                    icon: Icon(
                                                                      Icons
                                                                          .delete_outlined,
                                                                      color: Color
                                                                          .fromRGBO(
                                                                              46,
                                                                              99,
                                                                              238,
                                                                              1),
                                                                      size: 30,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) =>
                                                                                AlertDialog(
                                                                          title:
                                                                              Text(
                                                                            "Estas seguro que deseas eliminar esta visita?",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color.fromRGBO(46, 99, 238, 1),
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 20,
                                                                            ),
                                                                          ),
                                                                          actions: <
                                                                              Widget>[
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
                                                                                onPressed: null),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(height: 15),
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
                                                            onPressed: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          AlertDialog(
                                                                            title:
                                                                                Text(
                                                                              "Visita Agendada",
                                                                              style: TextStyle(
                                                                                color: Color.fromRGBO(46, 99, 238, 1),
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 20,
                                                                              ),
                                                                            ),
                                                                            content:
                                                                                Text(
                                                                              "La visita se agendo exitosamente",
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
                                                                                onPressed: null,
                                                                              ),
                                                                              TextButton(
                                                                                  child: Text(
                                                                                "Agendar Más",
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
                                                                            ],
                                                                          ));
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
