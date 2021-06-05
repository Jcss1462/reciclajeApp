import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:reciclaje_app/core/constants.dart';
import 'package:reciclaje_app/page/index.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Color.fromRGBO(46, 99, 238, 1),
            child: Column(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
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
              Icons.shop_outlined,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Venta de Residuos",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            onTap: () {
              Navigator.pushNamed(context, ventasForm);
            },
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
              "Visitas a Clientes",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            onTap: () {
              Navigator.pushNamed(context, visitaClientesMap);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.view_list_outlined,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Visitas Disponibles",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            onTap: () {
              Navigator.pushNamed(context, visitaDisponibles);
            },
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
            onTap: () {
              Navigator.pushNamed(context, rutadelDia);
            },
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
            onTap: () {
              Navigator.pushNamed(context, carrodeVentas);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.campaign_outlined,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Donaciones En Espera",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 20),
            ),
            onTap: () {
              Navigator.pushNamed(context, donacionesenEspera);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.view_agenda_outlined,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Visitas Agendadas",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 20),
            ),
            onTap: () {
              Navigator.pushNamed(context, visitaAgendada);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.money_off,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Ofertas",
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
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InicioReciclador()));
            },
          ),
        ],
      ),
    );
  }
}
