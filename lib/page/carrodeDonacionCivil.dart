import 'package:flutter/material.dart';
import 'package:reciclaje_app/core/constants.dart';
import 'package:reciclaje_app/data/datasources/carroDonacion_datasource.dart';
import 'package:reciclaje_app/data/model/donacionesList.dart';
import 'package:reciclaje_app/data/model/emailUsuario.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/dialogBox.dart';
import 'package:reciclaje_app/widgets/navbarCiudadanoCivil.dart';

class CarrodeDonacionCivil extends StatefulWidget {
  CarrodeDonacionCivil({Key key}) : super(key: key);
  @override
  _CarrodeDonacionCivilState createState() => _CarrodeDonacionCivilState();
}

class _CarrodeDonacionCivilState extends State<CarrodeDonacionCivil> {
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
          "Donaciones",
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
                                    SizedBox(
                                      height: 15,
                                    ),
                                    MaterialButton(
                                        height: 50,
                                        minWidth: 250,
                                        color: Color.fromRGBO(46, 99, 238, 1),
                                        textColor: Colors.white,
                                        child: new Text(
                                          "Crear Nuevo Carro",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 23,
                                          ),
                                        ),
                                        onPressed: () {
                                          EmailUsuario emailUsuario =
                                              new EmailUsuario(_email);
                                          carroDonacionDataSourceImpl
                                              .inabilitarCarroDeDonacion(
                                                  emailUsuario)
                                              .then((value) {
                                            setState(() {});
                                          })
                                                ..onError((error, stackTrace) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          DialogBox(
                                                              "Error al inabilitar carros",
                                                              error
                                                                  .toString()));
                                                });
                                        })
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
                                    this.donaciones = snapshot.data;
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
                                                            minHeight: 100,
                                                          ),
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 20.0,
                                                                  bottom: 20.0,
                                                                  left: 20,
                                                                  right: 20),
                                                          decoration: BoxDecoration(
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
                                                                          0.25),
                                                                  spreadRadius:
                                                                      5,
                                                                  offset:
                                                                      Offset(
                                                                          0, 3),
                                                                )
                                                              ]),
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
                                                                          TextAlign
                                                                              .left,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
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
                                                                      donaciones
                                                                          .donaciones[
                                                                              index]
                                                                          .tipo
                                                                          .toString(),
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
                                                                            18,
                                                                      ),
                                                                    )
                                                                  ],
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
                                                                                              print(donaciones.donaciones[index].idDonacion);
                                                                                              this.carroDonacionDataSourceImpl.delDonacion(donaciones.donaciones[index].idDonacion).then((value) {
                                                                                                setState(() {});
                                                                                              });
                                                                                              Navigator.pop(context);
                                                                                            },
                                                                                          ),
                                                                                        ],
                                                                                      ));
                                                                            }),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              this
                                                          .donaciones
                                                          .donaciones
                                                          .length ==
                                                      0
                                                  ? Text(
                                                      "No hay donaciones",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                    )
                                                  : MaterialButton(
                                                      height: 50,
                                                      minWidth: 250,
                                                      color: Color.fromRGBO(
                                                          46, 99, 238, 1),
                                                      textColor: Colors.white,
                                                      child: new Text(
                                                        "Solicitar Reciclador",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 23,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    AlertDialog(
                                                                      title:
                                                                          Text(
                                                                        "Solicitando reciclador",
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
                                                                              20,
                                                                        ),
                                                                      ),
                                                                      actions: <
                                                                          Widget>[
                                                                        TextButton(
                                                                          child:
                                                                              Text(
                                                                            'Cancelar',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color.fromRGBO(46, 99, 238, 1),
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 15,
                                                                            ),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                        ),
                                                                        TextButton(
                                                                          child:
                                                                              Text(
                                                                            'Contiunar',
                                                                            style:
                                                                                TextStyle(
                                                                              color: Color.fromRGBO(46, 99, 238, 1),
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 15,
                                                                            ),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.popAndPushNamed(context,
                                                                                listaRecicladores);
                                                                          },
                                                                        )
                                                                      ],
                                                                    ));
                                                      })
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
