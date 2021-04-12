import 'package:flutter/material.dart';
import 'package:reciclaje_app/data/datasources/carroVenta_datasource.dart';
import 'package:reciclaje_app/data/model/tipoResiduo.dart';
import 'package:reciclaje_app/data/model/ventas.dart';
import 'package:reciclaje_app/page/index.dart';
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
  TipoResiduo tipoResiduo;

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
                                )
                              ],
                            ),
                            child: Center(
                              child: SingleChildScrollView(
                                padding: EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 30.0,
                                    left: 40,
                                    right: 40),
                                child: Column(
                                  children: [
                                    Text(
                                      "Edicion de Venta",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color.fromRGBO(46, 99, 238, 1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 27),
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
                                                      ventas.tipo,
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
                                                ),
                                              ],
                                            ),
                                          ),
                                          new Container(
                                            child: TextFormField(
                                              initialValue: peso != null
                                                  ? peso.toString()
                                                  : "",
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  hintText: "Ingrese el Peso",
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
                                              onSaved: (value) {
                                                peso = double.parse(value);
                                                if (peso == 0) {
                                                  total = 0;
                                                } else {
                                                  total = ventas.idventa * peso;
                                                }
                                              },
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return "Ingrese el peso a editar";
                                                } else {
                                                  return null;
                                                }
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    new Column(
                                      children: [
                                        Text(
                                          "Total de Venta del Residuo",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  46, 99, 238, 1),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        SizedBox(height: 25),
                                        Text(
                                          total == null
                                              ? "\$0"
                                              : "\$" + total.toString(),
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  46, 99, 238, 1),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    MaterialButton(
                                      height: 50,
                                      minWidth: 150,
                                      color: Color.fromRGBO(46, 99, 238, 1),
                                      textColor: Colors.white,
                                      child: new Text(
                                        "Editar Ventas",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      onPressed: () async {
                                        formKey.currentState.save();
                                        print(peso);
                                        print(ventas.tipo);
                                        print(total);

                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text(
                                              "Residuo Editado",
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    46, 99, 238, 1),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            content: Text(
                                                "El Residuo se Editado Exitosamente"),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text(
                                                  'Ok',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        46, 99, 238, 1),
                                                    fontWeight: FontWeight.bold,
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
                                                    'Cancelar',
                                                    style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          46, 99, 238, 1),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PageEditar(ventas
                                                                .idventa));
                                                  }),
                                            ],
                                          ),
                                        );
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
              ),
            ),
          ],
        ));
  }
}
