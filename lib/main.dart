import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reciclaje_app/core/routers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reciclaje_app/data/network/api_provider.dart';
import 'package:reciclaje_app/service/authentication_service.dart';
import 'package:reciclaje_app/page/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DotEnv.load(fileName: ".env");
  runApp(ReciclajeApp());
}

class ReciclajeApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  ReciclajeApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AutenticationService>(
          create: (_) => AutenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AutenticationService>().authStateChanges,
          initialData: null,
        ),
        Provider<ApiProvider>(
          create: (_) => ApiProvider(),
        ),
      ],
      child: MaterialApp(
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
            if (snapshot.hasError) {
              print(
                  'Error de inicializacion con firebase ${snapshot.error.toString()}');
              return Text('Error de inicializacion con firebase');
            } else if (snapshot.hasData) {
              return Login();
            } else {
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
