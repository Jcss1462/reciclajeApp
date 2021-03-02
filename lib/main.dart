import 'package:flutter/material.dart';
import 'package:reciclaje_app/core/constants.dart';
import 'package:reciclaje_app/core/routers.dart';
void main() {
  runApp(ReciclajeApp());
}

class ReciclajeApp extends StatelessWidget {
  const ReciclajeApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  MaterialApp(
        title: 'ReciclajeApp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(     
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Montserrat',
          scaffoldBackgroundColor: Colors.white,
        ),
        onGenerateRoute: Routers.generateRoute,
        initialRoute: intialRoute,
      ),
    );
  }
}
