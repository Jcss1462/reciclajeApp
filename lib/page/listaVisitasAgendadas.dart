import 'package:flutter/material.dart';
import 'package:reciclaje_app/data/datasources/visitas_datasource.dart';
import 'package:reciclaje_app/data/model/vistasCivilList.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/navbarCiudadanoCivil.dart';

class ListaVistasAgendadas extends StatefulWidget {
  const ListaVistasAgendadas({Key key}) : super(key: key);

  @override
  _ListaVistasAgendadasState createState() => _ListaVistasAgendadasState();
}

class _ListaVistasAgendadasState extends State<ListaVistasAgendadas> {
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

  Future<VisitaCivilList> getMisVisitasActivas() async {
    return await this.visitasDatasourceImpl.misVisitasActivasCivil(_email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarCiudadanoCivil(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Lista de Visitas Agendadas",
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
                        future: getMisVisitasActivas(),
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
                                                              child: Row(
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
                                                                    solicitudes.visitas[index].emailRecolector ==
                                                                            null
                                                                        ? ""
                                                                        : solicitudes
                                                                            .visitas[index]
                                                                            .emailRecolector,
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
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Fecha y Hora: ",
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
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Estado: ",
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
                                                                  solicitudes
                                                                      .visitas[
                                                                          index]
                                                                      .estado,
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
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Column(
                                                              children: <
                                                                  Widget>[
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .check_circle_outline,
                                                                          color: Color.fromRGBO(
                                                                              46,
                                                                              99,
                                                                              238,
                                                                              1),
                                                                          size:
                                                                              30,
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (context) => AlertDialog(
                                                                                    title: Text(
                                                                                      "Esta seguro que desas eliminar este residuo?",
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
                                                                                        onPressed: null,
                                                                                      ),
                                                                                    ],
                                                                                  ));
                                                                        }),
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .person_add_alt_1_outlined,
                                                                          color: Color.fromRGBO(
                                                                              46,
                                                                              99,
                                                                              238,
                                                                              1),
                                                                          size:
                                                                              30,
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (context) => AlertDialog(
                                                                                    title: Text(
                                                                                      "Esta seguro que desas eliminar este residuo?",
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
                                                                                        onPressed: null,
                                                                                      ),
                                                                                    ],
                                                                                  ));
                                                                        }),
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .delete_outline,
                                                                          color: Color.fromRGBO(
                                                                              46,
                                                                              99,
                                                                              238,
                                                                              1),
                                                                          size:
                                                                              30,
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          showDialog(
                                                                              context: context,
                                                                              builder: (context) => AlertDialog(
                                                                                    title: Text(
                                                                                      "Esta seguro que desas eliminar este residuo?",
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
                                                                                        onPressed: null,
                                                                                      ),
                                                                                    ],
                                                                                  ));
                                                                        })
                                                                  ],
                                                                )
                                                              ],
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
