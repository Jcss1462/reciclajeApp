import 'package:flutter/material.dart';
import 'package:reciclaje_app/widgets/navbar.dart';

class EnvioCarrodeVentas extends StatefulWidget {
  @override
  _EnvioCarrodeVentasState createState() => _EnvioCarrodeVentasState();
}

class _EnvioCarrodeVentasState extends State<EnvioCarrodeVentas> {
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
                  fit: BoxFit.cover),
            ),
          )
        ],
      ),
    );
  }
}
