import 'package:flutter/material.dart';
import 'package:reciclaje_app/data/datasources/carroVenta_datasource.dart';
import 'package:reciclaje_app/data/model/ventas.dart';
import 'package:reciclaje_app/page/carrodeVentas.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/navbar.dart';

class PageEditar extends StatefulWidget {
  //recibo el parametro
  final int idVenta;
  PageEditar(this.idVenta);

  @override
  _PageEditarState createState() => _PageEditarState();
}

class _PageEditarState extends State<PageEditar> {
  Preferences preferencias = new Preferences();
  int _idventa;

  final formKey = GlobalKey<FormState>();
  CarroVentasDataSourceImpl carroVentasDataSourceImpl =
      new CarroVentasDataSourceImpl();

  double peso;
  double total;

  Ventas ventas;
  Future<Ventas> getInfoVentas() async {
    return await this.carroVentasDataSourceImpl.findByIdVentas(_idventa);
  }

  @override
  void initState() {
    super.initState();
    //obtengo el id de la venta
    _idventa = this.widget.idVenta;
    print("idventa: " + _idventa.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(46, 99, 238, 1),
          title: Text(
            "Reciclador Oficial",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CarroDeVentas()));
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
            new Center(
              child: FutureBuilder(
                future: getInfoVentas(),
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
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Edicion de Venta",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      Card(
                                        elevation: 5,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5,
                                          constraints: BoxConstraints(
                                            minWidth: 150,
                                            minHeight: 150,
                                          ),
                                          padding: EdgeInsets.only(
                                              top: 20.0,
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
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            46, 99, 238, 1),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    Text(
                                                      ventas.tipo.toString(),
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            46, 99, 238, 1),
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                  }
                },
              ),
            ),
          ],
        ));
  }
}
