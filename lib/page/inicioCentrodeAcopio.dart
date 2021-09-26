import 'package:flutter/material.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/dialogBox.dart';
import 'package:reciclaje_app/widgets/navbarCentrodeAcopio.dart';

class InicioCentrodeAcopio extends StatefulWidget {
  const InicioCentrodeAcopio({Key key}) : super(key: key);

  @override
  _InicioCentrodeAcopioState createState() => _InicioCentrodeAcopioState();
}

class _InicioCentrodeAcopioState extends State<InicioCentrodeAcopio> {
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
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _crearCard1(),
                    _crearCard2(),
                    _crearCard3()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearCard1() {
    return Card(
      elevation: 5,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 3.5,
        padding: EdgeInsets.only(top: 30.0, bottom: 30.0, left: 40, right: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Compras Semanales",
                style: TextStyle(
                    color: Color.fromRGBO(46, 99, 238, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Papel 100 Kg",
                style: TextStyle(
                    color: Color.fromRGBO(46, 99, 238, 1),
                    fontWeight: FontWeight.normal,
                    fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Vidrio 120 Kg",
                style: TextStyle(
                    color: Color.fromRGBO(46, 99, 238, 1),
                    fontWeight: FontWeight.normal,
                    fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Cartón 320 Kg",
                style: TextStyle(
                    color: Color.fromRGBO(46, 99, 238, 1),
                    fontWeight: FontWeight.normal,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearCard2() {
    return Card(
      elevation: 5,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 3.5,
        padding: EdgeInsets.only(top: 30.0, bottom: 30.0, left: 40, right: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Precios Actuales",
                style: TextStyle(
                    color: Color.fromRGBO(46, 99, 238, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Papel 1.000 cada Kg",
                style: TextStyle(
                    color: Color.fromRGBO(46, 99, 238, 1),
                    fontWeight: FontWeight.normal,
                    fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Vidrio 2.000 cada Kg",
                style: TextStyle(
                    color: Color.fromRGBO(46, 99, 238, 1),
                    fontWeight: FontWeight.normal,
                    fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Cartón 2.500 cada Kg",
                style: TextStyle(
                    color: Color.fromRGBO(46, 99, 238, 1),
                    fontWeight: FontWeight.normal,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearCard3() {
    return Card(
      elevation: 5,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 6,
        padding: EdgeInsets.only(top: 30.0, bottom: 30.0, left: 40, right: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Numero de Visitas",
                style: TextStyle(
                    color: Color.fromRGBO(46, 99, 238, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "25",
                style: TextStyle(
                    color: Color.fromRGBO(46, 99, 238, 1),
                    fontWeight: FontWeight.normal,
                    fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
