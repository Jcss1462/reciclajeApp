import 'package:flutter/material.dart';
import 'package:reciclaje_app/core/constants.dart';

import '../core/constants.dart';

class NavBar extends StatelessWidget {
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
              Icons.shop,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Venta de Residuos",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            onTap: () => Navigator.pushNamed(context, carrodeVentas),
          ),
          ListTile(
            leading: Icon(
              Icons.monetization_on_outlined,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Precios Estandares",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(
              Icons.map_outlined,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Visitas a Civiles",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(
              Icons.alt_route,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Ruta del Dia",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(
              Icons.point_of_sale_sharp,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Estadistica de Ventas",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_cart_outlined,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Carro de Ventas",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(
              Icons.campaign_outlined,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Solicitudes Agendadas",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 20),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(
              Icons.dialer_sip_outlined,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Visitas Agendadas",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 20),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Icon(
              Icons.money_off,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "ofertas",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 20),
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