import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:reciclaje_app/blocs/application_bloc.dart';
import 'package:reciclaje_app/data/datasources/recoleccionDonacion_datasource.dart';
import 'package:reciclaje_app/data/model/carrodeDonacionList.dart';
import 'package:reciclaje_app/service/preferences.dart';
import 'package:reciclaje_app/widgets/navbar.dart';

class RutadelDia extends StatefulWidget {
  const RutadelDia({Key key}) : super(key: key);
  @override
  _RutadelDiaState createState() => _RutadelDiaState();
}

class _RutadelDiaState extends State<RutadelDia> {
  Preferences preferencias = new Preferences();
  String _email;
  Location location = Location();
  GoogleMapController googleMapController;
  Marker maker;
  Circle circle;
  bool isvisible = true;
  final formKey = GlobalKey<FormState>();
  RecoleccionDonacionDataSourceImpl recoleccionDonacionDataSourceImpl =
      new RecoleccionDonacionDataSourceImpl();
  CarrodeDonacionList solicitudes = new CarrodeDonacionList();

  @override
  void initState() {
    super.initState();
  }

  Future<String> getEmail() async {
    return await preferencias.obtenerEmail().then((value) async {
      _email = value;
      return _email;
    });
  }

  Future<CarrodeDonacionList> getListSolicitudesAgendadas() async {
    return await this
        .recoleccionDonacionDataSourceImpl
        .recicladorCarrosAsignados(_email);
  }

  @override
  Widget build(BuildContext context) {
    final applicationBolc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 99, 238, 1),
        title: Text(
          "Ruta del Dia",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: (applicationBolc.currentLocation == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : new Stack(
              children: <Widget>[
                new Container(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage("assets/images/fondo.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                new Center(
                  child: FutureBuilder(
                    future: getEmail(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return CircularProgressIndicator();
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return FutureBuilder(
                              future: getListSolicitudesAgendadas(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return CircularProgressIndicator();
                                  default:
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      this.solicitudes = snapshot.data;
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        child: Center(
                                          child: GoogleMap(
                                            mapType: MapType.normal,
                                            myLocationEnabled: true,
                                            initialCameraPosition:
                                                CameraPosition(
                                                    target: LatLng(
                                                        applicationBolc
                                                            .currentLocation
                                                            .latitude,
                                                        applicationBolc
                                                            .currentLocation
                                                            .longitude),
                                                    zoom: 20),
                                          ),
                                        ),
                                      );
                                    }
                                }
                              },
                            );
                          }
                      }
                    },
                  ),
                )
              ],
            ),
    );
  }
}
