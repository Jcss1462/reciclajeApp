import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  GoogleMapController googleMapController;
  List<Coordinates> coordinates = [];
  Map<MarkerId, Marker> markers = {};

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

  getCoordenadas(String address) async {
    var coordenadas = await Geocoder.local.findAddressesFromQuery(address);
    var direcion = coordenadas.first;
    coordinates.add(direcion.coordinates);
    print(direcion.coordinates);
    print(coordinates);
    return coordinates;
  }

  bool reload = false;
  void initMarker() async {
    for (var i = 0; i < coordinates.length; i++) {
      final MarkerId markerId = MarkerId(markers.length.toString());
      LatLng markerPos =
          LatLng(coordinates[i].latitude, coordinates[i].longitude);
      final Marker marker = Marker(
        icon: BitmapDescriptor.defaultMarker,
        markerId: markerId,
        position: markerPos,
      );
      markers[markerId] = marker;
    }
    //Control para evitar el ciclo infinito
    if (reload == false) {
      setState(() {
        reload = true;
      });
    }
  }

  getMakerData() async {
    coordinates.clear();
    return await recoleccionDonacionDataSourceImpl
        .recicladorCarrosAsignados(_email)
        .then((value) {
      if (value.solicitudes.length != 0) {
        for (int i = 0; i < value.solicitudes.length; i++) {
          getCoordenadas(value.solicitudes[i].direccionRecoleccion);
        }
        initMarker();
      }
    });
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
                              future: getMakerData(),
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
                                      return Stack(
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: GoogleMap(
                                              markers: Set<Marker>.of(
                                                  markers.values),
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
                                                      zoom: 10),
                                              onMapCreated: (GoogleMapController
                                                  controller) {
                                                controller = controller;
                                              },
                                            ),
                                          )
                                        ],
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
