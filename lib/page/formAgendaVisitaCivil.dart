import 'package:flutter/material.dart';

class FormAgendaVisitaCivil extends StatefulWidget {
  const FormAgendaVisitaCivil({Key key}) : super(key: key);
  @override
  _FormAgendaVisitaCivilState createState() => _FormAgendaVisitaCivilState();
}

class _FormAgendaVisitaCivilState extends State<FormAgendaVisitaCivil> {
  final fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
