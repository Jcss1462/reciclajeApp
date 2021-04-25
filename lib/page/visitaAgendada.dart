import 'package:flutter/material.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/navbar.dart';

class VisitaAgendada extends StatefulWidget {
  const VisitaAgendada({Key key}) : super(key: key);
  @override
  _VisitaAgendadaState createState() => _VisitaAgendadaState();
}

class _VisitaAgendadaState extends State<VisitaAgendada> {
  Preferences preferencias = new Preferences();
  String _email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Solicitudes Agendadas",
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
        ],
      ),
    );
  }
}
