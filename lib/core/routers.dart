import 'package:reciclaje_app/page/ventasForm.dart';
import 'package:reciclaje_app/page/index.dart';
import 'package:flutter/material.dart'
    show Center, MaterialPageRoute, Route, RouteSettings, Scaffold, Text;
import 'constants.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case intialRoute:
        return MaterialPageRoute(builder: (_) => Login());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => RegistroPage());
      case inicioReciclador:
        return MaterialPageRoute(builder: (_) => InicioReciclador());
      case ventasForm:
        return MaterialPageRoute(builder: (_) => VentasForm());
      case carrodeVentas:
        return MaterialPageRoute(builder: (_) => CarroDeVentas());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('La ruta no esta especificada para ${settings.name}'),
            ),
          ),
        );
    }
  }
}
