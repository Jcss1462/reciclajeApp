import 'package:flutter/material.dart';
import 'package:reciclaje_app/core/constants.dart';
import 'package:reciclaje_app/core/routers.dart';
import  'package:firebase_core/firebase_core.dart';
import  'package:reciclaje_app/page/index.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ReciclajeApp());
}

class ReciclajeApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp=  Firebase.initializeApp();
  ReciclajeApp({Key key}) : super(key: key);
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
        //valido la coneccion con firebase
        home: FutureBuilder(
          future: _fbApp,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError){
              print('Error de inicializacion con firebase ${snapshot.error.toString()}');
              return Text('Error de inicializacion con firebase');
            }else if (snapshot.hasData){
              return Login();
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            } 
          },
        ),
      ),
    );
  }
}
