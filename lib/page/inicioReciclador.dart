import 'package:flutter/material.dart';
import 'package:reciclaje_app/widgets/NavBar.dart';

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
                "Ventas de la Semana",
                style: TextStyle(
                    color: Color.fromRGBO(46, 99, 238, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Papel 10 Kg",
                style: TextStyle(
                    color: Color.fromRGBO(46, 99, 238, 1),
                    fontWeight: FontWeight.normal,
                    fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Vidrio 20 Kg",
                style: TextStyle(
                    color: Color.fromRGBO(46, 99, 238, 1),
                    fontWeight: FontWeight.normal,
                    fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Cartón 20 Kg",
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
                "Numero de Lugares Visitados",
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
