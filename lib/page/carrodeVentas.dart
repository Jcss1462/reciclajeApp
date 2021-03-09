import 'package:flutter/material.dart';
import 'package:reciclaje_app/widgets/NavBar.dart';

class CarrodeVentas extends StatefulWidget {
  CarrodeVentas({Key key}) : super(key: key);

  @override
  _CarrodeVentasState createState() => _CarrodeVentasState();
}

class _CarrodeVentasState extends State<CarrodeVentas> {
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
    );
  }
}
