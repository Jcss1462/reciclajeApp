import 'package:flutter/material.dart';

class NavBarCiudadanoCivil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Color.fromRGBO(46, 99, 238, 1),
            child: Column(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                ),
                Text(
                  "Menú Principal",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_today_outlined,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Visita Agendada",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            onTap: () {
              Navigator.pushNamed(context, null);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_cart_outlined,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Carro de Donacion",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(
              Icons.home_outlined,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Home",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            onTap: null,
          ),
        ],
      ),
    );
  }
}
