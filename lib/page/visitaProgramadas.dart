import 'package:flutter/material.dart';
import 'package:reciclaje_app/widgets/navbar.dart';

class VisitaProgramadas extends StatefulWidget {
  const VisitaProgramadas({Key key}) : super(key: key);

  @override
  _VisitaProgramadasState createState() => _VisitaProgramadasState();
}

class _VisitaProgramadasState extends State<VisitaProgramadas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(46, 99, 238, 1),
          title: Text(
            "Lista de Visitas Programadas",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: new Stack(children: <Widget>[
          new Container(
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/fondo.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ]));
  }
}
