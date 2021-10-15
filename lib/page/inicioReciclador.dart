import 'package:flutter/material.dart';
import 'package:reciclaje_app/core/constants.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/NavBar.dart';
import 'package:reciclaje_app/widgets/dialogBox.dart';

class InicioReciclador extends StatefulWidget {
  InicioReciclador({Key key}) : super(key: key);

  @override
  _InicioRecicladorState createState() => _InicioRecicladorState();
}

class _InicioRecicladorState extends State<InicioReciclador> {
  final formKey = GlobalKey<FormState>();

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
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Bienvenido",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 5,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 80,
                        height: MediaQuery.of(context).size.height / 8,
                        constraints:
                            BoxConstraints(minHeight: 80, maxHeight: 80),
                        padding: EdgeInsets.only(
                            top: 15.0, bottom: 10.0, left: 10, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.25),
                                spreadRadius: 5,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: Column(
                          children: [
                            MaterialButton(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.map_outlined,
                                      color: Color.fromRGBO(46, 99, 238, 1),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    new Text(
                                      "Visitas a Clientes",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color.fromRGBO(46, 99, 238, 1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () => Navigator.pushNamed(
                                  context, visitaClientesMap),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 5,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 80,
                        height: MediaQuery.of(context).size.height / 8,
                        constraints:
                            BoxConstraints(minHeight: 80, maxHeight: 80),
                        padding: EdgeInsets.only(
                            top: 15.0, bottom: 10.0, left: 10, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.25),
                                spreadRadius: 5,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: Column(
                          children: [
                            MaterialButton(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.alt_route,
                                      color: Color.fromRGBO(46, 99, 238, 1),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    new Text(
                                      "Ruta del Día",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color.fromRGBO(46, 99, 238, 1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () =>
                                  Navigator.pushNamed(context, rutadelDia),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 5,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 80,
                        height: MediaQuery.of(context).size.height / 8,
                        constraints:
                            BoxConstraints(minHeight: 80, maxHeight: 80),
                        padding: EdgeInsets.only(
                            top: 15.0, bottom: 10.0, left: 10, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.25),
                                spreadRadius: 5,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: Column(
                          children: [
                            MaterialButton(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shop_outlined,
                                      color: Color.fromRGBO(46, 99, 238, 1),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    new Text(
                                      "Venta de Residuos",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color.fromRGBO(46, 99, 238, 1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () =>
                                  Navigator.pushNamed(context, ventasForm),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 5,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 80,
                        height: MediaQuery.of(context).size.height / 8,
                        constraints:
                            BoxConstraints(minHeight: 80, maxHeight: 80),
                        padding: EdgeInsets.only(
                            top: 15.0, bottom: 10.0, left: 10, right: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.25),
                                spreadRadius: 5,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: Column(
                          children: [
                            MaterialButton(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.money_off,
                                      color: Color.fromRGBO(46, 99, 238, 1),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    new Text(
                                      "Ofertas",
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Color.fromRGBO(46, 99, 238, 1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () => Navigator.pushNamed(
                                  context, listadeOfertasReciclador),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
