import 'package:flutter/material.dart';
import 'package:reciclaje_app/data/datasources/carroVenta_datasource.dart';
import 'package:reciclaje_app/data/model/ventaList.dart';
import 'package:reciclaje_app/widgets/navbar.dart';

class CarroDeVentas extends StatefulWidget {
  //recibo el parametro
  final String email;
  CarroDeVentas(this.email);

  @override
  _CarroDeVentasState createState() => _CarroDeVentasState();
}

class _CarroDeVentasState extends State<CarroDeVentas> {
  //variables de conexion
  String _email;
  CarroVentasDataSourceImpl carroVentasDataSourceImpl =
      new CarroVentasDataSourceImpl();
  VentasList ventas = new VentasList();
  @override
  void initState() {
    super.initState();
    //obtengo el id del usuario
    _email = this.widget.email;
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
          "Carro de Ventas",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: new Stack(
        children: <Widget>[
          //imagen de fondo
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          new Center(
            child: FutureBuilder(
                future: getListVentas(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                                      itemCount: this.ventas.ventas.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Column(children: [
                                          Card(
                                            elevation: 5,
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  50,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  5,
                                              //tamaño minimo de altura
                                              constraints: BoxConstraints(
                                                minWidth: 185,
                                                minHeight: 185,
                                              ),
                                              padding: EdgeInsets.only(
                                                  top: 30.0,
                                                  bottom: 30.0,
                                                  left: 40,
                                                  right: 40),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.25),
                                                    spreadRadius: 5,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Tipo de Residuo: ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    46,
                                                                    99,
                                                                    238,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Papel",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
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
                                                    SizedBox(height: 5),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Peso en Kilogramos: ",
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    46,
                                                                    99,
                                                                    238,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        Text(
                                                          ventas.ventas[index]
                                                              .peso
                                                              .toString(),
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    46,
                                                                    99,
                                                                    238,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Total del Residuo: ",
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    46,
                                                                    99,
                                                                    238,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        Text(
                                                          ventas.ventas[index]
                                                              .total
                                                              .toString(),
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    46,
                                                                    99,
                                                                    238,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            IconButton(
                                                                icon: Icon(
                                                                  Icons
                                                                      .edit_outlined,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          46,
                                                                          99,
                                                                          238,
                                                                          1),
                                                                ),
                                                                onPressed:
                                                                    null),
                                                            Icon(
                                                              Icons
                                                                  .check_box_outlined,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      46,
                                                                      99,
                                                                      238,
                                                                      1),
                                                            ),
                                                            //boton eliminar
                                                            IconButton(
                                                                icon: Icon(
                                                                  Icons
                                                                      .delete_outline,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          46,
                                                                          99,
                                                                          238,
                                                                          1),
                                                                ),
                                                                onPressed: () {
                                                                  print(ventas
                                                                      .ventas[
                                                                          index]
                                                                      .idventa);
                                                                  this
                                                                      .carroVentasDataSourceImpl
                                                                      .delVenta(ventas
                                                                          .ventas[
                                                                              index]
                                                                          .idventa)
                                                                      .then(
                                                                          (value) {
                                                                    setState(
                                                                        () {});
                                                                  });
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
                                          SizedBox(height: 25),
                                        ]);
                                      })
                                ]))));
                      }
                  }
                }),
          ),
        ],
      ),
    );
  }
}
