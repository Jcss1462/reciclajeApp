import 'package:flutter/material.dart';
import 'package:reciclaje_app/data/datasources/visitas_datasource.dart';
import 'package:reciclaje_app/data/model/agendar.dart';
import 'package:reciclaje_app/data/model/vistasCivilList.dart';
import 'package:reciclaje_app/page/visitaDisponibleProgramada.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/dialogBox.dart';
import 'package:reciclaje_app/widgets/navbar.dart';

class VisitaProgramadas extends StatefulWidget {
  const VisitaProgramadas({Key key}) : super(key: key);

  @override
  _VisitaProgramadasState createState() => _VisitaProgramadasState();
}

class _VisitaProgramadasState extends State<VisitaProgramadas> {
  Preferences preferencias = new Preferences();
  String _email;
  final formKey = GlobalKey<FormState>();
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

  Future<VisitaCivilList> getListMisVisitas() async {
    return await this
        .visitasDatasourceImpl
        .misVisitasAgendadasReciclador(_email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Visitas Programadas",
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
                        future: getListMisVisitas(),
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
                                                  .visitas
                                                  .length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
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
                                                            6,
                                                        constraints:
                                                            BoxConstraints(
                                                          minWidth: 150,
                                                          minHeight: 230,
                                                        ),
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 20.0,
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
                                                                    "Usuario",
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
                                                                        .visitas[
                                                                            index]
                                                                        .emailPropietario,
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
                                                                    "Fecha y Hora: ",
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
                                                                      solicitudes.visitas[index].fechaHora.substring(
                                                                              0,
                                                                              10) +
                                                                          "     " +
                                                                          solicitudes
                                                                              .visitas[index]
                                                                              .fechaHora
                                                                              .substring(11, 16),
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
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Direccion: ",
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
                                                                          .visitas[
                                                                              index]
                                                                          .direccion,
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
                                                                              Icons.delete_outline,
                                                                              color: Color.fromRGBO(46, 99, 238, 1),
                                                                              size: 30,
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
                                                                                            onPressed: () {
                                                                                              Agendar agenda = new Agendar(solicitudes.visitas[index].idVisita, _email);
                                                                                              visitasDatasourceImpl.cancelarVisitaReciclador(agenda).then((value) {
                                                                                                showDialog(
                                                                                                    context: context,
                                                                                                    builder: (context) => AlertDialog(
                                                                                                          title: Text(
                                                                                                            "Vista Cancelada",
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
                                                                            }),
                                                                      ],
                                                                    ),
                                                                  ])
                                                            ],
                                                          ),
                                                        )),
                                                  )
                                                ]);
                                              },
                                            ),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            MaterialButton(
                                              height: 50,
                                              minWidth: 250,
                                              color: Color.fromRGBO(
                                                  46, 99, 238, 1),
                                              textColor: Colors.white,
                                              child: new Text(
                                                "Visitas a Programar",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            VisitaDisponibleProgramada()));
                                              },
                                            )
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
