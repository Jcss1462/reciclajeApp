import 'package:flutter/material.dart';
import '../core/constants.dart';

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
              "Agendar Visita",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            onTap: () {
              Navigator.pushNamed(context, formAgendaVisitaCivil);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.perm_contact_calendar_outlined,
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
              Icons.shop_outlined,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Donar Residuo",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            onTap: () {
              Navigator.pushNamed(context, donacionFormCivil);
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
            onTap: () {
              Navigator.pushNamed(context, carrodeDonacionCivil);
            },
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
              Navigator.pushNamed(context, inicioCiudadanoCivil);
            },
          ),
          
          SizedBox(
            height: 250,
          ),
          Container(
            width: double.infinity,
            padding:
                EdgeInsets.only(top: 20.0, bottom: 30.0, left: 20, right: 20),
            color: Color.fromRGBO(46, 99, 238, 1),
            child: Column(
              children: <Widget>[
                TextButton(
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 23),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  title: Text(
                                    "Cerrar Sesión",
                                    style: TextStyle(
                                      color: Color.fromRGBO(46, 99, 238, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  content: Text(
                                    "Esta seguro que desea cerrar la sesión",
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text(
                                        'Ok',
                                        style: TextStyle(
                                          color: Color.fromRGBO(46, 99, 238, 1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      onPressed: null,
                                    ),
                                    TextButton(
                                      child: Text(
                                        "Cancelar",
                                        style: TextStyle(
                                          color: Color.fromRGBO(46, 99, 238, 1),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ]));
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
