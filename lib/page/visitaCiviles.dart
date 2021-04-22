import 'package:flutter/material.dart';
import 'package:reciclaje_app/widgets/navbar.dart';

class VisitaCiviles extends StatefulWidget {
  @override
  _VisitaCivilesState createState() => _VisitaCivilesState();
}

class _VisitaCivilesState extends State<VisitaCiviles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Visita a Civiles",
          style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/fondo.png"),
                fit: BoxFit.cover,
                ),
            ),
          )
        ]
      ),
    );
  }
}