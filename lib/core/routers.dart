import 'package:reciclaje_app/page/index.dart';
import 'package:flutter/material.dart'
    
show Center, MaterialPageRoute, Route, RouteSettings, Scaffold, Text;
import 'constants.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case intialRoute:
        return MaterialPageRoute(builder: (_) => Login());
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
