import 'package:flutter/material.dart';
import 'package:reciclaje_app/data/datasources/carroVenta_datasource.dart';
import 'package:reciclaje_app/data/model/nuevaVenta.dart';
import 'package:reciclaje_app/data/model/tipoResiduo.dart';
import 'package:reciclaje_app/data/model/tipoResiduoList.dart';
import 'package:reciclaje_app/page/carrodeVentas.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/dialogBox.dart';
import 'package:reciclaje_app/widgets/navbarCentrodeAcopio.dart';
import 'package:intl/intl.dart';

class OfertasCentrosdeAcopio extends StatefulWidget {
  const OfertasCentrosdeAcopio({Key key}) : super(key: key);

  @override
  _OfertasCentrosdeAcopioState createState() => _OfertasCentrosdeAcopioState();
}

class _OfertasCentrosdeAcopioState extends State<OfertasCentrosdeAcopio> {
  //variables de conexion
  Preferences preferencias = new Preferences();
  String _email;
  double precio;
  double cupos;
  final oCcy = new NumberFormat("#,##0.00", "en_US");
  final formKey = GlobalKey<FormState>();

  CarroVentasDataSourceImpl carroVentasDataSourceImpl =
      new CarroVentasDataSourceImpl();

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
      drawer: NavBarCentrodeAcopio(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Centro de Acopio",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CarroDeVentas()));
              }),
          IconButton(
              icon: Icon(Icons.logout_outlined, color: Colors.white),
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
                                    "Formulario de Oferta",
                                    style: TextStyle(
                                        color: Color.fromRGBO(46, 99, 238, 1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 27),
                                  ),
                                  SizedBox(height: 20),
                                  Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        //Campos
                                        Container(
                                            height: 70,
                                            //Tipo de residuo
                                            child: FutureBuilder(
                                                future: listadeResiduos,
                                                builder: (BuildContext context,
                                                    AsyncSnapshot snapshot) {
                                                  switch (snapshot
                                                      .connectionState) {
                                                    //mientras espera
                                                    case ConnectionState
                                                        .waiting:
                                                      return CircularProgressIndicator();
                                                    default:
                                                      if (snapshot.hasError) {
                                                        return Text(
                                                            'Error: ${snapshot.error}');
                                                      } else {
                                                        //obtengo la lista de residuos
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
                                                              minHeight: 185,
                                                            ),
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 2.0,
                                                                    bottom: 2.0,
                                                                    left: 2,
                                                                    right: 2),
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
                                                                          0.25),
                                                                  spreadRadius:
                                                                      2,
                                                                  offset:
                                                                      Offset(
                                                                          0, 3),
                                                                ),
                                                              ],
                                                            ),
                                                            child:
                                                                DropdownButton<
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
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                              elevation: 5,
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
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  selectResiduo =
                                                                      value;
                                                                  //actualizo el precio
                                                                  if (precio ==
                                                                          0 ||
                                                                      precio ==
                                                                          null) {
                                                                    precio = 0;
                                                                  } else {
                                                                    precio =
                                                                        precio;
                                                                  }
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                  }
                                                })),

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
                                                      "Ingrese el precio de oferta",
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
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  new Container(
                                    child: TextFormField(
                                        initialValue: cupos != null
                                            ? cupos.toString()
                                            : "",
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText:
                                                "Ingrese los cupos limitados",
                                            contentPadding: EdgeInsets.all(11),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      46, 99, 238, 1),
                                                  width: 0.5,
                                                ))),

                                        //Validacion
                                        onSaved: (value) {
                                          cupos = double.parse(value);
                                          //actualizo el precio
                                          if (cupos == 0) {
                                            cupos = 0;
                                          } else if (selectResiduo == null) {
                                            cupos = 0;
                                          } else {
                                            cupos = cupos;
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
                                  SizedBox(height: 25),
                                  MaterialButton(
                                    height: 50,
                                    minWidth: 150,
                                    color: Color.fromRGBO(46, 99, 238, 1),
                                    textColor: Colors.white,
                                    child: new Text(
                                      "Realizar Oferta",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (formKey.currentState.validate()) {
                                        formKey.currentState.save();
                                        print(precio);
                                        //valido que se seleccionara el tipo
                                        if (selectResiduo == null) {
                                          showDialog(
                                              context: context,
                                              builder: (context) => DialogBox(
                                                  "Error",
                                                  "Debes de seleccionar el tipo de residuo"));
                                        } else {
                                          //gurado la venta
                                          NuevaVenta nuevaVenta = NuevaVenta(
                                              cupos,
                                              precio,
                                              _email,
                                              selectResiduo.idtiporesiduo);
                                          this
                                              .carroVentasDataSourceImpl
                                              .crearVenta(nuevaVenta)
                                              .then((value) {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text(
                                                  "Oferta Agregada",
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        46, 99, 238, 1),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                content: Text(
                                                    "La Oferta se Agrego Exitosamente"),
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
                                                              builder: (context) =>
                                                                  CarroDeVentas()));
                                                    },
                                                  ),
                                                  TextButton(
                                                      child: Text(
                                                        'Vender Más',
                                                        style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              46, 99, 238, 1),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      }),
                                                ],
                                              ),
                                            );
                                          }).onError((error, stackTrace) {
                                            showDialog(
                                                context: context,
                                                builder: (context) => DialogBox(
                                                    "Error al guardar la oferta",
                                                    error.toString()));
                                          });
                                        }
                                      }
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
              }),
        ],
      ),
    );
  }
}
