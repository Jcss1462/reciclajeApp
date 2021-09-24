import 'package:flutter/material.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/dialogBox.dart';
import '../core/constants.dart';

class NavBarCentrodeAcopio extends StatelessWidget {
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
              Icons.monetization_on_outlined,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Ofertas de Residuos",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            onTap: () {
              Navigator.pushNamed(context, fromOfertasCentrodeAcopio);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.shop_outlined,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Carro de Ofertas",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            onTap: () {
              Navigator.pushNamed(context, carrodeOfertas);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_today_outlined,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Agenda",
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
              Icons.note_alt_outlined,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Solicitudes Aceptadas",
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
              Icons.logout,
              color: Color.fromRGBO(46, 99, 238, 1),
            ),
            title: Text(
              "Log Out",
              style: TextStyle(
                  color: Color.fromRGBO(46, 99, 238, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 18),
            ),
            onTap: () {
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
                                onPressed: () {
                                  //eliminamos todas las preferencias y re dirigimos a Login
                                  Preferences preferences = new Preferences();
                                  preferences
                                      .eliminarPreferencias()
                                      .then((value) {
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst);
                                  }).onError((error, stackTrace) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => DialogBox(
                                          "Error al cerrar sesión",
                                          error.toString()),
                                    );
                                  });
                                }),
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
            },
          ),
        ],
      ),
    );
  }
}
