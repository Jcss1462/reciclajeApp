import 'package:flutter/material.dart';
import 'package:reciclaje_app/data/datasources/carroVenta_datasource.dart';
import 'package:reciclaje_app/data/datasources/ofertas_datasource.dart';
import 'package:reciclaje_app/data/model/tipoResiduo.dart';
import 'package:reciclaje_app/data/model/tipoResiduoList.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:intl/intl.dart';

class RecuperarContrasena extends StatefulWidget {
  const RecuperarContrasena({Key key}) : super(key: key);

  @override
  _RecuperarContrasenaState createState() => _RecuperarContrasenaState();
}

class _RecuperarContrasenaState extends State<RecuperarContrasena> {
  //variables de conexion
  Preferences preferencias = new Preferences();
  String _email;
  double precio;
  int cupos;
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  final formKey = GlobalKey<FormState>();

  CarroVentasDataSourceImpl carroVentasDataSourceImpl =
      new CarroVentasDataSourceImpl();

  OfertasDatasourceImpl ofertasDatasourceImpl = new OfertasDatasourceImpl();

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
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Recuperar Contraseña",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
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
                          height: MediaQuery.of(context).size.height / 1.8,
                          constraints: BoxConstraints(
                            minWidth: 160,
                            minHeight: 160,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.25),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            //Formulario
                            child: SingleChildScrollView(
                              padding: EdgeInsets.only(
                                  top: 5.0, bottom: 30.0, left: 40, right: 40),
                              child: Column(
                                children: [
                                  Text(
                                    "Recuperar Contraseña",
                                    style: TextStyle(
                                      color: Color.fromRGBO(46, 99, 238, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        //Cantidad del residuo
                                        SizedBox(height: 15),
                                        new Container(
                                          child: TextFormField(
                                              initialValue: precio != null
                                                  ? precio.toString()
                                                  : "",
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  hintText:
                                                      "Ingrese la nueva Contraseña",
                                                  contentPadding:
                                                      EdgeInsets.all(11),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0),
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                Color.fromRGBO(
                                                                    46,
                                                                    99,
                                                                    238,
                                                                    1),
                                                            width: 0.5,
                                                          ))),

                                              //Validacion
                                              onSaved: (value) {
                                                precio = double.parse(value);
                                                //actualizo el precio
                                                if (precio == 0) {
                                                  precio = 0;
                                                } else if (selectResiduo ==
                                                    null) {
                                                  precio = 0;
                                                } else {
                                                  precio = precio;
                                                }
                                              },
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return "LLenar el campo";
                                                } else {
                                                  return null;
                                                }
                                              }),
                                        ),
                                        SizedBox(height: 15),
                                        new Container(
                                          child: TextFormField(
                                              initialValue: cupos != null
                                                  ? cupos.toString()
                                                  : "",
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  hintText:
                                                      "Confirma la contraseña",
                                                  contentPadding:
                                                      EdgeInsets.all(11),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0),
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                                Color.fromRGBO(
                                                                    46,
                                                                    99,
                                                                    238,
                                                                    1),
                                                            width: 0.5,
                                                          ))),

                                              //Validacion
                                              onSaved: (value) {
                                                cupos = int.parse(value);
                                                //actualizo el precio
                                                if (cupos == 0) {
                                                  cupos = 0;
                                                } else if (selectResiduo ==
                                                    null) {
                                                  cupos = 0;
                                                } else {
                                                  cupos = cupos;
                                                  print(cupos);
                                                }
                                              },
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return "LLenar el campo";
                                                } else {
                                                  return null;
                                                }
                                              }),
                                        ),
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
                                        "Recuperar Contraseña",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      onPressed: () {})
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                }
              }),
        ],
      ),
    );
  }
}
