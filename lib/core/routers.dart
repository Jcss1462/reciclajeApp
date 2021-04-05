import 'package:reciclaje_app/page/formAgendaVisitaCivil.dart';
import 'package:reciclaje_app/page/carrodeDonacionCivil.dart';
import 'package:reciclaje_app/page/donacionFormCivil.dart';
import 'package:reciclaje_app/page/inicioCiudadanoCivil.dart';
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
      case inicioCiudadanoCivil:
        return MaterialPageRoute(builder: (_) => InicioCiudadanoCivil());
      case donacionFormCivil:
        return MaterialPageRoute(builder: (_) => DonacionFormCivil());
      case carrodeDonacionCivil:
        return MaterialPageRoute(builder: (_) => CarrodeDonacionCivil());
      case formAgendaVisitaCivil:
        return MaterialPageRoute(builder: (_) => FormAgendaVisitaCivil());
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
