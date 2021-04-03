import 'package:flutter/material.dart';
import 'package:reciclaje_app/widgets/navbarCiudadanoCivil.dart';

import '../core/constants.dart';

class InicioCiudadanoCivil extends StatefulWidget {
  InicioCiudadanoCivil({Key key}) : super(key: key);

  @override
  _InicioCiudadanoCivilState createState() => _InicioCiudadanoCivilState();
}

class _InicioCiudadanoCivilState extends State<InicioCiudadanoCivil> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarCiudadanoCivil(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Ciudadano Civil",
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
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  new Text(
                    "Bienvenido",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                  SizedBox(
                    height: 180,
                  ),
                  _card1(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _card1() {
    return Column(
      children: [
        Card(
          elevation: 5,
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            height: MediaQuery.of(context).size.height / 8,
            constraints: BoxConstraints(minHeight: 100, maxHeight: 100),
            padding:
                EdgeInsets.only(top: 30.0, bottom: 10.0, left: 10, right: 10),
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
                  child: new Text(
                    "Donar Residuos",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color.fromRGBO(46, 99, 238, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  onPressed: () =>
                      Navigator.pushNamed(context, donacionFormCivil),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
