import 'package:flutter/material.dart';
import 'package:reciclaje_app/data/datasources/carroDonacion_datasource.dart';
import 'package:reciclaje_app/data/model/nuevaDonacion.dart';
import 'package:reciclaje_app/page/carrodeDonacionCivil.dart';
import 'package:reciclaje_app/widgets/navbarCiudadanoCivil.dart';

import '../data/datasources/carroVenta_datasource.dart';
import '../data/model/tipoResiduo.dart';
import '../data/model/tipoResiduoList.dart';
import '../service/preferences.dart';
import '../widgets/dialogBox.dart';

class DonacionFormCivil extends StatefulWidget {
  DonacionFormCivil({Key key}) : super(key: key);

  @override
  _DonacionFormCivilState createState() => _DonacionFormCivilState();
}

class _DonacionFormCivilState extends State<DonacionFormCivil> {
  Preferences preferencias = new Preferences();
  String _email;

  final formKey = GlobalKey<FormState>();

  CarroVentasDataSourceImpl carroVentasDataSourceImpl =
      new CarroVentasDataSourceImpl();

  CarroDonacionesDataSourceImpl carroDonacionesDataSourceImpl =
      new CarroDonacionesDataSourceImpl();

  List<DropdownMenuItem<TipoResiduo>> dropListaresiduo;
  TipoResiduo selectResiduo;

  List<DropdownMenuItem<TipoResiduo>> getResiduo(
      TipoResiduoList listaresiduos) {
    List<DropdownMenuItem<TipoResiduo>> items = [];
    for (TipoResiduo listResiduo in listaresiduos.tipoResiduos) {
      items.add(DropdownMenuItem(
        child: Text(
          listResiduo.tipo,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 15,
          ),
        ),
        value: listResiduo,
      ));
    }

    return items;
  }

  Future<String> getEmail() async {
    return await preferencias.obtenerEmail().then((value) async {
      _email = value;
      return _email;
    });
  }

  Future<TipoResiduoList> listadeResiduos;
  Future<TipoResiduoList> getListObtenerTipoResiduo() async {
    return await this.carroVentasDataSourceImpl.obtenerTiposResiduos();
  }

  @override
  void initState() {
    listadeResiduos = getListObtenerTipoResiduo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarCiudadanoCivil(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Donar Residuo",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.inbox_rounded, color: Colors.white),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CarrodeDonacionCivil()));
            },
          ),
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
                image: new AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          FutureBuilder(
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
                      return Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.15,
                          height: MediaQuery.of(context).size.height / 0.5,
                          constraints: BoxConstraints(
                            minWidth: 250,
                            maxHeight: 250,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.25),
                                  spreadRadius: 5,
                                  offset: Offset(0, 3),
                                )
                              ]),
                          child: Center(
                            child: Center(
                              child: SingleChildScrollView(
                                padding: EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 10.0,
                                    left: 40,
                                    right: 40),
                                child: Column(
                                  children: [
                                    Text(
                                      "Formulario de Donacion",
                                      style: TextStyle(
                                          color: Color.fromRGBO(46, 99, 238, 1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 23),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Form(
                                      key: formKey,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 70,
                                            child: FutureBuilder(
                                              future: listadeResiduos,
                                              builder: (BuildContext context,
                                                  AsyncSnapshot snapshot) {
                                                switch (
                                                    snapshot.connectionState) {
                                                  case ConnectionState.waiting:
                                                    return CircularProgressIndicator();
                                                  default:
                                                    if (snapshot.hasError) {
                                                      return Text(
                                                          'Error: ${snapshot.error}');
                                                    } else {
                                                      dropListaresiduo =
                                                          getResiduo(
                                                              snapshot.data);
                                                      return Card(
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              100,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              50,
                                                          constraints:
                                                              BoxConstraints(
                                                                  minWidth: 185,
                                                                  minHeight:
                                                                      185),
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 2.0,
                                                                  bottom: 2.0,
                                                                  left: 2,
                                                                  right: 2),
                                                          child: DropdownButton<
                                                              TipoResiduo>(
                                                            hint: Text(
                                                              "Tipo de Residuo",
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          46,
                                                                          99,
                                                                          238,
                                                                          1),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18),
                                                            ),
                                                            style: const TextStyle(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        46,
                                                                        99,
                                                                        238,
                                                                        1),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 15),
                                                            underline:
                                                                Container(
                                                              height: 2,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      46,
                                                                      99,
                                                                      238,
                                                                      1),
                                                            ),
                                                            value:
                                                                selectResiduo,
                                                            items:
                                                                dropListaresiduo,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectResiduo =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                }
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 25),
                                    MaterialButton(
                                        height: 50,
                                        minWidth: 150,
                                        color: Color.fromRGBO(46, 99, 238, 1),
                                        textColor: Colors.white,
                                        child: new Text(
                                          "Añadir al Carro de Donacion",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        onPressed: () async {
                                          if (formKey.currentState.validate()) {
                                            formKey.currentState.save();
                                            print(selectResiduo.idtiporesiduo);

                                            NuevaDonacion nuevaDonacion =
                                                NuevaDonacion(
                                                    selectResiduo.idtiporesiduo
                                                        .toInt(),
                                                    _email);

                                            this
                                                .carroDonacionesDataSourceImpl
                                                .crearDonacion(nuevaDonacion)
                                                .then((value) {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title: Text(
                                                    "Residuo Agregado",
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          46, 99, 238, 1),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  content: Text(
                                                    "El Residuo se Agrego Exitosamente",
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text(
                                                        'Ok',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              46, 99, 238, 1),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        CarrodeDonacionCivil()));
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text(
                                                        'Donar Mas',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              46, 99, 238, 1),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).onError((error, stackTrace) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) => DialogBox(
                                                      "Error al guardar la venta",
                                                      error.toString()));
                                            });
                                          }
                                        })
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                }
              })
        ],
      ),
    );
  }
}
