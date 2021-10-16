import 'package:flutter/material.dart';
import 'package:reciclaje_app/data/datasources/ofertas_datasource.dart';
import 'package:reciclaje_app/data/model/ofertaList.dart';
import 'package:reciclaje_app/page/solicitantesOfertas.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/dialogBox.dart';
import 'package:reciclaje_app/widgets/navbarCentrodeAcopio.dart';

class CarrodeOfertas extends StatefulWidget {
  const CarrodeOfertas({Key key}) : super(key: key);

  @override
  _CarrodeOfertasState createState() => _CarrodeOfertasState();
}

class _CarrodeOfertasState extends State<CarrodeOfertas> {
  Preferences preferencias = new Preferences();
  String _email;
  OfertasDatasourceImpl ofertasDatasourceImpl = new OfertasDatasourceImpl();
  OfertaList ofertas = new OfertaList();

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

  Future<OfertaList> getOfertas() async {
    return await this.ofertasDatasourceImpl.getMyOfertasCentrodeAcopio(_email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarCentrodeAcopio(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Carro de Ofertas",
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
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return FutureBuilder(
                          future: getOfertas(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                padding: EdgeInsets.only(
                                    top: 20.0,
                                    bottom: 20.0,
                                    left: 20,
                                    right: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(snapshot.error.toString()),
                                  ],
                                ),
                              );
                            } else {
                              switch (snapshot.connectionState) {
                                //mientras espera
                                case ConnectionState.waiting:
                                  return CircularProgressIndicator();
                                default:
                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    this.ofertas = snapshot.data;
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: Center(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              this.ofertas.ofertas.length == 0
                                                  ? Text(
                                                      "No has creado ofertas",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    )
                                                  : ListView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount: this
                                                          .ofertas
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
                                                                    90,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    7,
                                                                constraints:
                                                                    BoxConstraints(
                                                                  minWidth: 100,
                                                                  minHeight:
                                                                      160,
                                                                ),
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            20.0,
                                                                        bottom:
                                                                            20.0,
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: Colors
                                                                        .white,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(0.25),
                                                                        spreadRadius:
                                                                            5,
                                                                        offset: Offset(
                                                                            0,
                                                                            3),
                                                                      )
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
                                                                                  ofertas.ofertas[index].tipoResiduo.toString(),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    color: Color.fromRGBO(46, 99, 238, 1),
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontSize: 18,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            "Cantida de Cupos: ",
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color.fromRGBO(46, 99, 238, 1),
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 18,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            ofertas.ofertas[index].cupos.toString(),
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color.fromRGBO(46, 99, 238, 1),
                                                                              fontWeight: FontWeight.normal,
                                                                              fontSize: 18,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            "/",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color.fromRGBO(46, 99, 238, 1),
                                                                              fontWeight: FontWeight.normal,
                                                                              fontSize: 15,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            ofertas.ofertas[index].numeroDeAplicantes.toString(),
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color.fromRGBO(46, 99, 238, 1),
                                                                              fontWeight: FontWeight.normal,
                                                                              fontSize: 18,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        children: <
                                                                            Widget>[
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: [
                                                                              ofertas.ofertas[index].numeroDeAplicantes > 0
                                                                                  ? Text("")
                                                                                  : IconButton(
                                                                                      icon: Icon(
                                                                                        Icons.delete_outline,
                                                                                        color: Color.fromRGBO(46, 99, 238, 1),
                                                                                      ),
                                                                                      onPressed: () {
                                                                                        showDialog(
                                                                                            context: context,
                                                                                            builder: (context) => AlertDialog(
                                                                                                  title: Text(
                                                                                                    "Esta seguro que desas eliminar esta oferta?",
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
                                                                                                        print(ofertas.ofertas[index].idoferta);
                                                                                                        this.ofertasDatasourceImpl.eliminarOferta(ofertas.ofertas[index].idoferta).then((value) {
                                                                                                          setState(() {});
                                                                                                          Navigator.pop(context);
                                                                                                        }).onError((error, stackTrace) {
                                                                                                          showDialog(context: context, builder: (context) => DialogBox("Error al crear oferta", error.toString()));
                                                                                                        });
                                                                                                      },
                                                                                                    ),
                                                                                                  ],
                                                                                                ));
                                                                                      }),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      ofertas.ofertas[index].numeroDeAplicantes >
                                                                              0
                                                                          ? MaterialButton(
                                                                              height: 50,
                                                                              minWidth: 250,
                                                                              color: Color.fromRGBO(46, 99, 238, 1),
                                                                              textColor: Colors.white,
                                                                              child: new Text(
                                                                                "Ver Solicitantes",
                                                                                style: TextStyle(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 23,
                                                                                ),
                                                                              ),
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SolicitantesOfertas(ofertas.ofertas[index].idoferta)));
                                                                                });
                                                                              })
                                                                          : Text("")
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
                                    );
                                  }
                              }
                            }
                          });
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
